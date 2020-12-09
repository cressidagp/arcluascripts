--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Redridge Mountains: Hilary (Lakeshire)
	Engine: A.L.E

	Credits:

	*) Trinity for texts.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

HILARY = {}

function HILARY.OnHello( unit, _, plr )

	if( plr:HasFinishedQuest( 3741 ) == true )
	then
		unit:GossipCreateMenu( 2274, plr, 0 );
	else
		unit:GossipCreateMenu( 2273, plr, 0 );
	end
		
	unit:GossipSendMenu( plr );
	
end

RegisterUnitGossipEvent( 8962, 1, HILARY.OnHello );