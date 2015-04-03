PPC = PPC or {} -- ignore

-- Used later
PPC.Language = "english" -- name of file in lua/lang without the .lua extension

-- Set here the team you would like to receive the messages of the reporting peoples.
PPC.AllowedTeams = {
--  "TEAM_EXAMPLE",
	"TEAM_POLICE",
	"TEAM_MAYOR",
	"TEAM_CHIEF"
}

-- Chat commands available to call a privileged person
PPC.ChatCommands = {
--	"!911",
	"/911"
}

PPC.MessageCD = 0 -- Cooldown between /911 calls. It's given in seconds so 240 seconds = 4 Minutes

PPC.MinMsgLength = 10 -- Minimum length of the message send with the call
PPC.MaxMsgLength = 24 -- Maximum length of the message send with the call

-- Change colors only if you know what you are doing!
PPC.Buttonbottom	= Color( 255, 255, 255, 10 ) -- Color( red, green, blue, alpha )
PPC.Buttontop		= Color( 69, 178, 157 )
PPC.Base			= Color( 51, 77, 92 )
PPC.Basetopmain		= Color( 255, 255, 255, 20 )
PPC.Basetopbot		= Color( 255, 255, 255, 5 )

-- This is a config file, please read the comments behind the seperate config options!