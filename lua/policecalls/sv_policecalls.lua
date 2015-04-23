resource.AddWorkshop( "417155530" )
util.AddNetworkString( "PoliceCallNet" )
util.AddNetworkString( "CallP" )

local function inGroup( gtab, ply, gid )
	for _,g in pairs( gtab ) do
		if not isfunction( g ) then
			if gid == nil then
				gid = ply:Team()
			end
			if _G[g] ~= nil and _G[g] == gid then
				return true
			end
		else
			if tobool( g(ply) ) then
				return true
			end
		end
	end
	return false
end

local function splitInput( str )
	local startPos, endPos = string.find( str, "%s+" )
	if startPos == nil or endPos == nil then return end
	return string.sub(str, 1, startPos - 1), string.sub(str, endPos + 1)
end

local copson = false

hook.Add( "OnPlayerChangedTeam", "PoliceOfficersQuestionmark", function( ply, oldt, newt )
	if newt == oldt or not IsValid(ply) then return end
	
	local newtAllowed, oldtAllowed = inGroup( PPC.AllowedTeams, ply, newt ), inGroup( PPC.AllowedTeams, ply, oldt )
	if not newtAllowed and not oldtAllowed then return end
	
	if newtAllowed or ( oldtAllowed and team.NumPlayers( oldt ) ~= 0 ) then
		copson = true
	else
		copson = false
	end
end )

hook.Add( "PlayerSay", "911Calls", function( ply, str )
	local cmd, msg = splitInput( str )
	if cmd and table.HasValue( PPC.ChatCommands, cmd ) then
		if not PPC.AllowPrivileged and inGroup( PPC.AllowedTeams, ply ) then
			ply:PrintMessage(HUD_PRINTTALK, PPC:Translate( "onlyNonPrivileged" ))
			return ""
		end
		if not PPC.AllowArrested and ply:isArrested() then
			ply:PrintMessage(HUD_PRINTTALK, PPC:Translate( "onlyNonArrested" ))
			return ""
		end
		if ply.lasttimeused then
			if ply.lasttimeused + PPC.MessageCD > CurTime() then
				local waittime = PPC.MessageCD - math.floor( CurTime() - ply.lasttimeused )
				ply:PrintMessage(HUD_PRINTTALK, PPC:Translate( "spamProtect", tostring( waittime ) ))
				return ""
			end
		end
		if msg:len() >= PPC.MinMsgLength and msg:len() <= PPC.MaxMsgLength then
			if copson then
				for _,pply in pairs( player.GetAll() ) do
					if IsValid(pply) and pply ~= ply and inGroup( PPC.AllowedTeams, pply ) then
						net.Start( "PoliceCallNet" )
							net.WriteString( msg )
							net.WriteEntity( ply )
						net.Send( pply )
					end
				end
				ply:PrintMessage( HUD_PRINTTALK, PPC:Translate( "reportSent", msg ) )
				ply.lasttimeused = CurTime()
				return ""
			else
				ply:PrintMessage( HUD_PRINTTALK, PPC:Translate( "noOfficers" ) )
				return ""
			end
		else
			ply:PrintMessage( HUD_PRINTTALK, PPC:Translate( "invalidMsgLength", PPC.MinMsgLength, PPC.MaxMsgLength ) )
			return ""
		end
	end
end )


net.Receive( "CallP", function(len, ply)
	local plycall = net.ReadEntity()
	if not IsValid(plycall) or not IsValid(ply) then return end
	if tobool(net.ReadBit()) then
		ply:Say("/g " .. PPC:Translate( "respOfficer", plycall:Nick() ), false)
	else
		ply:Say("/g " .. PPC:Translate( "busyOfficer", plycall:Nick() ), false)
	end
end )
