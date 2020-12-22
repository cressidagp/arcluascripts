--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Azuremyst Isle: Spirit of the Vale
	Engine: A.L.E

	Credits:

	*) Trinity for texts.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

SPIRIT_VALE = {}

function SPIRIT_VALE.OnHello( unit, _, plr )

	if( plr:HasFinishedQuest( 9450 ) == true ) -- "Call of Earth"
	then
		unit:GossipCreateMenu( 8826, plr, 0 );
	else
      unit:GossipCreateMenu( 8827, plr, 0 );
    end
    unit:GossipAddQuests( plr );
    unit:GossipSendMenu( plr );
end

RegisterUnitGossipEvent( 17087, 1, SPIRIT_VALE.OnHello );
