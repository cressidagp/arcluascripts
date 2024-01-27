--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Hellfire Peninsula
	Creature: Danath Trollbane
	

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:

	[ 1 ] = "Tell me of the Sons of Lothar."
	[ 2 ] = "Tell me of the Hellfire orcs."
	[ 3 ] = "Tell me of your homeland."
	[ 4 ] = "<more>"

	esMX locale:

	[ 1 ] = "Háblame de los Hijos de Lothar."
	[ 2 ] = "Háblame de los orcos Hellfire."
	[ 3 ] = "Háblame de tu tierra natal."
	[ 4 ] = "<más>"

--]]

--local NPC_DANATH_TROLLBANE = 16819;

DANATH_TROLLBANE = {};

function DANATH_TROLLBANE.OnHelloSelect( unit, event, plr, id, selection )

	if( event == 1 )
	then
		if( plr:HasFinishedQuest( 10254 ) == true )
		then
			unit:GossipCreateMenu( 9939, plr, 0 );
			unit:GossipMenuAddItem( 0, "Tell me of the Sons of Lothar.", 1, 0 );
			unit:GossipMenuAddItem( 0, "Tell me of the Hellfire orcs.", 2, 0 );
			unit:GossipMenuAddItem( 0, "Tell me of your homeland.", 3, 0 );
		else
			unit:GossipCreateMenu( 9939, plr, 0 );
		end
		
		unit:GossipAddQuests( plr );
	
	else
	
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
	end
	
	unit:GossipSendMenu( plr );
end

RegisterUnitGossipEvent( 16819, 1, DANATH_TROLLBANE.OnHelloSelect );
RegisterUnitGossipEvent( 16819, 2, DANATH_TROLLBANE.OnHelloSelect );