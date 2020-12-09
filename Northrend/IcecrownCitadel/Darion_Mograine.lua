--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Icecrown Citadel: Darion Mograine
	Engine: A.L.E
	
	Credits: 
	
	*) Trinity for texts.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

	Developer notes: added a sql hack for this since arcemu cant handle gossips for vehicles.

--]]

DARION_LH = {}

function DARION_LH.OnHelloOnSelect( unit, event, plr, id, selection, code )

	if( event == 1 )
	then
		unit:GossipCreateMenu( 15158, plr, 0 );
		unit:GossipMenuAddItem( 0, "What is the Ashen Verdict?", 1, 0 );
		unit:GossipSendMenu( plr );
	else
		if( selection == 1 )
		then
			unit:GossipCreateMenu( 15159, plr, 0 );
			unit:GossipMenuAddItem( 0, "How can I learn to work Primordial Saronite?", 2, 0 );
			unit:GossipSendMenu( plr );
		else
			unit:GossipCreateMenu( 15160, plr, 0 );
			unit:GossipSendMenu( plr );
		end
	end	
end

RegisterUnitGossipEvent( 37120, 1, DARION_LH.OnHelloOnSelect );
RegisterUnitGossipEvent( 37120, 2, DARION_LH.OnHelloOnSelect );
