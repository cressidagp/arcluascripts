--[[ ICC: Deathbringer Saurfang

TODO:

*) faction 974 for Undead Scourge? thats the correct one?
*) move DoZoneInCombat to common.lua?
*) Highlord Saurfang its a vehicle, so his gossip on select wont work due arcemu bugs
*) Grip of Agony need a dummy aura.

local NPC_DEATHBRINGER_SAURFANG = 37813
local NPC_OVERLORD_SAURFANG = 37187
local NPC_MURADIN_BRONZEBEARD = 73200
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000
local FACTION_UNDEAD_SCOURGE = 974

// Deathbringer Saurfang:
local SPELL_ZERO_POWER                          = 72242
local SPELL_GRIP_OF_AGONY                       = 70572 // Intro
local SPELL_BLOOD_LINK                          = 72178
local SPELL_MARK_OF_THE_FALLEN_CHAMPION_S       = 72256
local SPELL_RUNE_OF_BLOOD_S                     = 72408

local SPELL_SUMMON_BLOOD_BEAST                  = 72172
local SPELL_SUMMON_BLOOD_BEAST_25_MAN           = 72356 // Additional cast, does not replace
local SPELL_FRENZY                              = 72737
local SPELL_BLOOD_NOVA_TRIGGER                  = 72378
local SPELL_BLOOD_NOVA                          = 72380
local SPELL_BLOOD_POWER                         = 72371
local SPELL_BLOOD_LINK_POWER                    = 72195
local SPELL_BLOOD_LINK_DUMMY                    = 72202
local SPELL_MARK_OF_THE_FALLEN_CHAMPION         = 72293
local SPELL_BOILING_BLOOD                       = 72385
local SPELL_RUNE_OF_BLOOD                       = 72410

// Blood Beast:
local SPELL_BLOOD_LINK_BEAST                    = 72176
local SPELL_RESISTANT_SKIN                      = 72723
local SPELL_SCENT_OF_BLOOD                      = 72769 // Heroic only

local SPELL_RIDE_VEHICLE                        = 70640 // Outro
local SPELL_ACHIEVEMENT                         = 72928
local SPELL_REMOVE_MARKS_OF_THE_FALLEN_CHAMPION = 72257
local SPELL_PERMANENT_FEIGN_DEATH               = 70628

local PHASE_ALL		= 0
local PHASE_INTRO_A	= 1
local PHASE_INTRO_H	= 2
local PHASE_COMBAT	= 3

--]]
local self = getfenv( 1 )

local deathbringerPos = { -496.3542, 2211.33, 541.1138, 0.0 }

local firstStepPos = { -541.3177, 2211.365, 539.2921, 0.0 }

local chargePos = {

    { -509.6505, 2211.377, 539.2872, 0.0 }, -- High Overlord Saurfang / Muradin Bronzebeard
    { -508.7480, 2211.897, 539.2870, 0.0 }, -- front left
    { -509.2929, 2211.411, 539.2870, 0.0 }, -- front right
    { -506.6607, 2211.367, 539.2870, 0.0 }, -- back middle
    { -506.1137, 2213.306, 539.2870, 0.0 }, -- back left
    { -509.0040, 2211.743, 539.2870, 0.0 }  -- back right
}

local chokePos = {

    { -514.4834, 2211.334, 549.2887, 0.0 }, -- High Overlord Saurfang / Muradin Bronzebeard
    { -510.1081, 2211.592, 546.3773, 0.0 }, -- front left
    { -513.3210, 2211.396, 551.2882, 0.0 }, -- front right
    { -507.3684, 2210.353, 545.7497, 0.0 }, -- back middle
    { -507.0486, 2212.999, 545.5512, 0.0 }, -- back left
    { -510.7041, 2211.069, 546.5298, 0.0 }  -- back right
}

local finalPos = { -563.7552, 2211.328, 538.7848, 0.0 }

local BOILING_BLOOD_HELPER = { 72385, 72441, 72442, 72443 }

function DoZoneInCombat( creature )

	local inRangePlayers = creature:GetInRangePlayers()
	
	if inRangePlayers then
	
		for _, targetPlayer in ipairs( inRangePlayers ) do
		
			if targetPlayer:IsAlive() then
			
				creature:AttackReaction( targetPlayer, 1, 0 )
				targetPlayer:AttackReaction( creature, 1, 0 )
				creature:ModThreat( targetPlayer, 0 )
			end
		end
	end
	--local target = unit:GetUInt64Value( 0x0006 + 0x000C )
end

--
--
-- Deathbringer Saurfang (37813)
--
--

local SAURFANG_ENERGY = {}

function BloodLink_DummyAura( unit )

	local vars = self[ tostring( unit ) ]

	if vars.phase ~= 3 then return end

	if unit:GetPower( 3 ) == unit:GetMaxPower( 3 ) then

		DeathbringerSaurfang_doAction( unit, 4 ) -- Action Mark of the Fallen Champion
	end
end

local function AddBloodPower( unit, amount )

	local guid = unit:GetGUID()

	if SAURFANG_ENERGY[guid] == nil then
        SAURFANG_ENERGY[guid] = 0
    end

	SAURFANG_ENERGY[guid] = SAURFANG_ENERGY[guid] + amount

	unit:SetPower(SAURFANG_ENERGY[guid], -3)

end

function DeathbringerSaurfang_onSpawn( unit, event )

	self[ tostring( unit ) ] = {
	
		raidMode = unit:GetDungeonDifficulty(),
		phase = 0, --default 0
		fallenChampionCastCount = 0,
		combatActive = false,
		frenzied = false,
		dead = false,
		introA = 0,
		itime = 3	
	}
	
	unit:RegisterAIUpdateEvent( 1000 )

	unit:RegisterEvent("BloodLink_DummyAura", 1000, 0)
	
	--talkFromDB( unit, 7 )
	unit:UseAI()
	
	local vars = self[ tostring( unit ) ]
	
	if vars.phase == 0 then
	
		unit:SetPower( 0, 3 )
		--unit:CastSpell( 72242 ) -- Zero Power
		--unit:CastSpell( 72178 ) -- Blood Link (need dummy aura)
		--unit:CastSpell( 72371 ) -- Blood Power
		unit:CastSpell( 72256 ) -- Mark of the Fallen Champion S (nothing happen)
		unit:CastSpell( 72408 ) -- Rune of Blood S (nothing happen)
		--unit:AddAura( 72256, -1)
		--unit:AddAura( 72408, -1)
		unit:RemoveAura( 26662 ) -- Berserk
		unit:RemoveAura( 72737 ) -- Frenzy

		-- set unit field flags
		unit:SetFlag( 0x0006 + 0x0035, 0x00000100 ) -- inmune to PC
		unit:SetFlag( 0x0006 + 0x0035, 0x02000000 ) -- uninteractible
		--unit:SetFlag( 0x0006 + 0x0036, 0x00000800 ) -- dont regenerate power
		--unit:SetFlag( 0x0006 + 0x0029, 0 ) -- dont regenerate power
	end
end

function DeathbringerSaurfang_onEnterCombat( unit, event, attacker )

	local vars = self[ tostring( unit ) ]

	if vars.dead then 
		return 
	end

	if vars.combatActive == true then return end

	vars.combatActive == true
	--DoZoneInCombat( unit )

	vars.phase = 3 -- set PHASE_COMBAT
	unit:RemoveFlag( 0x0006 + 0x0035, 0x00000100 ) -- inmuneToPC
	
	if vars.introDone == false then
	
		unit:CastSpell( 70572 ) -- Grip of Agony
	
	end
	
	vars.introDone = true

	unit:SendChatMessage( 14, 0, "BY THE MIGHT OF THE LICH KING!" )
	unit:PlaySoundToSet( 16694 )

	-- reset spell vars
	vars.summonBloodBeast = 30
	vars.berserk = 60 * 6
	vars.boilingBlood = 16
	vars.runeOfBlood = 20
	vars.bloodNova = 17
	
	vars.fallenChampionCastCount = 0
	
end

function DeathbringerSaurfang_onDied( unit, event, killer )
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

function DeathbringerSaurfang_onDamageTaken( unit, event, attacker, damage )

	local currentHealth = unit:GetHealth()
	
	if damage >= currentHealth then
		damage = currentHealth - 1
	end
	
	local vars = self[ tostring( unit ) ]
	
	if vars.frenzied == false and unit:GetHealthPct() < 31 then
	
		vars.frenzied = true
		unit:CastSpell( 72737 ) -- Frenzy
		unit:SendChatMessage( 41, 0, "%s goes into a frenzy!" )
	end
	
	local newHealth = currentHealth - damage
	
	if vars.dead == false and newHealth < 100000 then
	
		vars.dead = true
		unit:SetFlag( 0x0006 + 0x0035, 0x02000000 ) -- uninteractible
		unit:SetFlag( 0x0006 + 0x0035, 0x00000100 ) -- set inmune to PC
		unit:PlaySoundToSet( 16697 )
		-- db can do it:unit:SendChatMessage( 14, 0, "I... Am... Released..." )
		unit:CastSpell( 70628 ) -- Permanent Feign Death
	end
end

function DeathbringerSaurfang_onAIUpdate( unit, event )
	
	local vars = self[ tostring( unit ) ]
	
	if unit:GetNextTarget() == nil and not (vars.phase == 1 or vars.phase == 2) then
		return
	end

	--local iid = unit:GetInstanceID()
	--if MISC[ iid ].phase == 1 then

	-- is casting check
	if unit:GetAIState() == 2 then
		return
	end
	
	-- intro alliance
	if vars.phase == 1 then

		if vars.itime ~= nil then vars.itime = vars.itime - 1 end
		
		if vars.itime <= 0 then

			if vars.introA == 2 then

				unit:RemoveFlag( 0x0006 + 0x0035, 0x02000000 ) -- uninteractible
				unit:SetFaction( 974 ) -- Undead Scourge
				unit:PlaySoundToSet( 16701 )
				unit:SendChatMessage(14, 0, "For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King's armies grew. Even now the val'kyr work to raise your fallen as Scourge.")

				vars.introA = vars.introA + 1
				vars.itime = 20

			elseif vars.introA == 3 then

				unit:PlaySoundToSet( 16702 )
				unit:SendChatMessage(14, 0, "Things are about to get much worse. Come, taste the power that the Lich King has bestowed upon me!")
				--vars.itime = nil
				vars.introA = vars.introA + 1

			elseif vars.introA == 6 then

				unit:PlaySoundToSet( 16703 )
				unit:SendChatMessage(14, 0, "Dwarves...")
				vars.introA = vars.introA + 1
				vars.itime = 8

			elseif vars.introA == 7 then

				--unit:FullCastSpellOnTarget( 70572, unit ) -- Grip of Agony
				local inRangeEnemies = unit:GetInRangeEnemies()
				for _, e in ipairs( inRangeEnemies ) do
					if e:IsCreature() == true then
						local id = e:GetEntry()
						if id == 37200 or id == 37830 then
							e:AddAura( 70572, -1 )
						end
					end 
				end

				unit:SendChatMessage(16, 0, "%s immobilizes Muradin and his guards.")
				--vars.itime = nil
				vars.introA = vars.introA + 1

			elseif vars.introA == 8 then

				vars.phase = 3 -- combat
				unit:RemoveFlag( 0x0006 + 0x0035, 0x00000100 ) -- set inmune to pc false
				vars.introA = vars.introA + 1
			end

		end
			
	-- intro horde
	elseif vars.phase == 2 then
	
		vars.itime = vars.itime - 1
		
		if vars.itime <= 0 then

			if vars.introA == 2 then

				unit:RemoveFlag( 0x0006 + 0x0035, 0x02000000 ) -- uninteractible
				unit:SetFaction( 974 ) -- Undead Scourge

			end
		end
	
	--elseif vars.phase == 2 or vars.phase == 3 then

	-- combat
	elseif vars.phase == 3 then

		vars.summonBloodBeast = vars.summonBloodBeast - 1
		vars.berserk = vars.berserk - 1
		vars.boilingBlood = vars.boilingBlood - 1
		vars.bloodNova = vars.bloodNova - 1
		vars.runeOfBlood = vars.runeOfBlood - 1
		if vars.scentOfBlood ~= nil then vars.scentOfBlood = vars.scentOfBlood - 1 end

		if vars.summonBloodBeast <= 0 then

			for i = 1, 2 do 
				unit:CastSpell( 72172 ) -- summon bloodbeast
			end

			if vars.RaidMode == 1 or vars.RaidMode == 3 then

				for i = 1, 3 do
					unit:CastSpell( 72356 ) -- summon bloodbeast 25 man
				end
			end

			unit:SendChatMessage( 14, 0, "Feast, my minions!" )
			vars.summonBloodBeast = 40

			if vars.RaidMode == 2 or vars.RaidMode == 3 then
				vars.scentOfBlood = 10
			end

		elseif vars.bloodNova <= 0 then

			unit:FullCastSpell( 72378 ) -- trigger
			AddBloodPower( unit, 5 )
			vars.bloodNova = math.random( 20, 25 )

		elseif vars.runeOfBlood <= 0 then

			unit:CastSpell( 72410 )
			vars.runeOfBlood = math.random( 20, 25 )

		elseif vars.boilingBlood <= 0 then

			unit:CastSpell( 72385 )
			AddBloodPower( unit, 10 ) 
			vars.boilingBlood = math.random( 15, 20 )

		elseif vars.berserk <= 0 then

			unit:CastSpell( 26662 )
			unit:PlaySoundToSet( 16698 )
			unit:SendChatMessage(14, 0, "I have become... DEATH!")
		end

		if vars.RaidMode == 2 or vars.RaidMode == 3 then	
	
			if vars.scentOfBlood <= 0 then

				unit:SendChatMessage( 41, 0, "%s's Blood Beasts gain the scent of blood!" )
				unit:CastSpell( 72769 )
				vars.scentOfBlood = nil
			end
		end
	end 
end

function DeathbringerSaurfang_doAction( unit, actionId )

	local vars = self[ tostring( unit ) ]

	--
	-- Intro Alliance or Intro Horde
	--
	if actionId == 1 or actionId == 2 then
	
		vars.phase = actionId
		
		unit:MoveTo( deathbringerPos[1], deathbringerPos[2], deathbringerPos[3], 0 )

		--unit:CastSpell(72242) -- Zero Power
		--unit:SetPower( 0, 3 ) -- works here, but dont work on spawn
		
		if vars.phase == 1 then

			vars.introA = 2
			vars.itime = 3
			
		elseif vars.phase == 2 then
		
			vars.introA = 2
			vars.itime = 5
		
		end
	
	--
	-- Action Continue Intro
	--
	elseif actionId == 3 then

		if vars.phase == 1 then

			vars.introA = 6
			vars.itime = 7

		elseif vars.phase == 2 then

			vars.introA = 4
			vars.itime = 7

		end

	--
	-- Action Mark of the Fallen Champion
	--
	elseif actionId == 4 then

		local inRangeEnemies = unit:GetInRangeEnemies()
		if inRangeEnemies then
			for _, e in ipairs( inRangeEnemies ) do
				if e:IsPlayer() and e:IsAlive() and not e:HasAura(72293) then
					vars.fallenChampionCastCount = vars.fallenChampionCastCount + 1
					unit:CastSpellOnTarget(72293, e)
					unit:SetPower(0, 3)
					break
				end
			end
		end
	end
end

--
--
-- High Overlord Saurfang (37187)
--
--
function HighOverlordSaurfang_onSpawn( unit, event )

	unit:GetVehicleBase()
	
	self[ tostring( unit ) ] = {
	
		phase = 0,
		fallenChampionCastCount = 0,
		frenzied = false,
		dead = false
	}
	
	unit:RegisterAIUpdateEvent( 1000 )
	
	unit:SetNPCFlags( 3 )

	--unit:SetFlag( 0x0006 + 0x0035, 0x00000100 ) -- inmuneToPC
	--unit:SetFlag( 0x0006 + 0x0036, 0x00002000 ) -- preventSpellClick
	-- saurfang in love with player
	--unit:SetFlag(0x0006 + 0x004C, 33554432)
	-- removed vehicle enter option
	--unit:RemoveFlag( 0x0006 + 0x004C, 0x01000000 ) --UNIT_NPC_FLAG_SPELLCLICK
	---unit:SetFlag( 0x0006 + 0x004C, 0x02000000 ) --UNIT_NPC_FLAG_PLAYER_VEHICLE
end

function HighOverlordSaurfang_onHello( unit, event, plr )
	
	--print(unit:IsCreature())
	--print(unit:GetObjectType())
	--print(unit:GetGUID())
	--print(unit:GetUInt32Value(0x0006 + 0x004C))
	--print(unit:GetUInt32Value(0x0006 + 0x0035))
	--print(unit:GetUInt32Value(0x0006 + 0x0036))

	local db = GetInstanceCreature( 631, unit:GetInstanceID(), 133784 )
	if not db then unit:SendChatMessage( 12, 0, "Explore a little then return to avoid ArcEmu buggs." ) return end
	
	unit:GossipCreateMenu( 15217, plr, 0 )
	unit:GossipMenuAddItem( 0, "We are ready to go, High Overlord. The Lich King must fall!", 1, 0 )
	unit:GossipSendMenu( plr )
end

function HighOverlordSaurfang_onSelectOption( unit, event, plr, id, optionId, code )

	--print("DEBUG: SAURFANG GOSSIP CALLBACK EXECUTED")
    --print("DEBUG: selection = " .. tostring(selection))
    --unit:SendChatMessage(14, 0, "Lua callback reached!")

	if optionId == 1 then
	
		unit:GossipCreateMenu( 15218, plr, 0 )
		unit:GossipMenuAddItem( 0, "Lok'tar ogar! We are ready! Onward, brother orc!", 2, 0 )
		unit:GossipSendMenu( plr )
		
	elseif optionId == 2 then

		plr:GossipComplete()
		
		OverlordDoAction( unit, 1 ) -- Action Start Event
	end
end

function OverlordDoAction( unit, actionId )

	local db = GetInstanceCreature( 631, unit:GetInstanceID(), 133784 )
	
	local vars = self[ tostring( db ) ]
	local vars2 = self[ tostring( unit ) ]

	--
	-- Action Start Event
	--
	if actionId == 1 then

		local friends = unit:GetInRangeFriends()
		if friends then
			local i = 0
			for _, f in ipairs( friends ) do 
				if f:GetEntry() == 37920 then
					i = i + 1
					vars2.guardList[ i ] = f:GetGUID()
				end
			end
		end

		unit:SetNPCFlags( 0 )
		unit:PlaySoundToSet( 17103 )
		unit:SendChatMessage( 14, 0, "Kor'kron, move out! Champions, watch your backs. The Scourge have been..." )
		vars.phase = 2 -- intro horde
		vars2.timer = 19
		vars2.eventId = 3
		local door = unit:GetGameObjectNearestCoords( -469, 2211, 541, 201825 )
		if door then door:Activate() end
		-- get saurfang and do action intro?
		DeathbringerSaurfang_doAction( boss, 2 ) -- Intro Horde

	--	MISC[ iid ].phase = 1

	--
	-- Action Start Outro
	--
	elseif actionId == 2 then

		--remove aura grip of agony
		--set disable gravity
		--move fall
		--guard actions despawn

	--
	-- Action Interrup Intro
	--
	elseif actionId == 3 then

		-- so something more
	end
end

function HighOverlordSaurfang_onAIUpdate( unit, event )
end

--
--
-- Muradin Bronzebeard (37200)
--
--

-- Callback / Handler acting as the block of code executed after finishing the movement
function MovementInform(unit, currentId)

    local guid = tostring(unit:GetGUID())
    local moveData = ArcEmu_MovementData[guid]

     -- Verify if there is stored data for this movement
    if moveData and moveData.id == currentId then
        local id = moveData.id

        -- first step
        if id == 1 then 

            unit:PlaySoundToSet( 16970 )
			unit:SendChatMessage(14, 0, "A lone orc against the might of the Alliance???")
			local vars = self[ tostring( unit ) ]
			vars.timer = 7--5
			vars.eventId = 5

			local boss = GetInstanceCreature( 631, unit:GetInstanceID(), 133784 )
			DeathbringerSaurfang_doAction( boss, 3 ) -- Action Continue Intro
            
        --exit
		elseif id == 2 then

			--unit:DespawnGroup(LBC)
                
        	-- Clean up memory to prevent data leaks (Memory Leaks)
           	ArcEmu_MovementData[guid] = nil

        end
    end
end

function MuradinBronzebeard_onSpawn( unit, event )

	self[ tostring( unit ) ] = {
	
	--phase = 0,
	--	fallenChampionCastCount = 0,
	--	frenzied = false,
	--	dead = false
	--boss = GetInstanceCreature( 631, unit:GetInstanceID(), 133784 )
		guardList = { nil, nil, nil, nil },
		timer = nil,
		eventId = 0
		
	}

	--local iid = unit:GetInstanceID()

	--if MISC[ iid ] == nil then

	--	MISC[ iid ] = {
		
	--		phase = 0,
	--		muradin = nil,
	--		highlord = nil
	--	}

	--end

	--local deathbringer = GetInstanceCreature( 631, unit:GetInstanceID(), 133784 )

	unit:RegisterAIUpdateEvent( 1000 )
	
	unit:SetNPCFlags( 1 )
	
end

function MuradinBronzebeard_onHello( unit, event, plr )

	local db = GetInstanceCreature( 631, unit:GetInstanceID(), 133784 )

	if not db then unit:SendChatMessage( 12, 0, "Remember to explore a little to avoid ArcEmu buggs." ) return end
	
	unit:GossipCreateMenu( 15194, plr, 0 )
	
	unit:GossipMenuAddItem( 0, "We're ready, Muradin", 1, 0 )
	
	unit:GossipSendMenu( plr )

end

function MuradinBronzebeard_onSelectOption( unit, event, plr, id, optionId, code )

	if optionId == 1 then

		unit:GossipCreateMenu( 15195, plr, 0 )
	
		unit:GossipMenuAddItem( 0, "We're sure. Let's go!", 2, 0 )

		unit:GossipSendMenu( plr )

	elseif optionId == 2 then
	
		plr:GossipComplete()

		MuradinDoAction( unit, 1 ) -- Action Start Event

	end

end

function MuradinDoAction( unit, actionId )

	local boss = GetInstanceCreature( 631, unit:GetInstanceID(), 133784 )
	
	local vars = self[ tostring( boss ) ]
	local vars2 = self[ tostring( unit ) ]

	--
	-- Action Start Event
	--
	if actionId == 1 then

		vars.phase = 1 -- intro alliance

		local friends = unit:GetInRangeFriends()
		if friends then
			local i = 0
			for _, f in ipairs( friends ) do 
				if f:GetEntry() == 37830 then
					i = i + 1
					vars2.guardList[ i ] = f:GetGUID()
				end
			end
		end

		unit:SetNPCFlags( 0 ) -- remove gossip flag
		unit:PlaySoundToSet( 16974 )
		unit:SendChatMessage( 14, 0, "Let's get a move on then! Move ou..." )
		vars2.timer = 30--29,5
		vars2.eventId = 4
		local door = unit:GetGameObjectNearestCoords( -469, 2211, 541, 201825 )
		if door then door:Activate() end
		-- get saurfang and do action intro alliance
		DeathbringerSaurfang_doAction( boss, 1 ) -- Intro Alliance


	--	MISC[ iid ].phase = 1

	--
	-- Action Start Outro
	--
	elseif actionId == 2 then

		-- remove aura grip of agony
		unit:PlaySoundToSet( 16975 )
		unit:SendChatMessage( 16, 0, "%s gasps for air." )
		--disable gravity
		--move fall
		--guard actions despawn

	--
	-- Action Interrup Intro
	--
	elseif actionId == 3 then

		--guard actions despawn
	end
end

function MuradinBronzebeard_onAIUpdate( unit, event )

	local vars = self[ tostring( unit ) ]
	local vars2 = self[ tostring( unit ) ]

	if vars2.timer == nil then return end

	vars2.timer = vars2.timer - 1
	
	if vars2.timer <= 0 then
	
		if vars2.eventId == 4 then

			unit:SetMovementFlags( 0 ) -- walk
			--(unit, moveType, id, x, y, z, o, moveFlag)
			Creature_MovePoint(unit, 0, 1, firstStepPos[1], firstStepPos[2], firstStepPos[3], firstStepPos[4], 0)
			vars2.timer = nil
			--vars2.eventId = 5

		elseif vars2.eventId == 5 then

			unit:PlaySoundToSet( 16971 )
			unit:SendChatMessage( 14, 0, "Charge!!!" )

			for i = 1, 4 do
				if vars2.guardList[ i ] then
					local guard = unit:GetUnitByGUID( vars2.guardList[ i ] )
					npcDoAction( guard, 1, i + 1 ) -- Action Charge
				end
			end

			unit:SetMovementFlags( 1 ) -- run
			unit:MoveTo( chargePos[1][1], chargePos[1][2], chargePos[1][3], chargePos[1][4] )
			vars2.timer = nil

		end
	end
end

--
-- Skybreaker Marine (37830) // Kor'kron Reaver (37920)
--
function npcSaurfangEvent_onSpawn( unit, event ) end

function npcDoAction( unit, actionId, i )

	-- Action Charge
	if actionId == 1 then

		unit:SetMovementFlags( 1 ) -- run
		unit:MoveTo( chargePos[i][1],chargePos[i][2],chargePos[i][3],chargePos[i][4] )
		---for i = 2, 6 do

		--	unit:SetMovementFlags( 1 ) -- run
		--	unit:MoveTo( chargePos[i][1],chargePos[i][2],chargePos[i][3],chargePos[i][4] )
		
		--end

	-- Action Despawn
	elseif actionId == 2 then

		-- TODO:

	end
end

function BloodLink_DummySpell( effectIndex, spellObject )

	print(effectIndex)
	print(spellObject)

end

function DeathbringerSaurfang_onCastSpell( unit, event, spell )
	print(unit)
	print(event)
	print(spell)

end

RegisterUnitEvent( 37813, 18, DeathbringerSaurfang_onSpawn )
RegisterUnitEvent( 37813, 1, DeathbringerSaurfang_onEnterCombat )
RegisterUnitEvent( 37813, 3, DeathbringerSaurfang_onTargetDied )
--RegisterUnitEvent( 37813, 4, DeathbringerSaurfang_onDied )
RegisterUnitEvent( 37813, 23, DeathbringerSaurfang_onDamageTaken )
RegisterUnitEvent( 37813, 21, DeathbringerSaurfang_onAIUpdate )

--RegisterUnitEvent( 37813, 31, DeathbringerSaurfang_onCastSpell )

RegisterUnitGossipEvent( 37187, 1, HighOverlordSaurfang_onHello )
RegisterUnitGossipEvent( 37187, 2, HighOverlordSaurfang_onSelectOption )
RegisterUnitEvent( 37187, 18, HighOverlordSaurfang_onSpawn )
RegisterUnitEvent( 37187, 21, HighOverlordSaurfang_onAIUpdate )

RegisterUnitGossipEvent( 37200, 1, MuradinBronzebeard_onHello )
RegisterUnitGossipEvent( 37200, 2, MuradinBronzebeard_onSelectOption )
RegisterUnitEvent( 37200, 18, MuradinBronzebeard_onSpawn )
RegisterUnitEvent( 37200, 21, MuradinBronzebeard_onAIUpdate )

--RegisterUnitEvent( 37830, 18, npcSaurfangEvent_onSpawn )
--RegisterUnitEvent( 37920, 18, npcSaurfangEvent_onSpawn )

RegisterDummySpell( 72202, BloodLink_DummySpell )

--
--
-- DEBUG STUFF
--
--
local COMMANDS = { "saurfang", "s_port", "s_faction", "s_spawn", "s_ai" }

function SaurfangDebugCommands( event, plr, message )

	if plr:IsGm() == true then

		if message == "#saurfang" then
		
			for i = 1, #COMMANDS do
			
				plr:SendBroadcastMessage( ""..COMMANDS[ i ].."" )
				
			end

		elseif message == "#s_port" then
		
			plr:Teleport( 631, -510.48, 2211.29, 539.28, 0.06 )
			
		elseif message == "#s_faction" then
		
			local selection = plr:GetSelection()
			selection:SetFaction( 974 )
			selection:RemoveFlag(0x02000000)

		elseif message == "#s_spawn" then
		
			local selection = plr:GetSelection()
			
			if selection then
			
				local team = plr:GetTeam() + 1
				
				print(team)
				
				local faction = 0

				if team == 1 then
		
					faction = 1732
				else
					faction = 1735
				end
		
			local phase = selection:GetPhase()

			for i = 1, 2, 1 do

				selection:SpawnCreature( npc_entry[ team ][ i ], spawn_creature[ i ][ 1 ], spawn_creature[ i ][ 2 ], spawn_creature[ i ][ 3 ], spawn_creature[ i ][ 4 ], faction, 0, 1, 2, 3, phase )	
				selection:SpawnGameObject( go_entry[ team ][ i ], spawn_go[ i ][ 1 ], spawn_go[ i ][ 2 ], spawn_go[ i ][ 3 ], spawn_go[ i ][ 4 ], 0, 100, phase )
				
				end
		
			else
				plr:SendBroadcastMessage( "Select leader first." )
			end
			
		elseif message == "#s_ai" then
		
			local saurfang = GetInstanceCreature( 631, plr:GetInstanceID(), 133784 )
			if saurfang then 
				saurfang:UseAI() 
			end

		elseif message == "#s_mark" then
			local unit = GetInstanceCreature( 631, plr:GetInstanceID(), 133784 )
			DeathbringerSaurfang_doAction( unit, 4 )

		elseif message == "#s_power" then
			local unit = GetInstanceCreature( 631, plr:GetInstanceID(), 133784 )
			unit:SetPower(0,3)

		end
	end
end

RegisterServerHook( 16, SaurfangDebugCommands )