--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Stormwind City: General Marcus Jonathan
	Engine: A.L.E
	Credits: nil
	
	enUS: "Greetings citizen."
	esMX: "Saludos ciudadano."
	
--]]

local EMOTE_ONESHOT_WAVE = 3;
local EMOTE_ONESHOT_SALUTE = 66;

MARCUS_JONATHAN = {}

function MARCUS_JONATHAN.OnEmote( unit, event, plr, eID )

    if( eID == EMOTE_ONESHOT_WAVE and unit:IsHostile( plr ) == false )
	
    then

        unit:SendChatMessage( 12, 7, "Greetings citizen." );

    elseif( eID == EMOTE_ONESHOT_SALUTE and unit:IsHostile( plr ) == false )
	
    then
	
        unit:Emote( EMOTE_ONESHOT_SALUTE, 0 );
		
    end
	
end

RegisterUnitEvent( 466, 22, MARCUS_JONATHAN.OnEmote );
