--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Ghostlands: Arcanist Vandril
	Engine: A.L.E

	Credits:

	*) Trinity for text and emotes.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

ARCANIST_VANDRIL = {}

function ARCANIST_VANDRIL.OnHello( unit, _, plr )

	unit:GossipCreateMenu( 8417, plr, 0 );
	unit:GossipMenuAddItem( 0, "Arcanist Vandril, what are the Forsaken doing here?", 1, 0 );
	unit:GossipSendMenu( plr );
	unit:GossipAddQuests( plr );

end

function ARCANIST_VANDRIL.OnSelect( unit, _, plr, id, selection )
	if( selection == 1 )
	then
		unit:GossipCreateMenu( 8501, plr, 0 );
		unit:GossipSendMenu( plr );
	end
end

RegisterUnitGossipEvent( 16197, 1, ARCANIST_VANDRIL.OnHello );
RegisterUnitGossipEvent( 16197, 2, ARCANIST_VANDRIL.OnSelect );
