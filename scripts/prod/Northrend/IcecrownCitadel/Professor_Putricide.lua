--[[

local NPC_PROFESSOR_PUTRICIDE = 36678
local VEHICLE_ID = 587

enum PutricidePhases
{
    PHASE_NONE          = 0,
    PHASE_FESTERGUT     = 1,
    PHASE_ROTFACE       = 2,
    PHASE_COMBAT_1      = 4,
    PHASE_COMBAT_2      = 5,
    PHASE_COMBAT_3      = 6
}

local SPELL_OOZE_TANK_PROTECTION = 71770

local SPELL_SHADOWS_FATE = 71169
local SPELL_UNHOLY_INFUSION_CREDIT = 71518

local SPELL_MUTATED_PLAGUE_CLEAR = 72618

-- Festergut:
local SPELL_RELEASE_GAS_VISUAL = 69125

-- Shared spells:
local SPELL_BERSERK2 = 47008

--]]

local self = getfenv( 1 )

function ProfessorPutricide_onSpawn( unit, event )

	self[ tostring( unit ) ] = {

		phase = 0, -- None
		raidMode = unit:GetDungeonDifficulty(),
		oozeFloodStage = 0,
		d = false

	}
	
	unit:RegisterAIUpdateEvent( 1000 )
	
	-- set movetype to wanted wp
	unit:SetMovementType( 3 )

end

function ProfessorPutricide_onEnterCombat( unit, event, attacker )

	print("ON ENTER COMBAT")
	
	local vars = self[ tostring( unit ) ]
	
	-- dont bother with this func on festergut and rotface phases
	if vars.phase == 1 or vars.phase == 2 then
		return
	end
	
	vars.berserk = 60 * 10
	vars.slimePuddle = 10
	vars.unstableExperiment = math.random( 30, 35 )
	
	-- is heroic
	if vars.raidMode == 2 or vars.raidMode == 3 then
	
		vars.unboundPlague = 20
	
	end
	
	vars.phase = 4 -- Combat 1
	
	unit:PlaySoundToSet( 17114 )
	
	unit:SendChatMessage( 14, 0, "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!" )
	
	-- spell: Ooze Tank Protection
	unit:CastSpell( 71770 )

end

function ProfessorPutricide_onLeaveCombat( unit, event, target )

	print("ON LEAVE COMBAT")

end

function ProfessorPutricide_onTargetDied( unit, event, victim )

	print("ON TARGET DIED")
	
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

	print("ON DIED")
	
	unit:PlaySoundToSet( 17117 )
	
	unit:SendChatMessage( 14, 0, "Bad news, everyone... I don't think I'm going to make it..." )
	
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

function ProfessorPutricide_onDamageTaken( unit, event, damager, ammount )

	print("ON DAMAGE TAKEN")
	
	-- dont bother with this if unit is casting
	if unit:GetAIState() == 2 then
		return
	end
	
	local vars = self[ tostring( unit ) ]
	
	if vars.phase == 4 then
	
		if unit:GetHealthPct() > 80 then
			return
		end
		
		-- react passive
		unit:DisableCombat()
			
		-- change phase
		ProfessorPutricide_doAction( unit, 6 )
			
	
	elseif vars.phase == 5 then
	
		if unit:GetHealthPct() > 35 then
			return
		end
		
		-- react passive
		unit:DisableCombat()
			
		-- change phase
		ProfessorPutricide_doAction( unit, 6 )
		
	end

end

function ProfessorPutricide_onReachWaypoint( unit, event, waypointId, foward )

	print("ON REACH WP")
	
	local vars = self[ tostring( unit ) ]
	
	--
	-- Festergut
	--
	if waypointId == 1 then
	
		-- Gas
		ProfessorPutricide_doAction( unit, 1 )
		
	--
	-- Rotface
	--
	elseif waypointId == 2 then
	
		-- Ooze
		ProfessorPutricide_doAction( unit, 4 )
		vars.rotfaceOozeFlood = 25
	
	--
	-- Table of Experiments
	--
	elseif waypointId == 3 then
	
		--unit:MoveToWaypoint()
		
		local go_table = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), 201584 )
		
		if go_table then 
		
			unit:SetFacing( go_table )
		
		end
		
		--local vars = self[ tostring( unit ) ]
		
		if vars.phase == 4 then
		
			-- spell: Create Concoction
			unit:CastSpell( 71621 )
			
			vars.phaseTransition = 5 --todo
		
		elseif vars.phase == 5 then
		
			-- spell: Guzzle Potions
			unit:CastSpell( 71893 )
			
			vars.phaseTransition = 5 --todo
		
		end
	
	end

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
	-- Festergut gas
	--
	elseif action == 1 then
			
		unit:PlaySoundToSet( 17119 )
		
		unit:SendChatMessage( 14, 0, "Just an ordinary gas cloud, but watch out because that's no ordinary gas cloud!" )
		
		unit:Emote( 432 )
		
		--- spell: Release Gas Visual
		unit:CastSpell( 69125 )
	
	--
	-- Festergut death
	--
	elseif action == 2 then
		
		vars.festergutDies = 4
	
	--
	-- Rotface in combat
	--
	elseif action == 3 then
	
		vars.phase = 2
		
		unit:MoveTo( 4390.371, 3164.50, 389.3890, 5.497787 )
		
	--
	-- Rotface Ooze
	--
	elseif action == 4 then
	
		local i = math.random( 0, 1 )
		
		if i == 0 then
		
			unit:PlaySoundToSet( 17126 )
			
			unit:SendChatMessage( 14, 0, "Great news, everyone! The slime is flowing again!" )
			
			
		else
		
			unit:PlaySoundToSet( 17123 )
			
			unit:SendChatMessage( 14, 0, "Good news, everyone! I've fixed the poison slime pipes!" )
			
		end
		
		unit:Emote( 1 )
		
		-- dummy creature crap
		
		vars.oozeFloodStage = vars.oozeFloodStage + 1
		
		if vars.oozeFloodStage == 4 then

			vars.oozeFloodStage = 0
			
		end
	
	--
	-- Rotface death
	--
	elseif action == 5 then
	
		vars.rotfaceDies = 5
		
	--
	-- change phase
	--
	elseif action == 6 then
	
		-- not heroic
		if not vars.raidMode == 2 or vars.raidMode == 3 then
		
			-- cast: Tear Gas
			unit:CastSpell( 71617 )
			
			vars.tearGas = 3
		
		else
		
			unit:PlaySoundToSet( 17122 )
			
			unit:SendChatMessage( 14, 0, "Two oozes, one room. So many delightful possibilities!" )
			
			-- cast: Unstable Experiment
			unit:CastSpell( 70351 )
			
			-- its 25 man
			if vars.raidMode == 1 or vars.raidMode == 3 then
			
				-- lot of spell crap variables
				-- lot of spell crap variables
				-- lot of spell crap variables
			
			end
			
			-- move to table
		
		end
		
		if vars.phase == 3 then
		
			vars.phase = 4
			
			vars.malleableGoo = math.random( 21, 26 )
			
			vars.chockingGasBomb = math.random( 35, 40 )
		
		elseif vars.phase == 4 then
		
			vars.phase = 5
			
			vars.mutatedPlague = 25
			
			vars.unstableExperiment = nil
		
		end 
	
	end

end

function ProfessorPutricide_onAIUpdate( unit, event )

	--print("AI UPDATE")

	local vars = self[ tostring( unit ) ]
	
	-- dont bother with this func if not rotface or festergut phase and not target
	if not ( vars.phase == 1 or vars.phase == 2 ) and not unit:GetNextTarget() then
		return
	end

	-- dont bother with this func if unit is casting
	if unit:GetAIState() == 2 then
		return
	end
	
	vars.festergutDies = vars.festergutDies - 1
	vars.rotfaceDies = vars.rotfaceDies - 1
	vars.berserk = vars.berserk - 1
	vars.slimePuddle = vars.slimePuddle - 1
	vars.unstableExperiment = vars.unstableExperiment - 1
	
	if vars.festergutDies <= 0 then
	
		unit:PlaySoundToSet( 17124 )
		
		unit:SendChatMessage( 14, 0, "Oh Festergut, you were always my favorite -- next to Rotface.  The good news is that you left behind so much gas. I can practically taste it!" )
	
	elseif vars.festergutGoo <= 0 then
	
		--cast aoe spell
		
		if vars.raidMode == 1 or vars.raidMode == 3 then
		
			vars.festergutGoo = math.random( 10, 15 )
			
		else
		
			vars.festergutGoo = math.random( 30, 35 )
		
		end
	
	elseif vars.rotfaceDies <= 0 then
	
		unit:PlaySoundToSet( 17146 )
		
		unit:SendChatMessage( 14, 0, "Terrible news, everyone. Rotface is dead, but great news everyone! He left behind plenty of ooze for me to use! What? I'm a poet and I didn't know it... Astounding!" )
	
	elseif vars.rotfaceOozeFlood <= 0 then
	
		-- Rotface Ooze
		ProfessorPutricide_doAction( unit, 4 )
		
		vars.rotfaceOozeFlood = 25
	
	elseif vars.berserk <= 0 then
	
		unit:CastSpell( 47008 )
		
		unit:PlaySoundToSet( 17118 )
		
		unit:SendChatMessage( 14, 0, "Great news, everyone!" )
		
		vars.berserk = 60 * 10
	
	elseif vars.slimePuddle <= 0 then
	
		-- todo target crap
		
		-- spell: Slime Puddle Trigger
		unit:CastSpellOnTarget( 70341, unit:GetRandomPlayer() )
		
		vars.slimePuddle = 35
		
	elseif vars.unstableExperiment <= 0 then
	
		unit:CastSpell( 70351 )
		
		unit:SendChatMessage( 41, 0, "%s begins to cast Unstable Experiment!" )
		
		vars.unstableExperiment = math.random( 30, 35 )
	
	elseif vars.tearGas <= 0 then
	
		-- spell: Tear Gas Perioric Trigger
		unit:CastSpell( 73170 )
		
	elseif vars.resumeAttack <= 0 then
	
		unit:EnableCombat()
		
		-- spell: Tear Gas Cancel
		unit:CastSpell( 71620 )
		
	elseif vars.malleableGoo <= 0 then
	
		unit:CastSpellOnTarget( 70852, unit:GetRandomPlayer() )
		
		vars.malleableGoo = math.random( 25, 30 )
		
	elseif vars.chockingGasBomb <= 0 then
		
		unit:SendChatMessage( 41, 0, "%s cast |cFFFF7F00Choking Gas Bomb!|r" )
		
		unit:CastSpell( 71255 )
		
		vars.chockingGasBomb = math.random( 35, 40 )
		
	elseif vars.unboundPlague <= 0 then
	
		local target = unit:GetRandomPlayer()
		
		-- spell: Unbound Plague
		unit:CastSpellOnTarget( 70911, target )
		
		-- spell: Unbound Plague Searcher
		unit:CastSpellOnTarget( 70917, target )
		
		vars.unboundPlague = 90
		
	elseif vars.mutatedPlague <= 0 then
	
		unit:CastSpellOnTarget( 72451, unit:GetRandomPlayer() )
		
		vars.mutatedPlague = 10
		
	elseif vars.phaseTransition <= 0 then
	
		if vars.phase == 4 then
		
			unit:PlaySoundToSet( 17120 )
			
			unit:SendChatMessage( 14, 0, "Hrm, I don't feel a thing. Wha?! Where'd those come from?" )
			
			vars.resumeAttack = 6
			
		elseif vars.phase == 5 then
		
			unit:PlaySoundToSet( 17121 )
			
			unit:SendChatMessage( 14, 0, "Tastes like... Cherry! OH! Excuse me!" )
			
			vars.resumeAttack = 9
			
		end
	
	end
	
end

RegisterUnitEvent( 36678, 18, ProfessorPutricide_onSpawn )
RegisterUnitEvent( 36678, 1, ProfessorPutricide_onEnterCombat )
RegisterUnitEvent( 36678, 2, ProfessorPutricide_onLeaveCombat )
RegisterUnitEvent( 36678, 3, ProfessorPutricide_onTargetDied )
RegisterUnitEvent( 36678, 4, ProfessorPutricide_onDied )
RegisterUnitEvent( 36678, 23, ProfessorPutricide_onDamageTaken )
RegisterUnitEvent( 36678, 19, ProfessorPutricide_onReachWaypoint )
RegisterUnitEvent( 36678, 21, ProfessorPutricide_onAIUpdate )