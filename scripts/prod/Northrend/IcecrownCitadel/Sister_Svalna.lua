--[[

local NPC_SISTER_SVALNA = 37126
local NPC_CROCK_SCOURGEBANE = 37129

local SPELL_DIVINE_SURGE = 71465
local SPELL_CARESS_OF_DEATH = 70078

--]]

local self = getfenv( 1 )

function SisterSvalna_onSpawn( unit, event )
	
	self[ tostring( unit ) ] = {

		isEventInProgress = false

	}
	
end

function SisterSvalna_onEnterCombat( unit, event, attacker )

	local vars = self[ tostring( unit ) ]
	
	vars.svalnaCombat = 9
	vars.impalingSpear = math.random( 40, 50 )
	vars.aetherShield = math.random( 100, 110 )
	
	-- cast: Divine Surge
	unit:CastSpell( 71465 )
	
	unit:RegisterAIUpdateEvent( 1000 )
	
	local crock = GetInstanceCreature( 631, unit:GetInstanceID(), 37129 )
	
	if crock then
	
		unit:PlaySoundToSet( 16825 )
		
		unit:SendChatMessage( 14, 0, "I'll draw her attacks. Return our brothers to their graves, then help me bring her down!" )
		
		unit:Emote( 15 )
	
	end

end

function SisterSvalna_onTargetDied( unit, event, victim )

	if victim:IsPlayer() == true then

		unit:PlaySoundToSet( 17021 )
			
		unit:SendChatMessage( 14, 0, "What a pitiful choice of an ally, Crok!" )

	else

		local entry = victim:GetEntry()
		
		-- Killed a Captain
		if entry == 37122 or entry == 37123 or entry == 37124 or entry == 37125 then
		
			unit:PlaySoundToSet( 17018 )
			
			unit:SendChatMessage( 14, 0, "Miserable creatures! Die!" )
			
		end

	end

end

function SisterSvalna_onDied( unit, event, killer )

	unit:PlaySoundToSet( 17023 )

	unit:SendChatMessage( 14, 0, "Perhaps... you were right, Crok." )

end

function SisterSvalna_doAction( unit, action )

	local vars = self[ tostring( unit ) ]
	
	--
	-- kill Captain
	--
	if action == 0 then
	
		-- spell: Caress of Death
		unit:CastSpell( 70078 )
	
	
	--
	-- start gauntlet
	--
	elseif action == 1 then
	
		vars.isEventInProgress = true
		vars.svalnaStart = 25
	
	--
	-- resurrect Captains
	--
	elseif action == 2 then
	
		vars.svalnaResurrect = 7
	
	--
	-- Captains die
	--
	elseif action == 3 then
	
		unit:PlaySoundToSet( 17022 )
		
		unit:SendChatMessage( 14, 0, "They died so easily. No matter." )
	
	--
	-- reset event
	--
	elseif action == 4 then
	
		unit:DisableCombat()
	
	end

end

RegisterUnitEvent( 37126, 18, SisterSvalna_onSpawn )
RegisterUnitEvent( 37126, 1, SisterSvalna_onEnterCombat )
RegisterUnitEvent( 37126, 3, SisterSvalna_onTargetDied )
RegisterUnitEvent( 37126, 4, SisterSvalna_onDied )