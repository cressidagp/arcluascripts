--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Darnassus
	Creature: Arc Druid Fandral Staghelm

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale: "I'm not a journeyman herbalist -- am I able to still assist you in your work?"

	esMX locale:

--]]

--local NPC_FANDRAL_STAGHELM = 3516;

FANDRAL_STAGHELM = {}

function FANDRAL_STAGHELM.OnHelloSelect( unit, event, plr, id, selection )

	if( event == 1 )
	then
		unit:GossipCreateMenu( 2285, plr, 0 );
		unit:GossipMenuAddItem( 0, "I'm not a journeyman herbalist -- am I able to still assist you in your work?", 1, 0 );
		unit:GossipAddQuests( plr );
		
	else
	
		if( selection == 1 )
		then
			unit:GossipCreateMenu( 2320, plr, 0 );

		end
	end		
	unit:GossipSendMenu( plr );
end

RegisterUnitGossipEvent( 3516, 1, FANDRAL_STAGHELM.OnHelloSelect );
RegisterUnitGossipEvent( 3516, 2, FANDRAL_STAGHELM.OnHelloSelect );


