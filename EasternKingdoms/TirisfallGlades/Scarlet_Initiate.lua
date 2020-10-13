SCARLET_INITIATE = {}

function SCARLET_INITIATE.OoCCastBuff( unit, event )

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

RegisterUnitEvent( 1507, 18, SCARLET_INITIATE.OoCCastBuff );
RegisterUnitEvent( 1507, 21, SCARLET_INITIATE.OoCCastBuff );
