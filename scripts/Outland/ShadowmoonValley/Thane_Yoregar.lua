--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Negrand: Thane Yoregar (Wildhammer Stronghold)
	Engine: A.L.E

  Credits:

  *) Trinity for texts.
  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

  enUS: "I don't get it! Are ya blind? Can ya not see the demons bangin' on our door? Who am I gonna send out to talk to your shaman friends? Point 'em out!"

  esMX: "¡No lo entiendo! ¿Estás ciego? ¿No puedes ver a los demonios golpeando nuestra puerta? ¿A quién voy a enviar para hablar con tus amigos chamanes? ¡Dime!"

--]]

THANE_YOREGAR = {};

function THANE_YOREGAR.Chat( unit )
  if( unit:IsInCombat() == false )
  then
    unit:SendChatMessage( 12, 7, "I don't get it! Are ya blind? Can ya not see the demons bangin' on our door? Who am I gonna send out to talk to your shaman friends? Point 'em out!" );
    unit:Emote( 6, 0 );
    unit:RemoveEvents();
    unit:RegisterEvent( THANE_YOREGAR.Chat, math.random( 200000, 260000 ), 0 );
  end
end

function THANE_YOREGAR.OnSpawn( unit )
  unit:RegisterEvent( THANE_YOREGAR.Chat, 120000, 0 );
end

RegisterUnitEvent( 21773, 18, THANE_YOREGAR.OnSpawn );
