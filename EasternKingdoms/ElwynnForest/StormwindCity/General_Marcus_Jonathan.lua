MARCUS_JONATHAN = {}

function MARCUS_JONATHAN.OnEmote( unit, event, plr, eID )

    if( eID == 3 unit:IsHostile( plr ) == false )
    then

        unit:SendChatMessage( 12, 7, "Greetings citizen." );

    elseif( eID == 66 unit:IsHostile( plr ) == false )
    then
        unit:Emote( 66, 0 );
    end
end

RegisterUnitEvent( 466, 22, MARCUS_JONATHAN.OnEmote );
