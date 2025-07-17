--[[

PHASE_ALL		= 0
PHASE_INTRO_A	= 1
PHASE_INTRO_H	= 2
PHASE_COMBAT	= 3

TODO:

*) alliance intro
*) horde intro
*) muradin
*) highlord
*) combat
*) archivment stuff

--]]

local self = getfenv( 1 )

function DeathbringerSaurfang_onSpawn( unit, event )

	self[ tostring( unit ) ] = {
	
		phase = 1, --default 0
		fallenChampionCastCount = 0,
		frenzied = false,
		dead = false,
		intro = 0,
		itime = 3
		
	}
	
	unit:RegisterAIUpdateEvent( 1000 )
	
end

function DeathbringerSaurfang_doAction( unit )

	local vars = self[ tostring( unit ) ]

	if action == 1 or action == 2 then
	
		vars.phase = action
	
	end

end

function DeathbringerSaurfang_onEnterCombat( unit, event, attacker )

	local vars = self[ tostring( unit ) ]
	
	vars.phase = 3
	
	vars.summonBloodBeast = 30
	vars.berserk = 60 * 6
	vars.boilingBlood = 16
	vars.bloodNova = 17
	vars.runeOfBlood = 20
	
	if vars.introDone == false then
	
		-- grip of agony
		unit:CastSpell( 70572 )
	
	end
	
	vars.introDone = true
	
	unit:PlaySoundToSet( 16694 )
	
	unit:SendChatMessage( 14, 0, "BY THE MIGHT OF THE LICH KING!" )
	
end

function DeathbringerSaurfang_onTargetDied( unit, event, victim )

	if victim:IsPlayer() == true then

		local chance = math.random( 0, 1 )

		if chance == 0 then

			unit:PlaySoundToSet( 16695 )

			unit:SendChatMessage( 14, 0, "You are nothing!" )

		else

			unit:PlaySoundToSet( 16696 )

			unit:SendChatMessage( 14, 0, "Your soul will find no redemption here!" )

		end

	end

end

function DeathbringerSaurfang_onDied( unit, event, killer )

	unit:PlaySoundToSet( 16697 )
	
	unit:SendChatMessage( 14, 0, "I... Am... Released..." )

end

function DeathbringerSaurfang_onDamageTaken( unit, event, attacker, damage )

	local currentHealth = unit:GetHealth()
	
	if damage >= currentHealth then
	
		damage = currentHealth - 1
	
	end
	
	local vars = self[ tostring( unit ) ]
	
	if vars.frenzied == false and unit:GetHealthPct() < 31 then
	
		vars.frenzied = true
		
		unit:CastSpell( 72737 )
		
		unit:SendChatMessage( 41, 0, "%s goes into a frenzy!" )
	
	end
	
	local newHealth = currentHealth - damage
	
	if vars.dead == false and newHealth < 100000 then
	
		vars.dead = true
		
		unit:PlaySoundToSet( 16697 )
		
		unit:SendChatMessage( 14, 0, "I... Am... Released..." )
		
		-- cast: permanent feign death
		unit:CastSpell( 70628 )
	
	end

end

function DeathbringerSaurfang_onAIUpdate( unit, event )
	
	local vars = self[ tostring( unit ) ]
	
	if unit:GetNextTarget() == nil and not (vars.phase == 1 or vars.phase == 2) then
		return
	end
	
	--local vars = self[ tostring( unit ) ]
	
	--if vars.phase ~= 1 or vars.phase ~= 2 then
	--	return
	--end
	
	if unit:GetAIState() == 2 then
		return
	end
	
	-- intro alliance
	if vars.phase == 1 then
	
		vars.itime = vars.itime - 1
		
		if vars.itime <= 0 then
		
			local intro = vars.intro
			
			if intro == 0 then
			
				unit:PlaySoundToSet( 16701 )
			
				unit:SendChatMessage( 14, 0, "For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King's armies grew. Even now the val'kyr work to raise your fallen as Scourge." )
			
				vars.itime = 20
		
			elseif intro == 1 then
			
				unit:PlaySoundToSet( 16702 )
				
				unit:SendChatMessage( 14, 0, "Things are about to get much worse. Come, taste the power that the Lich King has bestowed upon me!" )
			
			end
		
			intro = intro + 1
		
			vars.intro = intro
			
		end
			
	
	-- intro horde
	elseif vars.phase == 2 then
	
	-- combat
	elseif vars.phase == 3 then
	
	end 
	
end

--
--
-- High Overlord Saurfang (37187)
--
--
function HighOverlordSaurfang_onSpawn( unit, event )

	self[ tostring( unit ) ] = {
	
		phase = 0,
		fallenChampionCastCount = 0,
		frenzied = false,
		dead = false
		
	}
	
	unit:RegisterAIUpdateEvent( 1000 )
	
end

function HighOverlordSaurfang_onAIUpdate( unit, event )
end

--
--
-- Muradin Bronzebeard (37200)
--
--
function MuradinBronzebeard_onSpawn( unit, event )

	self[ tostring( unit ) ] = {
	
		phase = 0,
		fallenChampionCastCount = 0,
		frenzied = false,
		dead = false
		
	}
	
	unit:RegisterAIUpdateEvent( 1000 )
	
end

function MuradinBronzebeard_onAIUpdate( unit, event )
end

RegisterUnitEvent( 37813, 18, DeathbringerSaurfang_onSpawn )
RegisterUnitEvent( 37813, 1, DeathbringerSaurfang_onEnterCombat )
RegisterUnitEvent( 37813, 3, DeathbringerSaurfang_onTargetDied )
--RegisterUnitEvent( 37813, 4, DeathbringerSaurfang_onDied )
RegisterUnitEvent( 37813, 23, DeathbringerSaurfang_onDamageTaken )
RegisterUnitEvent( 37813, 21, DeathbringerSaurfang_onAIUpdate )

RegisterUnitEvent( 37187, 18, HighOverlordSaurfang_onSpawn )
RegisterUnitEvent( 37187, 21, HighOverlordSaurfang_onAIUpdate )

RegisterUnitEvent( 37200, 18, MuradinBronzebeard_onSpawn )
RegisterUnitEvent( 37200, 21, MuradinBronzebeard_onAIUpdate )