-- table to store metadata loaded from db
local LuaAI = {}
local CreatureAI = {}
local GameObjectAI = {}
local QuestAI = {}

-- main loader
local function LoadAIFromDB()
	
	local Q = WorldDBQuery("SELECT entry, type FROM lua_ai")
	
	if Q then
	
		repeat
		
			local entry = Q:GetColumn(0):GetUShort()
			
			LuaAI[entry] = {
			
				-- Creatures, GameObjects, Quests
				type = Q:GetColumn(1):GetUShort()

			}
			
		until not Q:NextRow()
			
	end

end

-- function to load data from db
local function LoadCreatureAIFromDB()

	local Q = WorldDBQuery("SELECT entry, idx, event_type, event_param1, event_param2, action_type, action_param1 FROM lua_creature_ai")
	
    if Q then
	
        repeat
		
            local entry = Q:GetColumn(0):GetUShort()
			local idx = Q:GetColumn(1):GetUShort()
			
            CreatureAI[entry] = {
							
                event_type = Q:GetColumn(2):GetUShort(),
				event_param1 = Q:GetColumn(3):GetUShort(),
				event_param2 = Q:GetColumn(4):GetUShort(),
                action_type = Q:GetColumn(5):GetUShort(),
				action_param1 = Q:GetColumn(6):GetUShort()
            }
			
            print(">> [AI] Loaded config for creature: "..entry)
			
        until not Q:NextRow()
    end
end

-- function to load data from db
local function LoadGameObjectAIFromDB()

	local Q = WorldDBQuery("SELECT entry, idx, event_type, event_param1, event_param2, action_type, action_param1 FROM lua_gameobject_ai")
	
	if Q then
	
		repeat
		
			local entry = Q:GetColumn(0):GetUShort()

			GameObjectAI[entry] = {
	
                event_type = Q:GetColumn(2):GetUShort(),
				event_param1 = Q:GetColumn(3):GetUShort(),
				event_param2 = Q:GetColumn(4):GetUShort(),
                action_type = Q:GetColumn(5):GetUShort(),
				action_param1 = Q:GetColumn(6):GetUShort()
            }
			
            print(">> [AI] Loaded config for gameobject: "..entry)
			
        until not Q:NextRow()
    end
end

-- function to load data from db
local function LoadQuestAIFromDB()

	local Q = WorldDBQuery("SELECT entry, idx, event_type, event_param1, event_param2, action_type, action_param1 FROM lua_quest_ai")
	
	if Q then
	
		repeat
		
			local entry = Q:GetColumn(0):GetUShort()

			QuestAI[entry] = {
	
                event_type = Q:GetColumn(2):GetUShort(),
				event_param1 = Q:GetColumn(3):GetUShort(),
				event_param2 = Q:GetColumn(4):GetUShort(),
                action_type = Q:GetColumn(5):GetUShort(),
				action_param1 = Q:GetColumn(6):GetUShort()
            }
			
            print(">> [AI] Loaded config for quest: "..entry)
			
        until not Q:NextRow()
    end
end

-- execute at script start
LoadAIFromDB()
--LoadCreatureAIFromDB()
--LoadGameObjectAIFromDB()
--LoadQuestAIFromDB()

--
-- OnSpawn
--
local function CreatureOnSpawn( unit, event )

	local entry = unit:GetEntry()
	
	local Q = WorldDBQuery("SELECT entry, idx, event_type, event_param1, event_param2, action_type, action_param1 FROM lua_creature_ai WHERE entry = '"..e.."'")
	
	if Q then
		
		local rowcount = Q:GetRowCount()
		
		CreatureAI[entry] = {
		
			spell = 0,
			minion = 0
		
		}
		
		repeat
		
			rowcount = rowcount - 1
		
			local event_type = Q:GetColumn(2):GetUByte()
			
			-- lets use 0 to simulate out of combat event
			if event_type == 0 then
			
				local action_type = Q:GetColumn(5):GetUByte()
				
				-- Cast Spell:
				if action_type == 1 then
				
					CreatureAI[entry].spell = Q:GetColumn(6):GetUShort()
					
					unit:RegisterEvent(OutOfCombatCast, math.random(Q:GetColumn(3):GetUShort(),Q:GetColumn(4):GetUShort()), 1)
				
				-- Summon Guardian:
				elseif action_type == 2 then
				
					CreatureAI[entry].minion = Q:GetColumn(6):GetUShort()
					
					unit:RegisterEvent(OutOfCombatGuardian, math.random(Q:GetColumn(3):GetUShort(),Q:GetColumn(4):GetUShort()), 1)
				
				end
				
			end
			
			Q:NextRow()
		
		until rowcount == 0
	end
end

function OutOfCombatCast( unit )
	
		local vars = CreatureAI[unit:GetEntry()]
		unit:CastSpell(vars.spell)
	
end

function OutOfCombatGuardian( unit )

	local vars = CreatureAI[unit:GetEntry()]
	unit:CreateGuardian(vars.minion, 0, 0, unit:GetLevel())

end
		
--
-- OnCombat event
--
local function OnEnterCombat( unit, event, enemy )

	local entry = unit:GetEntry()

end

--
-- OnLeaveCombat event 
--
local function OnLeaveCombat( unit, event, target )

	local entry = unit:GetEntry()

end

--
-- OnTargetDied event
--
local function OnTargetDied( unit, event, victim )

	local entry = unit:GetEntry()

end

--
-- OnDied event
--
local function OnDied( unit, event, killer )

	local entry = unit:GetEntry()

end

--
-- OnReachWaypoint event
--
local function OnReachWaypoint( unit, event, wpid, foward )

	local entry = unit:GetEntry()

end

--
-- OnAIUpdate event
--
local function OnAIUpdate( unit, event )

	local entry = unit:GetEntry()
	
end

--
-- OnDamageTaken event
--
local function OnDamageTaken( unit, event, damager, ammount )

	local entry = unit:GetEntry()

end

function GameObjectOnSpawn( go, event )

	print("gameobject spawn")

end

-- Registrar evento para cada NPC en nuestra tabla
for entry, _ in pairs(AI) do

	-- Creatures:
	if AI[entry].type == 1 then

		RegisterUnitEvent(entry, 18, CreatureOnSpawn)
		--RegisterUnitEvent(entry, 1, OnEnterCombat)
		--RegisterUnitEvent(entry, 2, OnLeaveCombat)
		--RegisterUnitEvent(entry, 3, OnTargetDied)
		--RegisterUnitEvent(entry, 4, OnDied)
		--RegisterUnitEvent(entry, 19, OnReachWaypoint)
		--RegisterUnitEvent(entry, 21, OnAIUpdate)
		--RegisterUnitEvent(entry, 23, OnDamageTaken)
		
	-- Gameobjects:
	elseif AI[entry].type == 2 then
	
		RegisterGameObjectEvent( entry, 2, GameObjectOnSpawn )
		
	-- Quests:
	elseif AI[entry].type == 3 then
	
	end
	
end