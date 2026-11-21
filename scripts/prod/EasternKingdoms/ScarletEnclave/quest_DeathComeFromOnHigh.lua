-- Quest "Death Comes From On High" (12641)

--NPCID_EYE_OF_ACHERUS = 28511

--SPELL_THE_EYE_OF_ACHERUS                = 51852,
--SPELL_EYE_OF_ACHERUS_VISUAL             = 51892,
--SPELL_EYE_OF_ACHERUS_FLIGHT_BOOST       = 51923,
--SPELL_EYE_OF_ACHERUS_FLIGHT             = 51890,

local self = getfenv( 1 )

local EyeOfAcherusPath = {

    { 2361.21, -5660.45, 496.744 },
    { 2341.571, -5672.797, 538.3942 },
    { 1957.4, -5844.1, 273.867 },
    { 1758.01, -5876.79, 166.867 }
}

function EyeOfAcherus_OnSpawn( unit, event )

    unit:SetModel(25499)

    unit:RegisterAIUpdateEvent(1000)

	self[ tostring( unit ) ] = {
	
		eventAnnounceLaunchToDest = 7,
        eventUnroot = nil,
        eventLaunchToDest = nil,
        eventGrantControl = nil
	}

    unit:Root()
    unit:CastSpell(51892) -- SPELL_EYE_OF_ACHERUS_VISUAL
end

function EyeOfAcherus_OnAIUpdate( unit, event )

    local vars = self[ tostring( unit ) ]
    
    if vars.eventAnnounceLaunchToDest ~= nil then vars.eventAnnounceLaunchToDest = vars.eventAnnounceLaunchToDest - 1 end
    if vars.eventUnroot ~= nil then vars.eventUnroot = vars.eventUnroot - 1 end
    if vars.eventLaunchToDest ~= nil then vars.eventLaunchToDest = vars.eventLaunchToDest - 1 end
    if vars.eventGrantControl ~= nil then vars.eventGrantControl = vars.eventGrantControl - 1 end

    if vars.eventAnnounceLaunchToDest ~= nil and vars.eventAnnounceLaunchToDest <= 0 then

        local owner = unit:GetObject(unit:GetUInt64Value(0x0006 + 0x0006))
        if owner then
            unit:SendChatMessageToPlayer(42, 0, "The Eye of Acherus launches towards its destination.", owner)
        end
        
        vars.eventUnroot = 2

        vars.eventAnnounceLaunchToDest = nil

    elseif vars.eventUnroot ~= nil and vars.eventUnroot <= 0 then

        unit:Unroot()

        unit:CastSpell(51923) -- SPELL_EYE_OF_ACHERUS_FLIGHT_BOOST

        vars.eventUnroot = nil
        vars.eventLaunchToDest = 3
    
    elseif vars.eventLaunchToDest ~= nil and vars.eventLaunchToDest <= 0 then

        unit:SetFlying()
        
        unit:MoveTo(EyeOfAcherusPath[4][1], EyeOfAcherusPath[4][2], EyeOfAcherusPath[4][3], 0)

        vars.eventLaunchToDest = nil
        vars.eventGrantControl = 90

    elseif vars.eventGrantControl ~= nil and vars.eventGrantControl <= 0 then

        vars.eventGrantControl = nil
        
        unit:CastSpell(51890) -- SPELL_EYE_OF_ACHERUS_FLIGHT
        unit:RemoveAura(51923) -- SPELL_EYE_OF_ACHERUS_FLIGHT_BOOST

        local owner = unit:GetObject(unit:GetUInt64Value(0x0006 + 0x0006))
        if owner then
            unit:SendChatMessageToPlayer(42, 0, "The Eye of Acherus is in your control.", owner)
        end

        unit:RemoveAIUpdateEvent()
        self[ tostring( unit ) ] = nil
    end
end

RegisterUnitEvent( 28511, 18, EyeOfAcherus_OnSpawn )
RegisterUnitEvent( 28511, 21, EyeOfAcherus_OnAIUpdate )