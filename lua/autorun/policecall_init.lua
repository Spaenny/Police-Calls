if SERVER then
	include( "policeCall/sv_policecalls.lua" )
	include( "policeCall/config.lua" )
	AddCSLuafile( "policeCall/cl_policecalls.lua" )
	AddCSLuafile( "policeCall/config.lua" )
else
	include( "policeCall/cl_policecalls.lua" )
	include( "policeCall/config.lua" )
end