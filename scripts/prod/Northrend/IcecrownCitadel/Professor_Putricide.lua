--[[

local NPC_PROFESSOR_PUTRICIDE = 36678

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
SPELL_RELEASE_GAS_VISUAL = 69125

-- Shared spells:
SPELL_BERSERK2 = 47008

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
	
	if vars.phase == 1 or vars.phase == 2 then
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
	
	unit:SendChatMessage( 14, 0, "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!" )
	
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
	
		if unit:GetHealthPct() < 80 then
		
			-- action change phase
			
		end
	
	elseif vars.phase == 5 then
	
		if unit:GetHealthPct() < 35 then
		
			-- action change phase
		
		end
	
	end

end

function ProfessorPutricide_onReachWaypoint( unit, event, waypointId, foward )

	print("ON REACH WP")
	
	--
	-- Festergut
	--
	if waypointId == 1 then
	
		-- do
		
	--
	-- Rotface
	--
	elseif waypointId == 2 then
	
		-- do
	
	--
	-- Table
	--
	elseif waypointId == 3 then
	
		--unit:MoveToWaypoint()
	
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
	-- Festergut Death
	--
	elseif action == 2 then
	
		---todo
	
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
	
	--
	-- Rotface Death
	--
	elseif action == 5 then
	
		--todo
		
	--
	-- change phase
	--
	elseif action == 6 then
	
		--todo
	
	end

end

function ProfessorPutricide_onAIUpdate( unit, event )

	print("AI UPDATE")
	
	if unit:GetNextTarget() == nil then
		unit:WipeThreatList()
		return 
	end

	local vars = self[ tostring( unit ) ]
	
	-- dont bother with this func in rotface and festergut phase
	if vars.phase == 1 or vars.phase == 2 then
		return
	end

	-- dont bother with this func if unit is casting
	if unit:GetAIState() == 2 then
		return
	end
	
	vars.berserk = vars.berserk - 1
	vars.slimePuddle = vars.slimePuddle - 1
	vars.unstableExperiment = vars.unstableExperiment - 1
	
	if vars.berserk <= 0 then
	
		unit:CastSpell( 47008 )
		
		unit:PlaySoundToSet( 17118 )
		
		unit:SendChatMessage( 14, 0, "Great news, everyone!" )
		
		vars.berserk = 60 * 10
	
	elseif vars.slimePuddle <= 0 then
	
		-- todo target crap
		
		vars.slimePuddle = 35
		
	elseif vars.unstableExperiment <= 0 then
	
		unit:CastSpell( 70351 )
		
		unit:SendChatMessage( 41, 0, "%s begins to cast Unstable Experiment!" )
		
		vars.unstableExperiment = math.random( 30, 35 )
	
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