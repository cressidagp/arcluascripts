--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Elwynn Forest: Morgan The Collector
	Engine: A.L.E
	Credits: nil
--]]

MORGAN_THE_COLLECTOR = {}

function MORGAN_THE_COLLECTOR.Gouge( unit )

	-- Cast: "Gouge"

    unit:CastSpellOnTarget( 1776, MORGAN_THE_COLLECTOR.target );

end

function MORGAN_THE_COLLECTOR.OnCombat( unit, _, attacker )

    MORGAN_THE_COLLECTOR.target = attacker;

    unit:RegisterEvent( MORGAN_THE_COLLECTOR.Gouge, 2000, 1 );

    unit:RegisterEvent( MORGAN_THE_COLLECTOR.Gouge, math.random( 12000, 14000 ), 0 );

end

RegisterUnitEvent( 473, 1, MORGAN_THE_COLLECTOR.OnCombat );