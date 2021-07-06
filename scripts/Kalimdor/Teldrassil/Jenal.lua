--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Darnassus
	Creature: Jenal

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:

	esMX locale:

--]]

--local NPC_JENAL = 9047;

JENAL = {};

function JENAL.OnHelloSelect( unit, event, plr, id, selection )

	if( event == 1 )
	then
		unit:GossipCreateMenu( 2313, plr, 0 );
		unit:GossipMenuAddItem( 0, "What are you doing out here?", 1, 0 );
		unit:GossipAddQuests( plr );
		
	else
	
		if( selection == 1 )
		then
			unit:GossipCreateMenu( 2314, plr, 0 );

		end
	end		
	unit:GossipSendMenu( plr );
end

RegisterUnitGossipEvent( 9047, 1, JENAL.OnHelloSelect );
RegisterUnitGossipEvent( 9047, 2, JENAL.OnHelloSelect );


