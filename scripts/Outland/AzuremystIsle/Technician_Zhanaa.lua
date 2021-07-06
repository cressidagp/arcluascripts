--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Azuremyst Isle: Technician Zhanaa
	Engine: A.L.E

	Credits:

	*) Trinity for texts.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

TECHNICIAN_ZHANAA = {};

function TECHNICIAN_ZHANAA.OnHello( unit, _, plr )

	if( plr:HasFinishedQuest( 9312 ) == true ) -- "The Emitter"
	then
		unit:GossipCreateMenu( 8776, plr, 0 );

	elseif( plr:HasFinishedQuest( 9305 ) == true ) -- "Spare Parts"
	then
		unit:GossipCreateMenu( 8777, plr, 0 );
	else
		unit:GossipCreateMenu( 8775, plr, 0 );

    end
    unit:GossipAddQuests( plr );
    unit:GossipSendMenu( plr );
end

RegisterUnitGossipEvent( 17071, 1, TECHNICIAN_ZHANAA.OnHello );
