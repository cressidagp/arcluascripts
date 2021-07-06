--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest 
	Creature: Innkeeper Farley (295)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:

	"So much to do, so much to do!  Where does the time go?",
	"If your glass is full may it be again!"

	esMX local:

	"¡Tanto que hacer, tanto que hacer!  ¿Donde se va el tiempo?",
	"¡Si tu copa esta llena puede volver a estarlo!"

--]]

--local NPC_INNKEEPER_FARLEY = 295;
--local EMOTE_ONESHOT_WAVE = 3;
--local UNIT_FIELD_TARGET = 0x0006 + 0x000C;

local chat = {
"So much to do, so much to do!  Where does the time go?",
"If your glass is full may it be again!"
};

INNKEEPER_FARLEY = {};

function INNKEEPER_FARLEY.OnSpawnOnAIUpdate( unit, event )
	
	--
	-- on ai update
	--
	
	if( event == 21 )
	then
		
		if( unit:IsInCombat() == true ) then return; end
		
		unit:SendChatMessage( 12, 7, chat[ math.random( 1, 2 ) ] );
		
		unit:ModifyAIUpdateEvent( math.random( 150000, 180000 ) )
		
	--
	-- on spawn
	--
	
	else
		unit:RegisterAIUpdateEvent( math.random( 1000, 15000 ) );
	end
end

RegisterUnitEvent( 295, 18, INNKEEPER_FARLEY.OnSpawnOnAIUpdate );
RegisterUnitEvent( 295, 21, INNKEEPER_FARLEY.OnSpawnOnAIUpdate );