util.AddNetworkString( "PoliceCallNet" )
util.AddNetworkString( "CallP" )

local function inGroup( gtab, gid )
	for _,g in pairs( gtab ) do
		if _G[g] ~= nil and _G[g] == gid then
			return true
		end
	end
	return false
end

local function splitInput( str )
	local startPos, endPos = string.find( str, "%s+" )

	if startPos == nil or startPos == nil then
		return "", ""
	end

	local cmd = string.sub(str, 1, startPos - 1)
	local msg = string.sub(str, endPos + 1)
	return cmd, msg
end

local copson = false

hook.Add( "OnPlayerChangedTeam", "PoliceOfficersQuestionmark", function( ply, oldt, newt )
	if newt == oldt then return end
	
	local newtAllowed, oldtAllowed = inGroup( PPC.AllowedTeams, newt ), inGroup( PPC.AllowedTeams, oldt )
	if not newtAllowed and not oldtAllowed then return end
	
	if newtAllowed or ( oldtAllowed and team.NumPlayers( oldt ) ~= 0 ) then
		copson = true
	else
		copson = false
	end
end )

hook.Add( "PlayerSay", "911Calls", function( ply, str )
	local cmd, msg = splitInput( str )
	if table.HasValue( PPC.ChatCommands, cmd ) then
		if ply.lasttimeused then
			if ply.lasttimeused + PPC.MessageCD > CurTime() then
				local waittime = PPC.MessageCD - math.floor( CurTime() - ply.lasttimeused )
				ply:PrintMessage(HUD_PRINTTALK, PPC:Translate( "spamProtect", tostring( waittime ) ))
				return false
			end
		end
		if msg:len() >= PPC.MinMsgLength and msg:len() <= PPC.MaxMsgLength then
			if copson then
				for _,pply in pairs( player.GetAll() ) do
					if IsValid(pply) and inGroup( PPC.AllowedTeams, pply:Team() ) then
						net.Start( "PoliceCallNet" )
							net.WriteString( msg )
							net.WriteEntity( ply )
						net.Send( pply )
					end
				end
				ply:PrintMessage( HUD_PRINTTALK, PPC:Translate( "reportSent", msg ) )
				ply.lasttimeused = CurTime()
				return false
			else
				ply:PrintMessage( HUD_PRINTTALK, PPC:Translate( "noOfficers" ) )
				return false
			end
		else
			ply:PrintMessage( HUD_PRINTTALK, PPC:Translate( "invalidMsgLength", PPC.MinMsgLength, PPC.MaxMsgLength ) )
			return false
		end
	end
end )


net.Receive( "CallP", function(len, ply)
	local plycall = net.ReadEntity()
	if tobool(net.ReadBit()) then
		ply:Say("/g " .. PPC:Translate( "respOfficer", plycall:Nick() ), false)
	else
		ply:Say("/g " .. PPC:Translate( "busyOfficer", plycall:Nick() ), false)
	end
end )
