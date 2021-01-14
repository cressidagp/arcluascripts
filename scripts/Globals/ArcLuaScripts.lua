--[[
      ArcLuaScripts for ArcEmu
      www.ArcEmu.org
      Engine: A.L.E
      Credits: nil

      Developer notes: this beauty will check if we apply the newest arcluascripts.sql

--]]

local version = WorldDBQuery( "SELECT `version` FROM `arcluascripts`" ):GetColumn( 0 ):GetString();

if( version == nil )

then
        print("==============================================================");
        print("ArcLuaScripts: your forget to apply SQL file to your database!");
        print("==============================================================");

elseif( version == "2021-01-14_09-27_Ruby" )

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
