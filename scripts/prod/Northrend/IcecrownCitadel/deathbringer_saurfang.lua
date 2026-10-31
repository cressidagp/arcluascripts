--[[

TODO:

*) The power should not auto regenerate (spell Zero Power)
*) faction 974 for Undead Scourge? thats the correct one?
*) move DoZoneInCombat to common.lua?
*) Highlord Saurfang its a vehicle, so his gossip on select wont work due arcemu bugs

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

// Helper to get id of the aura on different modes (HasAura(baseId) wont work)
local BOILING_BLOOD_HELPER RAID_MODE<int32>(72385, 72441, 72442, 72443)

local PHASE_ALL		= 0
local PHASE_INTRO_A	= 1
local PHASE_INTRO_H	= 2
local PHASE_COMBAT	= 3

--]]

local self = getfenv( 1 )

local deathbringerPos = { -496.3542, 2211.33, 541.1138, 0.0 }
local firstStepPos = { -541.3177, 2211.365, 539.2921, 0.0 }

local chargePos = {
    { -509.6505, 2211.377, 539.2872, 0.0 }, -- High Overlord Saurfang/Muradin Bronzebeard
    { -508.7480, 2211.897, 539.2870, 0.0 }, -- front left
    { -509.2929, 2211.411, 539.2870, 0.0 }, -- front right
    { -506.6607, 2211.367, 539.2870, 0.0 }, -- back middle
    { -506.1137, 2213.306, 539.2870, 0.0 }, -- back left
    { -509.0040, 2211.743, 539.2870, 0.0 }  -- back right
}

local chokePos = {

    { -514.4834, 2211.334, 549.2887, 0.0 }, -- High Overlord Saurfang/Muradin Bronzebeard
    { -510.1081, 2211.592, 546.3773, 0.0 }, -- front left
    { -513.3210, 2211.396, 551.2882, 0.0 }, -- front right
    { -507.3684, 2210.353, 545.7497, 0.0 }, -- back middle
    { -507.0486, 2212.999, 545.5512, 0.0 }, -- back left
    { -510.7041, 2211.069, 546.5298, 0.0 }  -- back right
}

local finalPos = { -563.7552, 2211.328, 538.7848, 0.0 }

function DoZoneInCombat( creature )

	local players = creature:GetInRangePlayers()
	
	if players then
	
		for _, player in ipairs (players) do
		
			if player:IsAlive() then
			
				creature:AttackReaction( player, 1, 0 )
			
			end
		end
	end
	
	--local target = unit:GetUInt64Value( 0x0006 + 0x000C )
end

local MISC = {}

--
--
-- Deathbringer Saurfang (37813)
--
--
function DeathbringerSaurfang_onSpawn( unit, event )

	self[ tostring( unit ) ] = {
	
		phase = 0, --default 0
		fallenChampionCastCount = 0,
		frenzied = false,
		dead = false,
		intro = 0,
		itime = 3	
	}
	
	unit:RegisterAIUpdateEvent( 1000 )
	
	--talkFromDB( unit, 7 )
	unit:UseAI()
	
	local vars = self[ tostring( unit ) ]
	
	if vars.phase == 1 then
	
		unit:SetPower( 0, 3 )
		--unit:RemoveFlag( 0x0006 + 0x0036, 0x00000800 ) -- dont regenerate power
		unit:CastSpell( 72242 ) -- Zero Power (nothing happen)
		unit:CastSpell( 72178 ) -- Blood Link (need dummy aura)
		unit:CastSpell( 72371 ) -- Blood Power
		unit:CastSpell( 72256 ) -- Mark of the Fallen Champion S (nothing happen)
		unit:CastSpell( 72408 ) -- Rune of Blood S (nothing happen)
		unit:RemoveAura( 26662 ) -- Berserk
		unit:RemoveAura( 72737 ) -- Frenzy
	end	
end

function DeathbringerSaurfang_onEnterCombat( unit, event, attacker )

	local vars = self[ tostring( unit ) ]
	
	if vars.dead then return end
	
	-- set active
	unit:UseAI()
	
	--DoZoneInCombat( unit )

	--unit:SetFlag( 0x0006 + 0x004C, 0x00000100 ) -- inmuneToPC
	unit:SetFlag( 0x0006 + 0x0035, 0x00000100 ) -- inmuneToPC
	
	-- set PHASE_COMBAT
	vars.phase = 3
	
	if vars.introDone == false then
	
		unit:CastSpell( 70572 ) -- Grip of Agony
	
	end
	
	vars.introDone = true
	--unit:SendChatMessage( 14, 0, "BY THE MIGHT OF THE LICH KING!" )

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
		
		unit:CastSpell( 72737 )
		
		unit:SendChatMessage( 41, 0, "%s goes into a frenzy!" )
	
	end
	
	local newHealth = currentHealth - damage
	
	if vars.dead == false and newHealth < 100000 then
	
		vars.dead = true
		
		unit:PlaySoundToSet( 16697 )
		
		-- db can do it
		--unit:SendChatMessage( 14, 0, "I... Am... Released..." )
		
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

	--	unit:PlaySoundToSet( 16697 )
	--	unit:RemoveAIUpdateEvent()
	--end
	
	if unit:GetAIState() == 2 then
		return
	end
	
	-- intro alliance
	if vars.phase == 1 then
	
		unit:PlaySoundToSet( 16697 ) --- test

		unit:RemoveAIUpdateEvent()

		vars.itime = vars.itime - 1
		
		if vars.itime <= 0 then
		

			
		end
			
	
	-- intro horde
	elseif vars.phase == 2 then
	
		vars.itime = vars.itime - 1
		
		if vars.itime <= 0 then
		
		
		
		end
			
	-- combat
	elseif vars.phase == 3 then

		vars.summonBloodBeast = vars.summonBloodBeast - 1
		vars.berserk = vars.berserk - 1
		vars.boilingBlood = vars.boilingBlood - 1
		vars.bloodNova = bloodNova - 1
		vars.runeOfBlood = runeOfBlood - 1

		if vars.summonBloodBeast <= 0 then

			unit:CastSpell( 72172 )
			vars.summonBloodBeast = 40

		elseif vars.bloodNova <= 0 then

			unit:CastSpell( 72378 ) -- trigger
			vars.bloodNova = math.random( 20, 25 )

		elseif vars.runeOfBlood <= 0 then

			unit:CastSpell( 72410 )
			vars.runeOfBlood = math.random( 20, 25 )

		elseif vars.boilingBlood <= 0 then

			unit:CastSpell( 72385 )
			vars.boilingBlood = math.random( 15, 20 )

		elseif vars.berserk <= 0 then

			unit:CastSpell( 26662 )

		elseif vars.scentOfBlood <= 0 then

			unit:CastSpell( 72769 )
		end
	end 
end

function DeathbringerSaurfang_doAction( unit )

	local vars = self[ tostring( unit ) ]

	if action == 1 or action == 2 then
	
		vars.phase = action
		
		unit:MoveTo( -541.3177, 2211.365, 539.2921, 0 )
		
		if vars.phase == 1 then
		
			if subaction == 1 then
			
				unit:PlaySoundToSet( 16701 )
				
				unit:SendChatMessage( 14, 0, "For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King's armies grew. Even now the val'kyr work to raise your fallen as Scourge." )
			
			elseif subaction == 2 then
			
				unit:PlaySoundToSet( 16702 )
				
				unit:SendChatMessage( 14, 0, "Things are about to get much worse. Come, taste the power that the Lich King has bestowed upon me!" )
			
			end
		
		
		elseif vars.phase == 2 then
		
			unit:PlaySoundToSet( 16704 )
			
			unit:SendChatMessage( 14, 0, "Join me, father. Join me and we will crush this world in the name of the Scourge -- for the glory of the Lich King!" )
		
		end
	
	elseif action == 3 then
	
		if vars.phase == 1 then
		
			if subaction == 1 then
			
				unit:PlaySoundToSet( 16703 )
				
				unit:SendChatMessage( 14, 0, "Dwarves..." )
			
				vars.chat = 8
			
			elseif subaction == 2 then
				
				unit:SendChatMessage( 16, 0, "%s immobilizes Muradin and his guards." )
			
			end
		
		
		
		elseif var.phase == 2 then
		
		
		
		end
	
	end

end

--
--
-- High Overlord Saurfang (37187)
--
--
function HighOverlordSaurfang_onSpawn( unit, event )

	local v = unit:GetVehicleBase()
	
	self[ tostring( unit ) ] = {
	
		phase = 0,
		fallenChampionCastCount = 0,
		frenzied = false,
		dead = false
		
	}
	
	unit:RegisterAIUpdateEvent( 1000 )
	
	unit:SetNPCFlags( 3 )

	unit:SetFlag( 0x0006 + 0x0035, 0x00000100 ) -- inmuneToPC

	-- removed vehicle enter option
	unit:RemoveFlag( 0x0006 + 0x004C, 0x01000000 ) --UNIT_NPC_FLAG_SPELLCLICK
	unit:RemoveFlag( 0x0006 + 0x004C, 0x02000000 ) --UNIT_NPC_FLAG_PLAYER_VEHICLE
	
end

function HighOverlordSaurfang_onHello( unit, event, plr )

	local db = GetInstanceCreature( 631, unit:GetInstanceID(), 133784 )

	if not db then unit:SendChatMessage( 12, 0, "Explore a little then return to avoid ArcEmu buggs." ) return end

	--unit:GossipSendQuickMenu(15218, plr, 1, 0, "Lok'tar ogar! We are ready! Onward, brother orc!", 0, "money", 0)
	
	unit:GossipCreateMenu( 15217, plr, 0 )
	
	unit:GossipMenuAddItem( 0, "We are ready to go, High Overlord. The Lich King must fall!", 0, 0 )
	
	unit:GossipSendMenu( plr )

end

function HighOverlordSaurfang_onSelectOption( unit, event, plr, id, option, code )
	
	if option == 0 then
	
		unit:GossipCreateMenu( 15218, plr, 0 )

		unit:GossipMenuAddItem( 0, "Lok'tar ogar! We are ready! Onward, brother orc!", 1, 0 )

		unit:GossipSendMenu( plr )
		
	elseif option == 1 then

		plr:GossipComplete()
		
		OverlordDoAction( unit, 0 )

	end
end

function OverlordDoAction( unit, actionId )

	local db = GetInstanceCreature( 631, unit:GetInstanceID(), 133784 )
	
	local vars = self[ tostring( db ) ]
	local vars2 = self[ tostring( unit ) ]


	--local iid = unit:GetInstanceID()

	--
	-- Action Start Event
	--
	if actionId == 0 then

		vars.phase = 2
		unit:SetNPCFlags( 0 )
		unit:PlaySoundToSet( 17103 )
		vars2.timer = 18

	--	MISC[ iid ].phase = 1

	--
	-- Action Start Outro
	--
	elseif actionId == 1 then

		-- do something else

	--
	-- Action Interrup Intro
	--
	elseif actionId == 2 then

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
			local vars = self[ tostring( unit ) ]
			vars.timer = 5
			vars.eventId = 5
            
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

	if not db then unit:SendChatMessage( 12, 0, "Explore a little then return to avoid ArcEmu buggs." ) return end
	
	unit:GossipCreateMenu( 15194, plr, 0 )
	
	unit:GossipMenuAddItem( 0, "We're ready, Muradin", 0, 0 )
	
	unit:GossipSendMenu( plr )

end

function MuradinBronzebeard_onSelectOption( unit, event, plr, id, option, code )

	if option == 0 then

		unit:GossipCreateMenu( 15195, plr, 0 )
	
		unit:GossipMenuAddItem( 0, "We're sure. Let's go!", 1, 0 )

		unit:GossipSendMenu( plr )

	elseif option == 1 then
	
		plr:GossipComplete()

		MuradinDoAction( unit, 0 )

	end

end

function MuradinDoAction( unit, actionId )

	local db = GetInstanceCreature( 631, unit:GetInstanceID(), 133784 )
	
	local vars = self[ tostring( db ) ]
	local vars2 = self[ tostring( unit ) ]


	--local iid = unit:GetInstanceID()

	--
	-- Action Start Event
	--
	if actionId == 0 then

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
		vars2.timer = 29
		vars2.eventId = 4

	--	MISC[ iid ].phase = 1

	--
	-- Action Start Outro
	--
	elseif actionId == 1 then

		-- do something else

	--
	-- Action Interrup Intro
	--
	elseif actionId == 2 then

		-- so something more
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

			for i = 1, 4 do
				if vars2.guardList[ i ] then
					local guard = unit:GetUnitByGUID( vars2.guardList[ i ] )
					npcDoAction( guard, 0 )
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

function npcDoAction( unit, actionId )

	-- action charge
	if actionId == 0 then

		for i = 2, 5 do

			unit:SetMovementFlags( 1 ) -- run
			unit:MoveTo( chargePos[i][1],chargePos[i][2],chargePos[i][3],chargePos[i][4] )
		
		end

	else
		-- action despawn
	
	end
end

RegisterUnitEvent( 37813, 18, DeathbringerSaurfang_onSpawn )
RegisterUnitEvent( 37813, 1, DeathbringerSaurfang_onEnterCombat )
RegisterUnitEvent( 37813, 3, DeathbringerSaurfang_onTargetDied )
--RegisterUnitEvent( 37813, 4, DeathbringerSaurfang_onDied )
RegisterUnitEvent( 37813, 23, DeathbringerSaurfang_onDamageTaken )
RegisterUnitEvent( 37813, 21, DeathbringerSaurfang_onAIUpdate )

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

--
--
-- DEBUG STUFF
--
--

local COMMANDS = { "icc", "port", "exit", "spawn" }

function SaurfangDebugCommands( event, plr, message )

	if plr:IsGm() == true then

		if message == "#icc" then
		
			for i = 1, #COMMANDS do
			
				plr:SendBroadcastMessage( ""..COMMANDS[ i ].."" )
				
			end

		elseif message == "#saurfang" then
		
			plr:Teleport( 631, -510.48, 2211.29, 539.28, 0.06 )
			
		elseif message == "#faction" then
		
			local selection = plr:GetSelection()
			selection:SetFaction( 974 )
			selection:RemoveFlag(0x02000000)

		elseif message == "#spa" then
		
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
		
				print("SPAWN")
				print( i )
			
				selection:SpawnCreature( npc_entry[ team ][ i ], spawn_creature[ i ][ 1 ], spawn_creature[ i ][ 2 ], spawn_creature[ i ][ 3 ], spawn_creature[ i ][ 4 ], faction, 0, 1, 2, 3, phase )	
				selection:SpawnGameObject( go_entry[ team ][ i ], spawn_go[ i ][ 1 ], spawn_go[ i ][ 2 ], spawn_go[ i ][ 3 ], spawn_go[ i ][ 4 ], 0, 100, phase )
				
				end
		
			else
				plr:SendBroadcastMessage( "Select leader first." )
			end
		end
	end
end

RegisterServerHook( 16, SaurfangDebugCommands )