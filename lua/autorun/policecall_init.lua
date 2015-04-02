include( "PoliceCall/sh_config.lua" )

if SERVER then
	include( "PoliceCall/sv_policecalls.lua" )
	AddCSLuaFile( "PoliceCall/config.lua" )
	AddCSLuaFile( "PoliceCall/cl_policecalls.lua" )
else
	include( "PoliceCall/cl_policecalls.lua" )
end