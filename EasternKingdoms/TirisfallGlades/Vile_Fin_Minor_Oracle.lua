VILEFIN_MINORORACLE = {}

function VILEFIN_MINORORACLE.OoCCastBuff( unit, event )

    if( event == 18 )
    then
        local n = math.random( 1, 5 );
        unit:RegisterAIUpdateEvent( n * 1000 );
    else
        if( unit:IsInCombat() == false and unit:HasAura( 12544 ) == false )
        then
            unit:FullCastSpell( 324 ); -- Lightning Shield
            unit:ModifyAIUpdateEvent( 600000 );
        end
    end
end

RegisterUnitEvent( 1544, 18, VILEFIN_MINORORACLE.OoCCastBuff );
RegisterUnitEvent( 1544, 21, VILEFIN_MINORORACLE.OoCCastBuff );
