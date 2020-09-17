VOODOO_TROLL = {}

function VOODOO_TROLL.OoCCastBuff( unit, event )

    if( event == 18 )
    then
        unit:RegisterAIUpdateEvent( 1000 );
    else
        if( unit:IsInCombat() == false and unit:HasAura( 324 ) == false )
        then
            unit:FullCastSpell( 324 ); -- Lighting Shield
            unit:ModifyAIUpdateEvent( 600000 );
        end
    end
end

RegisterUnitEvent( 3206, 18, VOODOO_TROLL.OoCCastBuff );
RegisterUnitEvent( 3206, 21, VOODOO_TROLL.OoCCastBuff );
