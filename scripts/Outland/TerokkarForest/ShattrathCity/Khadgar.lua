--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Shattrath City: Khadgar
	Engine: A.L.E

  Credits:

  *) Trinity for texts.
  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

  enUS:

  [ 1 ] = "I've heard your name spoken only in whispers, mage.  Who are you?";
  [ 2 ] = "Go on, please.";
  [ 3 ] = "I see.";
  [ 4 ] = "What did you do then?";
  [ 5 ] = "What happened next?";
  [ 6 ] = "There was something else I wanted to ask you.";

  esMX:

  [ 1 ] = "Escuché tu nombre solo en susurros, mago. ¿Quién eres tú?";
  [ 2 ] = "Continua por favor.";
  [ 3 ] = "Ya veo.";
  [ 4 ] = "¿Entonces que hiciste?";
  [ 5 ] = "¿Qué pasó después?";
  [ 6 ] = "Había algo más que quería preguntarte.";

--]]

local TEXT = {
[ 1 ] = "I've heard your name spoken only in whispers, mage.  Who are you?";
[ 2 ] = "Go on, please.";
[ 3 ] = "I see.";
[ 4 ] = "What did you do then?";
[ 5 ] = "What happened next?";
[ 6 ] = "There was something else I wanted to ask you.";
};

KHADGAR = {}

function KHADGAR.OnHello( unit, _, plr )

		unit:GossipCreateMenu( 9243, plr, 0 );
    unit:GossipMenuAddItem( 0, TEXT[ 1 ], 1, 0 );
    unit:GossipAddQuests( plr );
		unit:GossipSendMenu( plr );
end

function KHADGAR.OnSelect( unit, _, plr, id, selection )

  if( selection == 1 )
  then
    unit:GossipCreateMenu( 9876, plr, 0 );
    unit:GossipMenuAddItem( 0, TEXT[ 2 ], 2, 0 );

  elseif( selection == 2 )
  then
    unit:GossipCreateMenu( 9877, plr, 0 );
    unit:GossipMenuAddItem( 0, TEXT[ 3 ], 3, 0 );

  elseif( selection == 3 )
  then
    unit:GossipCreateMenu( 9878, plr, 0 );
    unit:GossipMenuAddItem( 0, TEXT[ 4 ], 4, 0 );

  elseif( selection == 4 )
  then
    unit:GossipCreateMenu( 9879, plr, 0 );
    unit:GossipMenuAddItem( 0, TEXT[ 5 ], 5, 0 );

  elseif( selection == 5 )
  then
    unit:GossipCreateMenu( 9880, plr, 0 );
    unit:GossipMenuAddItem( 0, TEXT[ 3 ], 6, 0 );

  elseif( selection == 6 )
  then
    unit:GossipCreateMenu( 9881, plr, 0 );
    unit:GossipMenuAddItem( 0, TEXT[ 6 ], 7, 0 );

  elseif( selection == 7 )
  then
    unit:GossipCreateMenu( 9243, plr, 0 );
  end
  unit:GossipSendMenu( plr );
end

RegisterUnitGossipEvent( 18166, 1, KHADGAR.OnHello );
RegisterUnitGossipEvent( 18166, 2, KHADGAR.OnSelect );
