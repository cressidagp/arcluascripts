--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Redridge Mountains: Shawn (Lakeshire)
	Engine: A.L.E

	Credits:

	*) Trinity for texts.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

SHAWN = {}

function SHAWN.OnHello( unit, _, plr )

	if( plr:HasFinishedQuest( 3741 ) == true )
	then
		unit:GossipCreateMenu( 2277, plr, 0 );
	else
		unit:GossipCreateMenu( 2276, plr, 0 );
		unit:GossipAddQuests( plr );
	end
		
	unit:GossipSendMenu( plr );
		
end

--RegisterUnitGossipEvent( 8965, 1, SHAWN.OnHello );
