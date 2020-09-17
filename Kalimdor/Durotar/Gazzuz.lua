GAZZUZ = {}

function GAZZUZ.OoCCastBuff( unit, event )

    if( event == 18 )
    then
        unit:RegisterAIUpdateEvent( 1000 );
    else
        if( unit:IsInCombat() == false and unit:HasAura( 20798 ) == false )
        then
            unit:FullCastSpell( 20798 ); -- Demon Skin
            unit:ModifyAIUpdateEvent( 1800000 );
        end
    end
end

RegisterUnitEvent( 3204, 18, GAZZUZ.OoCCastBuff );
RegisterUnitEvent( 3204, 21, GAZZUZ.OoCCastBuff );
