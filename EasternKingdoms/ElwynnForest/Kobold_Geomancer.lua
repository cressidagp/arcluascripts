KOBOLD_GEOMANCER = {}

function KOBOLD_GEOMANCER.OoCCastBuff( unit, event )

    if( event == 18 )
    then
        unit:RegisterAIUpdateEvent( 1000 );
    else
        if( unit:IsInCombat() == false and unit:HasAura( 12544 ) == false )
        then
            unit:FullCastSpell( 12544 ); -- Frost Amor:
            unit:ModifyAIUpdateEvent( 1800000 );
        end
    end
end

RegisterUnitEvent( 476, 18, KOBOLD_GEOMANCER.OoCCastBuff );
RegisterUnitEvent( 476, 21, KOBOLD_GEOMANCER.OoCCastBuff );
