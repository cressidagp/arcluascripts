--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Azuremyst Isle
	Creature: Acteon (17110)
	
	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	[ 1 ] = "Acteon, where is the best area to hunt for moongraze stags?"
	[ 2 ] = "Acteon, where is the best place to hunt moongraze bucks?"
	
	esMX locale:

	[ 1 ] = "Acteon, ¿cuál es la mejor area para cazar venado lunar?"
	[ 2 ] = "Acteon, ¿cuál es el mejor lugar para cazar ciervo lunar?"

--]]

--local NPC_ACTEON = 17110;

ACTEON = {};

function ACTEON.OnHello( unit, event, plr, id, selection )

	if( event == 1 )
	then
		unit:GossipCreateMenu( 8823, plr, 0 );

		if( plr:HasQuest( 9454 ) == true )
		then
			unit:GossipMenuAddItem( 0, "Acteon, where is the best area to hunt for moongraze stags?", 1, 0 );

		elseif( plr:HasQuest( 10324 ) == true )
		then
			unit:GossipMenuAddItem( 0, "Acteon, where is the best place to hunt moongraze bucks?", 2, 0 );
		end

		unit:GossipSendMenu( plr );
		unit:GossipAddQuests( plr );
	else
		if( selection == 1 )
		then
			unit:GossipCreateMenu( 8972, plr, 0 );
		else
			unit:GossipCreateMenu( 8973, plr, 0 );
		end
		unit:GossipSendMenu( plr );
	end
end

RegisterUnitGossipEvent( 17110, 1, ACTEON.OnHello );
RegisterUnitGossipEvent( 17110, 2, ACTEON.OnHello );
