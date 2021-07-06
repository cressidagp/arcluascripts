--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Ghostlands
	Creature: Arcanist Vandril

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale: "Arcanist Vandril, what are the Forsaken doing here?"
	
	esMX locale: "Arcanista Vandril, ¿qué están haciendo aquí los Renegados?"

--]]

--local NPC_ARCANIST_VANDRIL = 16197;

ARCANIST_VANDRIL = {};

function ARCANIST_VANDRIL.OnHelloOnSelect( unit, event, plr, id, selection )

	if( event == 1 )
	then
		unit:GossipCreateMenu( 8417, plr, 0 );
		unit:GossipMenuAddItem( 0, "Arcanist Vandril, what are the Forsaken doing here?", 1, 0 );
		unit:GossipSendMenu( plr );
		unit:GossipAddQuests( plr );
	
	else
	
		if( selection == 1 )
		then
			unit:GossipCreateMenu( 8501, plr, 0 );
			unit:GossipSendMenu( plr );		
		end
	end
end

RegisterUnitGossipEvent( 16197, 1, ARCANIST_VANDRIL.OnHelloOnSelect );
RegisterUnitGossipEvent( 16197, 2, ARCANIST_VANDRIL.OnHelloOnSelect );
