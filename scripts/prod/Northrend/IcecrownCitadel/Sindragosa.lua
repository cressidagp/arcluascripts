--[[

local NPC_SINDRAGOSA = 36853

local SPELL_FROST_AURA = 70084
local SPELL_PERMAEATING_CHILL = 70109
local SPELL_SINDRAGOSA_S_FURY = 70608

local SPELL_SHADOWS_FATE = 71169
local SPELL_FROST_INFUSION = 72292

--]]

local self = getfenv( 1 )

function Sindragosa_onEnterCombat( unit, event, attacker )

	self[ tostring( unit ) ] = {
	
	phase = 0,
	raidMode = unit:GetDungeonDifficulty(),
	isInAirPhase = false,
	isThirdPhase = false,
	mysticBuffetStack = 0,
	berserk = 60 * 10
	
	}
	
	--unit:SendChatMessage( 14, 0, "You are fools to have come to this place. The icy winds of Northrend will consume your souls!" )
	
	unit:PlaySoundToSet( 17007 )
	
	-- cast: Frost Aura
	unit:CastSpell( 70084 )
	
	-- cast: Permaeating Chill
	unit:CastSpell( 70109 )
	
end

function SindragosaDoAction( action, unit )

	if action == 0 then
	
		unit:MoveTo( 4475.190, 2484.570, 234.8510, 3.141593 )
		
		-- cast: Sindragosas Fury
		unit:CastSpell( 70608 )
	
	end

end

function Sindragosa_onTargetDied( unit, event, victim )

	if victim:IsPlayer() == true then

		if math.random( 0, 1 ) == 0 then

			unit:PlaySoundToSet( 17008 )
			unit:SendChatMessage( 14, 0, "Perish!" )

		else

			unit:PlaySoundToSet( 17009 )
			unit:SendChatMessage( 14, 0, "The flaw of mortality...." )

		end

	end

end

function Sindragosa_onDied( unit, event, killer )

	unit:PlaySoundToSet( 17010 )
	
	--unit:SendChatMessage( 14, 0, "Free... at last...." )
	
	local vars = self[ tostring( unit ) ]
	
	-- its 25MEN raid
	if vars.raidMode == 1 or vars.raidMode == 3 then
	
		--- spell: Shadows Fate
		if unit:HasAura( 71169 ) == true then
		
			---- spell: Frost Infusion Credit
			unit:CastSpell( 72292 )

end

function Sindragosa_onAIUpdate( unit, event )

	if unit:GetNextTarget() == nil then
		unit:WipeThreatList()
		return 
	end
	
	if unit:GetAIState() == 2 then
		return
	end
	
	local vars = self[ tostring( unit ) ]
	
	vars.berserk = vars.berserk - 1
	
	if vars.berserk <= 0 then
	
		unit:SendChatMessage( 41, 0, "%s goes into a berserker rage!" )
		
		unit:PlaySoundToSet( 17011 )
		
		unit:SendChatMessage( 14, 0, "Enough! I tire of these games!" )
		
		unit:CastSpell( 26662 )
		
		vars.berserk = 60 * 10
	
	end

end

function Sindragosa_onDamageTaken( unit, event, attacker, damage )

	local vars = self[ tostring( unit ) ]
	
	if vars.isThirdPhase == false and unit:GetHealthPct() > 35 then
	
		vars.isThirdPhase = true
	
	end

end

RegisterUnitEvent( 36853, 1, Sindragosa_onEnterCombat )
RegisterUnitEvent( 36853, 3, Sindragosa_onTargetDied )
RegisterUnitEvent( 36853, 4, Sindragosa_onDied )
RegisterUnitEvent( 36853, 21, Sindragosa_onAIUpdate )
RegisterUnitEvent( 36853, 23, Sindragosa_onDamageTaken )