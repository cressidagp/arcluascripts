--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E	
	
	Zone: Stormwind City
	Creature: Major Mattingly (14394)
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local SPELL_RALLYNG_CRY = 22888; -- Rallyng Cry of the Dragonslayer
--local SPELL_HOLY_LIGHT = 15493; -- Holy Light

--[[
local TEXT = { -- Yell, Yell, and them spawn onyxia head
[ 1 ] = "Behold the might of the Alliance! The dread lady, Onyxia, hangs from the arches! Let the rallying cry of the dragon slayer lift your spirits!";
[ 2 ] = "Citizens and allies of Stormwind, on this day, history has been made. <name> has laid waste to that which had attempted to usurp the rule of the kingdom. Gather round and join me in honoring our heroes.";
};
--]]

-- Start:
--local QUEST_1 = 7497; -- The Journey Has Just Begun

-- End:
--local QUEST_2 = 7496; -- Celebrating Good Times
--local QUEST_3 = 7497;

MAJOR_MATTINGLY = {}

function MAJOR_MATTINGLY.OnSpawn( unit, event )

	-- on ai update
	if( event == 21 )
	then
		local target = unit:GetClosestPlayer();
		if( target )
		then
			if( target:GetStanding( 12 ) >= 0 )
			then
				if( unit:GetDistanceYards( target ) <= 25 )
				then
					unit:FullCastSpellOnTarget( 15493, target ); -- Holy Light
				end
			end
		end
	
	-- on spawn
	else
		unit:RegisterAIUpdateEvent( 12000 );
	end
end

RegisterUnitEvent( 14394, 18, MAJOR_MATTINGLY.OnSpawn );