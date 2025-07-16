--[[

PHASE_ALL       = 0
PHASE_INTRO     = 1
PHASE_ONE       = 2
PHASE_TWO       = 3

TODO:

*) all archivment stuff
*) load a boss database entry for heach dungeon difficulty
*) SPELL_SHADOW_CHANNELING: dummy aura
*) SUMMON_SPIRITS: dummy spell
*) stop fucking elevator until boss is dead
*) darnavan quest and summon
	
--]]

local self = getfenv( 1 )

local cultist = { 37890, 37949 }

function LadyDeathwhisper_onSpawn( unit, event )

	-- SPELL_SHADOW_CHANNELING
	unit:CastSpell( 43897 )
	
	self[ tostring( unit ) ] = {
	
		waveCounter = 0,
		nextVengefulShadeTargetGUID = 0,
		cultistQueue = 0,
		darnavanGUID = 0,
		raidMode = unit:GetDungeonDifficulty(), 
		dominateMindCount = { 0, 1, 1, 3 },
		action = 0,
		chat = 0,
		phase = 0

	}
	
	unit:RegisterAIUpdateEvent( 1000 )

end

--
-- @dfighter1985 python state machine version lua
--
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
	
	if action == 8 then
	
		action = nil
		
	else
	
		action = action + 1
		
	end
	
	vars.action = action

end

function LadyDeathwhisper_onEnterCombat( unit, event, attacker )

	local vars = self[ tostring( unit ) ]
	
	vars.phase = 2
	
	if unit:IsRooted() == false then unit:Root() end
	
	vars.deathNdecay = 17
	vars.berserk = 10 * 60
	vars.shadowBolt = 2
	vars.summonW1 = 5
	
	if vars.raidMode ~= 0 then
	
		vars.dominateMinds = 27
	
	end
	
	unit:PlaySoundToSet( 16868 )
	
	-- SPELL_SHADOW_CHANNELING
	unit:RemoveAura( 43897 )
	
	-- SPELL_MANA_BARRIER
	unit:CastSpell( 70842 )

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

function LadyDeathwhisper_onDied( unit, event, killer )

	unit:PlaySoundToSet( 16871 )

end

function LadyDeathwhisper_onDamageTaken( unit, event, attacker, damage )

	local vars = self[ tostring( unit ) ]

	local currentMana = unit:GetMana()
	
	if vars.phase == 2 and damage > currentMana then
	
		unit:PlaySoundToSet( 16877 )
		
		unit:SendChatMessage( 14, 0, "Enough! I see I must take matters into my own hands!" )
		
		unit:SendChatMessage( 41, 0, "%s's Mana Barrier shimmers and fades away!" )
		
		vars.phase = 3
		
		if unit:IsRooted() == true then unit:Unroot() end
		
		unit:SetMana( 0 )
		
		-- SPELL_MANA_BARRIER
		unit:RemoveAura( 70842 )
		
		vars.frostbolt = 12
		vars.frostboltVolley = 20
		vars.touchOfInsignificance = 5
		vars.summonSpirits = 12
		
		-- heroic(s)
		if vars.raidMode >= 2 then
		
			vars.summonW2 = 45
		
		end
		
	else
		
		currentMana = currentMana - damage
		
		unit:SetMana( currentMana )
	
	end

end

function LadyDeathwhisper_summonWave( unit )

	local i = math.random( 1, 2 )
				
	unit:SpawnCreature( 37890, -578.7066, 2154.167, 51.01529, 1.692969, 14, 80000 ) -- 1 Left Door 1 (Cult Fanatic)
	unit:SpawnCreature( 37949, -598.9028, 2155.005, 51.01530, 1.692969, 14, 80000 ) -- 2 Left Door 2 (Cult Adherent)
	unit:SpawnCreature( 37890, -619.2864, 2154.460, 51.01530, 1.692969, 14, 80000 ) -- 3 Left Door 3 (Cult Fanatic)
	unit:SpawnCreature( 37949, -578.6996, 2269.856, 51.01529, 4.590216, 14, 80000 ) -- 4 Right Door 1 (Cult Adherent)
	unit:SpawnCreature( 37890, -598.9688, 2269.264, 51.01529, 4.590216, 14, 80000 ) -- 5 Right Door 2 (Cult Fanatic)
	unit:SpawnCreature( 37949, -619.4323, 2268.523, 51.01530, 4.590216, 14, 80000 ) -- 6 Right Door 3 (Cult Adherent)
	unit:SpawnCreature( cultist[ i ], -524.2480, 2211.920, 62.90960, 3.141592, 14, 80000 ) -- 7 Upper (Random Cultist)
	
	local vars = self[ tostring( unit ) ]
	
	vars.waveCounter = vars.waveCounter + 1

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
	
	if vars.phase == 2 or vars.phase == 3 then
	
		if unit:GetNextTarget() == nil then
			unit:WipeThreatList()
			return 
		end
	
		vars.deathNdecay = vars.deathNdecay - 1
		vars.berserk = vars.berserk - 1
		
		if vars.dominateMinds ~= nil then
		
			vars.dominateMinds = vars.dominateMinds - 1
		
		end
		
		if vars.deathNdecay <= 0 then
		
			target = unit:GetRandomPlayer( 0 )
			
			if target then
			
				unit:CastSpellOnTarget( 71001, target )
				
			end
			
			vars.deathNdecay = math.random( 22, 30 )
		
		elseif vars.raidMode ~= 0 and vars.dominateMinds <= 0 then
		
			unit:PlaySoundToSet( 16876 )
			
			unit:SendChatMessage( 14, 0, "You are weak, powerless to resist my will!" )
			
			local targetList = {}
			
			local targetCandidates = unit:GetInRangePlayers()
			
			local targetCount = 0
			
			for i, v in ipairs( targetCandidates ) do 
			
				if v:HasAura( 71289 ) == false then
				
					table.insert( targetList, v )
					
					targetCount = targetCount + 1
					
					if count == vars.dominateMindCount[ vars.raidMode + 1 ] then
						
						break
							
					end
				
				end
			
			end
			
			for t = 1, #targetList do
			
				unit:CastSpellOnTarget( 71289, targetList[ t ] )
			
			end
			
			vars.dominateMinds = math.random( 40, 45 )
		
		elseif vars.berserk <= 0 then
			
			unit:PlaySoundToSet( 16872 )
			
			unit:SendChatMessage( 14, 0, "This charade has gone on long enough!" )
			
			unit:CastSpell( 26662 )
			
			vars.berserk = 10 * 60
		
		end
		
		if vars.phase == 2 then
		
			vars.shadowBolt = vars.shadowBolt - 1
			vars.summonW1 = vars.summonW1 - 1
			
			if vars.shadowBolt <= 0 then
			
				local target = unit:GetRandomPlayer( 0 )
				
				if target then
				
					unit:FullCastSpellOnTarget( 71254, target )
					
					vars.shadowBolt = math.random( 3, 4 )
				
				end
			
			elseif vars.summonW1 <= 0 then
			
				LadyDeathwhisper_summonWave( unit )

				vars.summonW1 = 45
			
			end
			
		elseif vars.phase == 3 then
		
			vars.frostbolt = vars.frostbolt - 1
			vars.frostboltVolley = vars.frostboltVolley - 1
			vars.touchOfInsignificance = vars.touchOfInsignificance - 1
			vars.summonSpirits = vars.summonSpirits - 1
		
			if vars.frostbolt <= 0 then
			
				target = unit:GetNextTarget()
				
				if target then
				
					unit:FullCastSpellOnTarget( 71420, target )
				
					vars.frostbolt = 12
					
				end
				
			elseif vars.frostboltVolley <= 0 then
			
				unit:FullCastSpell( 72905 )
				
				vars.frostboltVolley = 20
				
			elseif vars.touchOfInsignificance <= 0 then
			
				target = unit:GetNextTarget()
				
				if target then
				
					target:AddAura( 71204, -1 )
					
					vars.touchOfInsignificance = 5
					
				end
			
			elseif vars.summonSpirits <= 0 then
			
				unit:CastSpell( 72478 )
				
				vars.summonSpirits = 12
			
			elseif vars.summonW2 <= 0 then
			
				LadyDeathwhisper_summonWave( unit )
				
				vars.summonW2 = 45
			
			end
		
		end
	
	end

end

--
-- Darnavan
--

function ICC_Darnavan_onSpawn( unit, event )

	self[ tostring( unit ) ] = {
	
		canCharge = true,
		canShatter = true,
		bladestorm = 10,
		intimidatingShout = math.random( 20, 25 ),
		mortalStrike = math.random( 25, 30 ),
		sunderArmor = math.random( 5, 8 )

	}

end

function ICC_Darnavan_onAIupdate( unit, event )

	if unit:GetNextTarget() == nil then
		unit:WipeThreatList()
		return 
	end
	
	if unit:GetAIState() == 2 then
		return
	end
	
	local misc = self[ tostring( unit ) ]
	
	if misc.canShatter == true then
	
		unit:FullCastSpellOnTarget( 65940, target )
		
		misc.canShatter = false
		
		misc.shatteringThrow = 30
	
	end
	
	if misc.canCharge == true then
	
		unit:FullCastSpellOnTarget( 65927, target )
		
		misc.canCharge = false
		
		misc.charge = 20
	
	end
	
	if misc.shatteringThrow ~= nil then
	
		misc.shatteringThrow = misc.shatteringThrow - 1
	
	end
	
	if misc.charge ~= nil then
	
		misc.charge = misc.charge - 1
	
	end
	
	misc.bladestorm = misc.bladestorm - 1
	misc.intimidatingShout = misc.intimidatingShout - 1
	misc.mortalStrike = misc.mortalStrike - 1
	misc.sunderArmor = misc.sunderArmor = - 1
	
	if misc.bladestorm <= 0 then
	
		unit:FullCastSpell( 65947 )
		
		misc.bladestorm = math.random( 90, 100 )
	
	elseif misc.charge <= 0 then
	
		misc.canCharge = true
		misc.charge = nil
	
	elseif misc.intimidatingShout <= 0 then
	
		unit:FullCastSpell( 65930 )
		
		misc.intimidatingShout = math.random( 90, 120 )
	
	elseif misc.mortalStrike <= 0 then
	
		unit:FullCastSpell( 65926 )
		
		misc.mortalStrike = math.random( 15, 30 )
	
	elseif misc.shatteringThrow <= 0 then
	
		misc.canShatter = true
		misc.shatteringThrow = nil
	
	elseif misc.sunderArmor <= 0 then
	
		unit:FullCastSpell( 65936 )
		
		misc.sunderArmor = math.random( 3, 7 )
	
	end

end

RegisterUnitEvent( 36855, 18, LadyDeathwhisper_onSpawn )
RegisterUnitEvent( 36855, 1, LadyDeathwhisper_onEnterCombat )
RegisterUnitEvent( 36855, 3, LadyDeathwhisper_onTargetDied )
RegisterUnitEvent( 36855, 4, LadyDeathwhisper_onDied )
RegisterUnitEvent( 36855, 23, LadyDeathwhisper_onDamageTaken )
RegisterUnitEvent( 36855, 21, LadyDeathwhisper_onAIUpdate )

RegisterUnitEvent( 38472, 1, ICC_Darnavan_onAIupdate )
RegisterUnitEvent( 38485, 1, ICC_Darnavan_onAIupdate )
RegisterUnitEvent( 38472, 18, ICC_Darnavan_onSpawn )
RegisterUnitEvent( 38485, 18, ICC_Darnavan_onSpawn )