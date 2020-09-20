MARCUS_JONATHAN = {}

function MARCUS_JONATHAN.OnEmote( unit, event, plr, eID )

    if( eID == 3 )
    then

        unit:SendChatMessage( 12, 7, "Greetings citizen." );

    elseif( eID == 66 )
    then
        unit:Emote( 66, 0 );
    end
end

RegisterUnitEvent( 466, 22, MARCUS_JONATHAN.OnEmote );
