-- Quest "The Endless Hunger" (12848)
-- UPDATE creature_spawns SET unitflags = 32768 WHERE entry IN (29519, 29520, 29565, 29566, 29567);

local self = getfenv( 1 )

local unworthyInitiate_id = { 29519, 29520, 29565, 29566, 29567 };

local unworthyInitiate_text_event = {

    "You have made a grave error, fiend!",
    "I was a soldier of the Light once... Look at what I have become... ",
    "You are hopelessly outmatched, $r.",
    "They brand me unworthy? I will show them unworthy!",
    "You will allow me a weapon and armor, yes?",
    "I will win my freedom and leave this cursed place!",
    "I will dismantle this festering hellhole!",
    "There can be only one survivor!"
}

local unworthyInitiate_text_attack = {

    "To battle!",
    "Let your fears consume you!",
    "HAH! You can barely hold a blade! Yours will be a quick death.",
    "And now you die!",
    "There is no hope for our future...",
    "Sate your hunger on cold steel, $r!",
    "It ends here!",
    "Death is the only cure!"
}

local acherusSoulPrison_id = {
	
    191577,
    191580,
    191581,
    191582,
    191583,
    191584,
    191585,
    191586,
    191587,
    191588,
    191589,
    191590
}

function Initialize( unit, event )

    local vars = self[ tostring( unit ) ]

    self[ tostring( unit ) ] = {
	
        anchorGUID = nil,
        phase = 1,
        pPlayer = nil,
        waitTime = 0
	}
end

function OnReset( unit, event )

    Initialize(unit)

    unit:SetFaction(7)
    unit:SetFlag( 0x0006 + 0x0035, 0x00000100 ) -- inmuneToPC
    --set standstate kneel
    unit:EquipWeapons(0,0,0)
    unit:SetMovementType(4) -- dont move wp

    unit:MoveToWaypoint(0) -- reset wp
    unit:DestroyCustomWaypointMap()
    
    unit:RegisterAIUpdateEvent(1000)

end

function OnReachWP( unit, event, wpId, fowards)

    if wpId == 1 then

        unit:CastSpellOnTarget(51519, unit)

        local vars = self[ tostring( unit ) ]

        vars.waitTimer = 5

        local playerStarter = unit:GetObject(vars.playerGUID)
        if playerStarter then
            unit:SendChatMessageToPlayer(12, 0, unworthyInitiate_text_attack[math.random(1,8)], playerStarter)
        end

        vars.phase = 4
    end
end

function OnActivate( unit, activator )

    local vars = self[ tostring( unit ) ]

    vars.waitTimer = 5
    vars.phase = 2
    --standstate stand
    unit:RemoveAura(54612) -- soul prison chain

    local anchor = unit:GetObject( vars.anchorGUID )
    anchor:StopChannel()

    vars.pPlayer = activator

    unit:SendChatMessageToPlayer(12, 0, unworthyInitiate_text_event[math.random(1,8)], activator)
end

function OnAIUpdate( unit, event )

    local vars = self[ tostring( unit ) ]

    -- chained
    if vars.phase == 1 then

        if not vars.anchorGUID then

            local anchor = unit:FindNearestCreature(29521, 35)
            if anchor then
                vars.anchorGUID = anchor:GetGUID()
                anchor:ChannelSpell(54612, unit)
                --vars.phase = vars.phase + 1
            end
        end

    -- to equip
    elseif vars.phase == 2 then

        if vars.waitTime then
            if vars.waitTime > 1 then 
                vars.waitTime = vars.waitTime - 1
            else
                local anchor = unit:FindNearestCreature(29521, 35)
                if anchor then
                    unit:CreateCustomWaypointMap()
                    unit:CreateCustomWaypoint(1, anchor:GetSpawnX(), anchor:GetSpawnY(), anchor:GetSpawnZ(), 0, 0, 0, unit:GetDisplay() )
                    unit:SetMovementType(11) -- wanted wp
                    vars.phase = 3 -- 3equiping
                    vars.waitTime = 0
                end
            end
        end

    -- to attack
    elseif vars.phase == 4 then

        if vars.waitTime then
            if vars.waitTime > 1 then 
                vars.waitTime = vars.waitTime - 1
            else
                unit:SetFaction(14)
                unit:RemoveFlag(0x0006 + 0x0035, 0x00000100) -- inmuneToPC
                vars.phase = 5
                vars.waitTime = 0

                if vars.playerGUID then
                    unit:SetNextTarget(vars.pPlayer)
                end
            end
        end

    -- attacking
    elseif vars.phase == 5 then

        if unit:GetNextTarget() == nil then
		    return 
	    end
    end 
end

function SoulPrisonOnHello( go, event, player )

	local anchor = player:FindNearestCreature(29521, 35)
	if anchor then
		local channelTarget = anchor:GetUInt64Value(0x0006 + 0x000E)
		if channelTarget then
			local initiate = anchor:GetObject(channelTarget)
			if initiate then
				local vars = self[ tostring( initiate ) ]
				initiate:Activate(player)
			end
		end
	end
end

for i = 1, #unworthyInitiate_id do

    RegisterUnitEvent(unworthyInitiate_id[ i ], 18, OnReset)
    RegisterUnitEvent(unworthyInitiate_id[ i ], 2, OnReset)
    RegisterUnitEvent(unworthyInitiate_id[ i ], 19, OnReachWP)
    RegisterUnitEvent(unworthyInitiate_id[ i ], 29, OnActivate)
    RegisterUnitEvent(unworthyInitiate_id[ i ], 21, OnAIUpdate)
    
end

for i = 1, #acherusSoulPrison_id do

	RegisterGameObjectEvent(acherusSoulPrison_id[i], 4, SoulPrisonOnHello)

end