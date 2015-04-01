if SERVER then
	include( "PoliceCall/sv_policecalls.lua" )
	include( "PoliceCall/config.lua" )
	AddCSLuaFile( "PoliceCall/cl_policecalls.lua" )
	AddCSLuaFile( "PoliceCall/config.lua" )
else
	include( "PoliceCall/cl_policecalls.lua" )
	include( "PoliceCall/config.lua" )
end