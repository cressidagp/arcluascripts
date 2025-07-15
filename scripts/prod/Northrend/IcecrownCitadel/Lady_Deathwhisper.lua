--[[

PHASE_ALL       = 0
PHASE_INTRO     = 1
PHASE_ONE       = 2
PHASE_TWO       = 3
	
--]]

local self = getfenv( 1 )

function LadyDeathwhisper_onSpawn( unit, event )

	self[ tostring( unit ) ] = {
	
		waveCounter = 0,
		nextVengefulShadeTargetGUID = 0,
		cultistQueue = 0,
		darnavanGUID = 0,
		dominateMindCount = { 0, 1, 1, 3 },
		action = 0,
		chat = 0,
		phase = 0

	}
	
	unit:RegisterAIUpdateEvent( 1000 )

end

function LadyDeathwhisper_doAction( unit )

	local vars = self[ tostring( unit ) ]
	
	local action = vars.action
	
	if action == 0 then
	
		unit:PlaySoundToSet( 17272 )
	
		unit:SendChatMessage( 14, 0, "You have found your way here, because you are among the few gifted with true vision in a world cursed with blindness." )
		
		vars.phase = 1
		
		vars.chat = 10
		
	elseif action == 1 then
	
		unit:PlaySoundToSet( 17273 )
		
		unit:SendChatMessage( 14, 0, "You can see through the fog that hangs over this world like a shroud, and grasp where true power lies." )
		
		vars.chat = 21
	
	elseif action == 3 then
	
		unit:PlaySoundToSet( 16878 )
		
		unit:SendChatMessage( 14, 0, "Fix your eyes upon your crude hands: the sinew, the soft meat, the dark blood coursing within." )
		
		vars.chat = 11
		
	elseif action == 4 then
	
		unit:PlaySoundToSet( 17268 )
		
		unit:SendChatMessage( 14, 0, "It is a weakness; a crippling flaw....  A joke played by the Creators upon their own creations." )
		
		vars.chat = 9
		
	elseif action == 5 then
	
		unit:PlaySoundToSet( 17269 )
		
		unit:SendChatMessage( 14, 0, "The sooner you come to accept your condition as a defect, the sooner you will find yourselves in a position to transcend it." )
		
		vars.chat = 21
		
	elseif action == 6 then
	
		unit:PlaySoundToSet( 17270 )
		
		unit:SendChatMessage( 14, 0, "Through our Master, all things are possible. His power is without limit, and his will unbending." )
		
		vars.chat = 10
		
	elseif action == 7 then
	
		unit:PlaySoundToSet( 17271 )
		
		unit:SendChatMessage( 14, 0, "Those who oppose him will be destroyed utterly, and those who serve -- who serve wholly, unquestioningly, with utter devotion of mind and soul -- elevated to heights beyond your ken." )
		
		vars.chat = nil
		
	end
	
	action = action + 1
	
	vars.action = action

end

function LadyDeathwhisper_onEnterCombat( unit, event, attacker )

	local vars = self[ tostring( unit ) ]
	
	vars.phase = 2
	vars.deathNdecay = 17
	vars.dominateMinds = math.random( 40, 45 )
	vars.berserk = 10 * 60 * 1000

end

function LadyDeathwhisper_onTargetDied( unit, event, victim )

	if victim:IsPlayer() == true then
	
		local chance = math.random( 0, 1 )
		
		if chance == 0 then
	
			unit:PlaySoundToSet( 16869 )
		
			unit:SendChatMessage( 14, 0, "Do you yet grasp the futility of your actions?" )
			
		else
		
			unit:PlaySoundToSet( 16870 )
			
			unit:SendChatMessage( 14, 0, "Embrace the darkness... darkness eternal.!" )
		
		end
	
	end
	
end

function LadyDeathwhisper_onAIUpdate( unit, event )

	local vars = self[ tostring( unit ) ]
	
	if vars.phase == 0 then return end
	
	if vars.phase == 1 then
	
		if vars.chat ~= nil then vars.chat = vars.chat - 1 end
		
		if vars.chat <= 0 then
		
			LadyDeathwhisper_doAction( unit )
		
		end
	
	end
	
	if vars.phase == 2 then
	
		if unit:GetNextTarget() == nil then
			unit:WipeThreatList()
			return 
		end
	
		vars.deathNdecay = vars.deathNdecay - 1
		vars.berserk = vars.berserk - 1
		
		if vars.deathNdecay <= 0 then
		
			target = unit:GetRandomPlayer( 0 )
			
			if target then
			
				unit:FullCastSpellOnTarget( 71001, target )
				
			end
		
		elseif vars.berserk <= 0 then
		
			unit:CastSpell( 26662 )
		
		end
	
	end

end

RegisterUnitEvent( 36855, 18, LadyDeathwhisper_onSpawn )
RegisterUnitEvent( 36855, 1, LadyDeathwhisper_onEnterCombat )
RegisterUnitEvent( 36855, 3, LadyDeathwhisper_onTargetDied )
RegisterUnitEvent( 36855, 21, LadyDeathwhisper_onAIUpdate )