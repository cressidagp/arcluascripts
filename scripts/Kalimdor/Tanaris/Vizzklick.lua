--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E

	Zone: Tanaris
	Creature: Vizzklick (6568)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale: "I wish to browse your wares."
	
	esMX locale: "Me gustaría revisar tus productos."

--]]

--local NPC_VIZZKICLIK = 6568;

VIZZKLICK = {}

function VIZZKLICK.OnHelloOnSelect( unit, event, plr, id, selection )

	if( event == 1 )
	then
		unit:GossipCreateMenu( 1933, plr, 0 );
		unit:GossipMenuAddItem( 0, "I wish to browse your wares.", 1, 0 );
		unit:GossipSendMenu( plr );
	else
		if( selection == 1 )
		then
			plr:SendVendorWindow( unit );
		end
	end
end

RegisterUnitGossipEvent( 6568, 1, VIZZKLICK.OnHelloOnSelect );
RegisterUnitGossipEvent( 6568, 2, VIZZKLICK.OnHelloOnSelect );

