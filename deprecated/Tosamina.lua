--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Durotar
	Creature: Tosamina
	
	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:
	
	[ 1 ] = "You are mine now children. You will grow up to be a strong of the horde!",
	[ 2 ] = "It's my way or the Gold Road. Is that understood?",
	[ 3 ] = "Clean up this mess! We will not live in such squalor!",
	[ 4 ] = "Stop whining!"
	
	exMX locale:

--]]

--local NPC_TOSAMINA = 14498;

local chat = {
[ 1 ] = "You are mine now children. You will grow up to be a strong of the horde!",
[ 2 ] = "It's my way or the Gold Road. Is that understood?",
[ 3 ] = "Clean up this mess! We will not live in such squalor!",
[ 4 ] = "Stop whining!"
};

TOSAMINA = {}

function TOSAMINA.OoCRandomChat( unit, event )

	if( event == 21 )
	then
		if( unit:IsInCombat() == false )
		then
			unit:SendChatMessage( 12, 1, chat[ math.random( 1, 4 ) ] );
			unit:ModifyAIUpdateEvent( math.random( 150000, 180000 ) );	
		end
	
	else
	
		unit:RegisterAIUpdateEvent( math.random( 1000, 15000 ) );
	end
end

RegisterUnitEvent( 14498, 18, TOSAMINA.OoCRandomChat );
RegisterUnitEvent( 14498, 21, TOSAMINA.OoCRandomChat );
