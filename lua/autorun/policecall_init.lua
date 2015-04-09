include( "policecalls/sh_config.lua" )
include( "policecalls/sh_policecalls.lua" )

if SERVER then
	AddCSLuaFile( "policecalls/sh_config.lua" )
	AddCSLuaFile( "policecalls/sh_policecalls.lua" )
	AddCSLuaFile( "policecalls/cl_policecalls.lua" )
	include( "policecalls/sv_policecalls.lua" )
else
	include( "policecalls/cl_policecalls.lua" )
end