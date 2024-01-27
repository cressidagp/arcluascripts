--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E	

	Zone: Stormwind City
	Creature: General Marcus Jonathan (466)
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS: "Greetings citizen."
	
	esMX: "Saludos ciudadano."
	
--]]

--local EMOTE_ONESHOT_WAVE = 3;
--local EMOTE_ONESHOT_SALUTE = 66;

GENERAL_MARCUS_JONATHAN = {};

function GENERAL_MARCUS_JONATHAN.OnEmote( unit, _, plr, emoteId )

	if( unit:IsHostile( plr ) == false )
	then
		if( emoteId == 3 )	
		then
			unit:SendChatMessage( 12, 7, "Greetings citizen." );

		elseif( emoteId == 66 )	
		then	
			unit:Emote( 66, 0 );
		end
    end	
end

RegisterUnitEvent( 466, 22, GENERAL_MARCUS_JONATHAN.OnEmote );