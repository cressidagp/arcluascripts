--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Hellfire Peninsula: Danath Trollbane (Honor Hold)
	Engine: A.L.E

  Credits:

  *) Trinity for gossips, texts, sound ids, timers, spell ids, move coords and some inspiration.
  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

DANATH_TROLLBANE = {}

function DANATH_TROLLBANE.OnHello( unit, _, plr )

	if( plr:HasFinishedQuest( 10254 ) == true )
	then
		unit:GossipCreateMenu( 9939, plr, 0 );
    unit:GossipMenuAddItem( 0, "Tell me of the Sons of Lothar.", 1, 0 );
    unit:GossipMenuAddItem( 0, "Tell me of the Hellfire orcs.", 2, 0 );
    unit:GossipMenuAddItem( 0, "Tell me of your homeland.", 3, 0 );

	else
			unit:GossipCreateMenu( 9939, plr, 0 );
		end
		unit:GossipSendMenu( plr );
end

function DANATH_TROLLBANE.OnSelect( unit, _, plr, id, selection )

  if( selection == 1 )
  then
    unit:GossipCreateMenu( 9932, plr, 0 );
    unit:GossipMenuAddItem( 0, "<more>", 4, 0 );

  elseif( selection == 2 )
  then
    unit:GossipCreateMenu( 9941, plr, 0 );

  elseif( selection == 3 )
  then
    unit:GossipCreateMenu( 8772, plr, 0 );

  else
    unit:GossipCreateMenu( 9933, plr, 0 );
  end
  unit:GossipSendMenu( plr );
end

RegisterUnitGossipEvent( 16819, 1, DANATH_TROLLBANE.OnHello );
RegisterUnitGossipEvent( 16819, 2, DANATH_TROLLBANE.OnSelect );
