include( "PoliceCall/sh_config.lua" )

if SERVER then
	AddCSLuaFile( "PoliceCall/sh_config.lua" )
	AddCSLuaFile( "PoliceCall/cl_policecalls.lua" )
	include( "PoliceCall/sv_policecalls.lua" )
else
	include( "PoliceCall/cl_policecalls.lua" )
end