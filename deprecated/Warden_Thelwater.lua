--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Stormwind City 
	Creature: Warden Thelwater
	
	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:
	
	[ 1 ] = "How could this happen?",
	[ 2 ] = "All of a sudden they were everywhere.",
	[ 3 ] = "If the Captain finds out, it'll be the end of me.",
	[ 4 ] = "They must have had someone helping them.",
	[ 5 ] = "What am I going to do?"
	
	esMX locale:

	[ 1 ] = "¿Cómo pudo pasar esto?",
	[ 2 ] = "De repente estaban en todas partes.",
	[ 3 ] = "Si el Capitán se entera, será mi fin.",
	[ 4 ] = "Deben haber tenido a alguien ayudándoles.",
	[ 5 ] = "¿Qué es lo que haré?"

--]]

--local NPC_WARDEN_THELWATER = 1719;

local chat = {
[ 1 ] = "How could this happen?",
[ 2 ] = "All of a sudden they were everywhere.",
[ 3 ] = "If the Captain finds out, it'll be the end of me.",
[ 4 ] = "They must have had someone helping them.",
[ 5 ] = "What am I going to do?"
};

local WARDEN_THELWATER = {}

function WARDEN_THELWATER.OoCRandomChat( unit, event )

	if( event == 21 )
	then
		if( unit:IsInCombat() == false )
		then
			unit:SendChatMessage( 12, 7, chat[ math.random( 1, 5 ) ] );
			unit:ModifyAIUpdateEvent( math.random( 15000, 43000 ) );
		end
		
	else
	
		unit:RegisterAIUpdateEvent( math.random( 1000, 15000 ) );
	end
end

RegisterUnitEvent( 1719, 18, WARDEN_THELWATER.OoCRandomChat );
RegisterUnitEvent( 1719, 21, WARDEN_THELWATER.OoCRandomChat );
