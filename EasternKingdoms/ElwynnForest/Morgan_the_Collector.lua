local SPELL_GOUGE = 1776;

MORGAN_COLLECTOR = {}

function MORGAN_COLLECTOR.Gouge( unit, event )
    unit:CastSpellOnTarget( SPELL_GOUGE, MORGAN_COLLECTOR.target );
end

function MORGAN_COLLECTOR.OnCombat( unit, event, attacker )
    MORGAN_COLLECTOR.target = attacker;
    unit:RegisterEvent( MORGAN_COLLECTOR.Gouge, 2000, 1 );
    unit:RegisterEvent( MORGAN_COLLECTOR.Gouge, math.random( 12000, 14000 ), 0 );
end

RegisterUnitEvent( 473, 1, MORGAN_COLLECTOR.OnCombat );
