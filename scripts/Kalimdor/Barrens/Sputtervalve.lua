--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: The Barrens
	Creature: Sputtervalve (3442)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale: "How can I help?"
	
	esMX locale: "¿Cómo puedo ayudarte?"

--]]

--local NPC_SPUTTERVALVE = 3442;

SPUTTERVALVE = {}

function SPUTTERVALVE.OnHelloOnSelect( unit, event, plr, id, selection )

	if( event == 1 )
	then
		unit:GossipCreateMenu( 519, plr, 0 );
		unit:GossipMenuAddItem( 0, "How can I help?", 1, 0 );
		unit:GossipAddQuests( plr );
		unit:GossipSendMenu( plr );
	else
		if( selection == 1 )
		then
			unit:GossipCreateMenu( 518, plr, 0 );
			unit:GossipSendMenu( plr );
		end
	end
end

RegisterUnitGossipEvent( 3442, 1, SPUTTERVALVE.OnHelloOnSelect );
RegisterUnitGossipEvent( 3442, 2, SPUTTERVALVE.OnHelloOnSelect );
