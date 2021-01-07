--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Azuremyst Isle: Proenitus
	Engine: A.L.E

	Credits:

	*) Trinity for texts.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

PROENITUS = {}

function PROENITUS.OnHello( unit, _, plr )

	if( plr:HasFinishedQuest( 9280 ) == true ) -- "Replenishing the Healing Crystals"
	then
		unit:GossipCreateMenu( 8669, plr, 0 );
	else
      unit:GossipCreateMenu( 8667, plr, 0 );
    end
    unit:GossipAddQuests( plr );
    unit:GossipSendMenu( plr );
end

--RegisterUnitGossipEvent( 16477, 1, PROENITUS.OnHello );