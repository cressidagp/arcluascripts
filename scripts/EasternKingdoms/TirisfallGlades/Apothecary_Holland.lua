--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Tirisfall Glades
	Creature: Apothecary Holland

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	"What could be taking so long?",
	"How long can it take to pick a handful of weeds?",
	"At this rate I could have gathered them myself!",
	"If you want something done right, do it yourself!",
	"As if I had all eternity.",
	"Ah, this must be him now... no?  Bah!",
	"Maybe I should have just bought some off of Faruza?",
	"I had to go and requisition an Abomination... an Abomination!"
	
	esMX locale:

--]]

--local NPC_APOTHECARY_HOLLAND = 10665;

local chat = {
"What could be taking so long?",
"How long can it take to pick a handful of weeds?",
"At this rate I could have gathered them myself!",
"If you want something done right, do it yourself!",
"As if I had all eternity.",
"Ah, this must be him now... no?  Bah!",
"Maybe I should have just bought some off of Faruza?",
"I had to go and requisition an Abomination... an Abomination!"
};

APOTHECARY_HOLLAND = {}

function APOTHECARY_HOLLAND.OoCRandomChat( unit )

	if( unit:IsInCombat() == false )
	then
		unit:SendChatMessage( 12, 1, chat[ math.random( 1, 8 ) ] );
	end
end

function APOTHECARY_HOLLAND.OnSpawn( unit )

	unit:RegisterEvent( APOTHECARY_HOLLAND.OoCRandomChat, math.random( 10000, 20000 ), 1 );
	unit:RegisterEvent( APOTHECARY_HOLLAND.OoCRandomChat, math.random( 40000, 60000 ), 0 );
end

RegisterUnitEvent( 10665, 18, APOTHECARY_HOLLAND.OnSpawn );
