PPC = PPC or {}
PPC.MessageCD = 0 			--Cooldown between /911 calls. It's given in seconds so 240 seconds = 4 Minutes

--Colors only change if you know what you are doing!
PPC.Buttonbottom 	= Color( 255, 255, 255, 10)
PPC.Buttontop 		= Color( 69, 178, 157)
PPC.Base 			= Color( 51, 77, 92 )
PPC.Basetopmain		= Color( 255, 255, 255, 20)
PPC.Basetopbot		= Color( 255, 255, 255, 5)


-- Set here the team you would like to receive the messages of the reporting peoples.
PPC.AllowedTeams = {
	"TEAM_POLICE",
	"TEAM_MAYOR",
	"TEAM_CHIEF",
--  "TEAM_EXAMPLE",
}

-- This is a config file, please read the comments behind the seperate config options!