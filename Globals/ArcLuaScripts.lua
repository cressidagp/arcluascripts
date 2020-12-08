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

elseif( version == "2020-12-03_00-58_Baltharus" )

then

        print("============================================");
        print("ArcLuaScripts: your database its up to date!");
        print("============================================");

else

    print("=================================================");
    print("ArcLuaScripts: your database has and old version!");
    print("=================================================");

end
