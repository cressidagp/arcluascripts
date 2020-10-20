local EMOTE_ONESHOT_WAVE = 3
local EMOTE_ONESHOT_SALUTE = 66

MARCUS_JONATHAN = {}

function MARCUS_JONATHAN.OnEmote( unit, event, plr, eID )

    if( eID == EMOTE_ONESHOT_WAVE unit:IsHostile( plr ) == false )
    then

        unit:SendChatMessage( 12, 7, "Greetings citizen." );

    elseif( eID == EMOTE_ONESHOT_SALUTE unit:IsHostile( plr ) == false )
    then
        unit:Emote( EMOTE_ONESHOT_SALUTE, 0 );
    end
end

RegisterUnitEvent( 466, 22, MARCUS_JONATHAN.OnEmote );
