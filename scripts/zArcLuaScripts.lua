--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	Developer notes: this beauty will check if we apply the newest arcluascripts.sql

--]]

local version = WorldDBQuery( "SELECT `version` FROM `arcluascripts`" ):GetColumn( 0 ):GetString();

if( version == nil )

then
        print("==============================================================");
        print("ArcLuaScripts: your forget to apply SQL file to your database!");
        print("==============================================================");

elseif( version == "2021-02-12_00-27_MeteorStrike" )

then

        print("============================================");
        print("ArcLuaScripts: your database its up to date!");
        print("============================================");

else

    print("=================================================");
    print("ArcLuaScripts: your database has and old version!");
    print("=================================================");

end

print( _VERSION );

print( "Lua memory used: "..gcinfo().." Kb." );
