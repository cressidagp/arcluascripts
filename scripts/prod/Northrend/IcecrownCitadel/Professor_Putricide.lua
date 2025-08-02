--[[

local NPC_PROFESSOR_PUTRICIDE = 36678

local SPELL_OOZE_TANK_PROTECTION = 71770

local SPELL_SHADOWS_FATE = 71169
local SPELL_UNHOLY_INFUSION_CREDIT = 71518

local SPELL_MUTATED_PLAGUE_CLEAR = 72618

--]]

local self = getfenv( 1 )

function ProfessorPutricide_onSpawn( unit, event )

	self[ tostring( unit ) ] = {

		phase = 0, -- None
		raidMode = unit:GetDungeonDifficulty(),
		oozeFloodStage = 0,
		d = false

	}
	
	

end

function ProfessorPutricide_onEnterCombat( unit, event, attacker )

	local vars = self[ tostring( unit ) ]
	
	if not( vars.phase == 1 or vars.phase == 2 ) then
		return
	end
	
	vars.berserk = 60 * 10
	vars.slimePuddle = 10
	vars.unstableExperiment = math.random( 30, 35 )
	
	if vars.raidMode == 2 or vars.raidMode == 3 then
	
		vars.unboundPlague = 20
	
	end
	
	vars.phase = 4 -- Combat 1
	
	unit:PlaySoundToSet( 17114 )
	
	--unit:SendChatMessage( 14, 0, "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!" )
	
	unit:CastSpell( 71770 )

end

function ProfessorPutricide_onTargetDied( unit, event, victim )

	if victim:IsPlayer() == true then

		if math.random( 0, 1 ) == 0 then

			unit:PlaySoundToSet( 17115 )
			unit:SendChatMessage( 14, 0, "Hrm, interesting..." )

		else

			unit:PlaySoundToSet( 17116 )
			unit:SendChatMessage( 14, 0, "That was unexpected!" )

		end

	end

end

function ProfessorPutricide_onDied( unit, event, killer )

	unit:PlaySoundToSet( 17117 )
	
	--unit:SendChatMessage( 14, 0, "Bad news, everyone... I don't think I'm going to make it..." )
	
	local vars = self[ tostring( unit ) ]
	
	-- its 25MEN raid
	if vars.raidMode == 1 or vars.raidMode == 3 then
	
		--- spell: Shadows Fate
		if unit:HasAura( 71169 ) == true then
		
			---- spell: Unholy Infusion Credit
			unit:CastSpell( 71518 )
		
		end
	
	end
	
	-- spell: Mutated Plague Clear
	unit:CastSpell( 72618 )

end

function ProfessorPutricide_doAction( unit, action )

	local vars = self[ tostring( unit ) ]
	
	--
	-- Festergut in combat
	--
	if action == 0 then
	
		vars.phase = 1
		
		unit:MoveTo( 4324.820, 3166.03, 389.3831, 3.316126 )
	
	--
	-- Rotface in combat
	--
	elseif action == 3 then
	
		vars.phase = 2
		
		unit:MoveTo( 4390.371, 3164.50, 389.3890, 5.497787 )
	
	end

end

function ProfessorPutricide_onAIUpdate( unit, event )

	if unit:GetNextTarget() == nil then
		unit:WipeThreatList()
		return 
	end

	if unit:GetAIState() == 2 then
		return
	end
	
	local vars = self[ tostring( unit ) ]
	
end

RegisterUnitEvent( 36678, 18, ProfessorPutricide_onSpawn )
RegisterUnitEvent( 36678, 1, ProfessorPutricide_onEnterCombat )
RegisterUnitEvent( 36678, 3, ProfessorPutricide_onTargetDied )
RegisterUnitEvent( 36678, 4, ProfessorPutricide_onDied )
RegisterUnitEvent( 36678, 21, ProfessorPutricide_onAIUpdate )