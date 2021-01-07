--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Azuremyst Isle: Botanist Taerix
	Engine: A.L.E

	Credits:

	*) Trinity for texts.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

BOTANIST_TAERIX = {}

function BOTANIST_TAERIX.OnHello( unit, _, plr )

	if( plr:HasFinishedQuest( 9293 ) == true ) -- "What Must Be Done..."
	then
		unit:GossipCreateMenu( 8666, plr, 0 );
	else
		unit:GossipCreateMenu( 8664, plr, 0 );
    end
    unit:GossipAddQuests( plr );
    unit:GossipSendMenu( plr );
end

--RegisterUnitGossipEvent( 16514, 1, BOTANIST_TAERIX.OnHello );
