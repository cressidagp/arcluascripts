--[[

local NPC_SISTER_SVALNA = 37126
local NPC_CROCK_SCOURGEBANE = 37129

local SPELL_DIVINE_SURGE = 71465
local SPELL_CARESS_OF_DEATH = 70078
local SPELL_REVIVE_CHAMPION = 70053
local SPELL_IMPALING_SPEAR = 71443
local SPELL_AETHER_SHIELD = 71463

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

function SisterSvalna_onAIUpdate( unit, event )

	local vars = self[ tostring( unit ) ]
	
	if( not unit:GetNextTarget() and not vars.isEventInProgress ) then
		return
	end
	
	-- dont bother with this func if unit is casting
	if unit:GetAIState() == 2 then
		return
	end
	
	if vars.svalnaStart <= 0 then
	
		unit:PlaySoundToSet( 17017 )
		
		unit:SendChatMessage( 14, 0, "You may have once fought beside me, Crok, but now you are nothing more than a traitor. Come, your second death approaches!" )
	
	elseif vars.svalnaResurrect <= 0 then
	
		unit:PlaySoundToSet( 17019 )
		
		unit:SendChatMessage( 14, 0, "Foolish Crok. You brought my reinforcements with you. Arise, Argent Champions, and serve the Lich King in death!" )
		
		-- spell: Revive Champion
		unit:FullCastSpell( 70053 )
	
	elseif vars.svalnaCombat <= 0 then
	
		-- TODO: react defensive
	
		unit:PlaySoundToSet( 17020 )
		
		unit:SendChatMessage( 14, 0, "Come, Scourgebane. I'll show the master which of us is truly worthy of the title of "Champion"!" )
	
	elseif vars.impalingSpear <= 0 then
	
		-- TODO: get a target not impaled yet
		local target = unit:GetRandomPlayer()
		
		if target then
		
			-- spell: Aether Shield
			unit:CastSpell( 71463 )
		
			-- spell: Impaling Spear
			unit:CastSpellOnTarget( 71443, target )
			
		end
		
		vars.impalingSpear = math.random( 20, 25 )
	
	end

end

RegisterUnitEvent( 37126, 18, SisterSvalna_onSpawn )
RegisterUnitEvent( 37126, 1, SisterSvalna_onEnterCombat )
RegisterUnitEvent( 37126, 3, SisterSvalna_onTargetDied )
RegisterUnitEvent( 37126, 4, SisterSvalna_onDied )
RegisterUnitEvent( 37126, 21, SisterSvalna_onAIUpdate )