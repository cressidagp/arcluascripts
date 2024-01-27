--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Exodar: Seer Skaltesh
	Engine: A.L.E

	Credits:

	*) Trinity for spell id and timers.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

  enUS: "Show me, Seer."

  esMX: "Muéstramelo, Vidente"

--]]

SEER_SKALTESH = {}

function SEER_SKALTESH.OnHello( unit, _, plr )

	unit:GossipCreateMenu( 9622, plr, 0 );
	unit:GossipMenuAddItem( 0, "Show me, Seer.", 1, 0 );
	unit:GossipSendMenu( plr );
end

function SEER_SKALTESH.OnSelect( unit, _, plr, id, selection )
	if( selection == 1 )
	then
		if( plr:HasItem( 27317 ) == false )
		then
			plr:AddItem( 27317, 1 );
		end
		unit:GossipCreateMenu( 9623, plr, 0 );
		unit:GossipSendMenu( plr );
	end
end

RegisterUnitGossipEvent( 18985, 1, SEER_SKALTESH.OnHello );
RegisterUnitGossipEvent( 18985, 2, SEER_SKALTESH.OnSelect );