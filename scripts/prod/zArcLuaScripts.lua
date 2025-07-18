--[[

	ArcLuaScripts for ArcEmu
	Engine: A.L.E
	2024
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and A.L.E, specially to dfighter1985.

	Developer notes: this beauty will check if we apply the newest arcluascripts.sql

--]]

local version = WorldDBQuery( "SELECT `version` FROM `arcluascripts`" ):GetColumn( 0 ):GetString()

if version == nil then

	print("====================================================================")
	print("ArcLuaScripts: your forget to apply SQL file to your world database!")
	print("====================================================================")

elseif version == "2025-06-25_14-16_Cleanup" then

	print("==================================================")
	print("ArcLuaScripts: your world database its up to date!")
	print("==================================================")

else

    print("================================================")
    print("ArcLuaScripts: your world database its outdated!")
    print("================================================")

end

print( _VERSION )

print( "LuaEngine: "..gcinfo().." Kb of dynamic memory used." )