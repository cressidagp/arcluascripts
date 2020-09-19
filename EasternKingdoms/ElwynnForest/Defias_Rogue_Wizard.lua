DEFIAS_ROGUE_WIZARD = {}

function DEFIAS_ROGUE_WIZARD.OoCCastBuff( unit, event )

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

RegisterUnitEvent( 474, 18, DEFIAS_ROGUE_WIZARD.OoCCastBuff );
RegisterUnitEvent( 474, 21, DEFIAS_ROGUE_WIZARD.OoCCastBuff );
