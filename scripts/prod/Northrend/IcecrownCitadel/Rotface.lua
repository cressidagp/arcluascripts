--[[

local NPC_ROTFACE = 36627

local SPELL_GREEN_ABOMINATION_HITTIN_YA_PROC = 70001
local SPELL_SLIME_SPRAY = 69508
local SPELL_MUTATED_INFECTION = 69674
local SPELL_VILE_GAS_TRIGGER = 72287

--]]

local self = getfenv( 1 )

function Rotface_onEnterCombat( unit, event, attacker )

	local vars = self[ tostring( unit ) ]
	
	vars.slimeSpray = 20
	vars.hastenInfections = 90
	vars.mutatedInfection = 14
	vars.infectionStage = 0
	vars.infectionCooldown = 14
	vars.vileGas = nil
	
	vars.raidMode = GetDungeonDifficulty()
	
	if vars.raidMode == 2 or vars.raidMode == 3 then
	
		vars.vileGas = math.random( 22, 27 )

	end
	
	unit:PlaySoundToSet( 16986 )
	
	--unit:SendChatMessage( 14, 0, "Weeeeee!" )
	
	--
	unit:CastSpell( 70001 )
	
end

function Rotface_onTargetDied( unit, event, victim )

	if victim:IsPlayer() == true then

		local chance = math.random( 0, 1 )

		if chance == 0 then

			unit:PlaySoundToSet( 16987 )
			unit:SendChatMessage( 14, 0, "I brokes-ded it..." )

		else

			unit:PlaySoundToSet( 16988 )
			unit:SendChatMessage( 14, 0, "Daddy make new toys out of you!" )

		end

	end

end

function Rotface_onAIUpdate( unit, event )

	if unit:GetNextTarget() == nil then
		unit:WipeThreatList()
		return 
	end

	if unit:GetAIState() == 2 then
		return
	end
	
	local vars = self[ tostring( unit ) ]
	
	vars.slimeSpray = vars.slimeSpray - 1
	vars.hastenInfections = vars.hastenInfections - 1
	vars.mutatedInfection = vars.mutatedInfection - 1
	
	if vars.vileGas ~= nil then vars.vileGas = vars.vileGas - 1 end
	

	if vars.slimeSpray <= 0 then
	
		-- target stuff
		-- summon stuff
		
		unit:SendChatMessage( 41, 0, "%s begins to cast Slime Spray!" )
		
		unit:CastSpell( 69508 )
		
		vars.slimeSplay = 20
	
	elseif vars.hastenInfections <= 0 then
	
		vars.infectionStage = vars.infectionStage + 1
		
		if vars.infectionStage < 4 then
		
			vars.infectionCooldown = vars.infectionCooldown - 2
			
			vars.hastenInfections = 90
			
		end

	elseif vars.mutatedInfection <= 0 then
	
		unit:CastSpell( 69674 )
		
		vars.mutatedInfection = vars.infectionCooldown
	
	elseif vars.vileGas <= 0 then
	
		unit:CastSpell( 72287 )
		
		vars.vileGas = math.random( 30, 35 )

	end

end

RegisterUnitEvent( 36627, 1, Rotface_onEnterCombat )
RegisterUnitEvent( 36627, 3, Rotface_onTargetDied )
RegisterUnitEvent( 36627, 21, Rotface_onAIUpdate )