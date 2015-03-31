if SERVER then
	util.AddNetworkString( "PoliceCallNet" )
	util.AddNetworkString( "CallP" )
	local copson = 0
	local function OnlineOfficer( ply, oldt, newt )
		for _,team in pairs( PPC.AllowedTeams ) do
 			if _G[team] != nil and newt == _G[team] then
 			copson = 1
 			return
 			end
 		copson = 0
		end
	end
	hook.Add( 'OnPlayerChangedTeam', 'PoliceOfficersQuestionmark', OnlineOfficer )

	local function PoliceCall( ply, msg, in_team )
		if string.match( msg, "/911" ) then
			msg = string.Replace( msg, "/911 ", "")
			if ply.lasttimeused then
				if ply.lasttimeused + PPC.MessageCD > CurTime() then
					local waittime, s = PPC.MessageCD - math.floor( CurTime() - ply.lasttimeused ), ""
					if waittime ~= 1 then s = "s" end
					ply:ChatPrint( "You might want to wait another " ..tostring( waittime ).. " second".. s)
					return false
					end
				end

				if string.len(msg) >= 10 and string.len(msg) <= 24 then
					if copson >= 1 then
					net.Start( "PoliceCallNet" )
						net.WriteString( msg )
						net.WriteEntity( ply )
					net.Send( ply )
						ply:ChatPrint( "You have sent an report to all online officers: "..msg )
						ply.lasttimeused = CurTime()
						return false
					else
						ply:ChatPrint( "Sorry there are no online officers!" )
						return false
					end
				else
					ply:ChatPrint( "Your message is either way too short, or it was too long to display, write about 10 - 24 cars!" )
					return false
			end
		end
	end
	hook.Add( 'PlayerSay', '911Calls', PoliceCall )


	net.Receive( "CallP", function(len,ply)
		local plycall = net.ReadEntity()
		local bool = net.ReadBit()
		if bool == 0 then
			ply:Say("/g I will not be able to help the citizen, named: "..plycall:Nick().."!", false)
		elseif bool == 1 then
			ply:Say("/g I am responding to the call of the citizen named: "..plycall:Nick().."!", false)
		end
	end )
end