--[[

local NPC_FESTERGUT = 36626

local SPELL_INHALE_BLIGHT = 69165
local SPELL_PUNGENT_BLIGHT = 69195
local SPELL_GASTRIC_BLOAT = 72219
local SPELL_GAS_SPORE = 

local SPELL_BERSERK2 = 47008

--]]

local self = getfenv( 1 )

gaseousBlight = { 69157, 69162, 69164 }

function Festergut_onEnterCombat( unit, event, attacker )

	local vars = self[ tostring( unit ) ]
	
	vars.berserk = 60 * 5
	vars.inhaleBlight = math.random( 25, 30 )
	vars.gasSpore = math.random( 20, 25 )
	vars.gastricBloat = math.random( 12, 15 )
	vars.maxInoculatedStack = 0
	vars.inhaleCounter = 0
	
	unit:PlaySoundToSet( 16901 )
	
	--unit:SendChatMessage( 14, 0, "Fun time?" )
	
end

function Festergut_onTargetDied( unit, event, victim )

	if victim:IsPlayer() == true then

		local chance = math.random( 0, 1 )

		if chance == 0 then

			unit:PlaySoundToSet( 16902 )
			unit:SendChatMessage( 14, 0, "Daddy, I did it!" )

		else

			unit:PlaySoundToSet( 16903 )
			unit:SendChatMessage( 14, 0, "Dead, dead, dead!" )

		end

	end

end

function Festergut_onAIUpdate( unit, event )

	if unit:GetNextTarget() == nil then
		unit:WipeThreatList()
		return 
	end

	if unit:GetAIState() == 2 then
		return
	end

	local vars = self[ tostring( unit ) ]

	vars.inhaleBlight = vars.inhaleBlight - 1
	vars.gasSpore = vars.gasSpore - 1
	vars.gastricBloat = vars.gastricBloat - 1
	vars.berserk = vars.berserk - 1

	if vars.inhaleBlight <= 0 then

		if vars.inhaleCounter == 3 then

			unit:SendChatMessage( 41, 0, "%s begins to cast |cFFFF7F00Pungent Blight!|r" )

			unit:SendChatMessage( 14, 0, "I not feel so good..." )
			unit:PlaySoundToSet( 16906 )

			unit:CastSpell( 69195 )

			vars.inhaleCounter = 0
			vars.gasSpore = math.random( 20, 25 )

		else

			unit:CastSpell( 69165 )

			vars.inhaleCounter = vars.inhaleCounter + 1

			if vars.inhaleCounter < 3 then

				unit:CastSpell( gaseousBlight[ vars.inhaleCounter ] )

			end

		end

		vars.inhaleBlight = math.random( 33, 35 )

	elseif vars.vileGas <= 0 then

		-- TODO: target crap

		vars.vileGas = math.random( 28, 35 )

	elseif vars.gasSpore <= 0 then

		unit:SendChatMessage( 41, 0, "%s releases Gas Spores!" )
	
		unit:SendChatMessage( 16, 0, "%s farts." )
	
		unit:CastSpell( 69278 )
		
		vars.gasSpore = math.random( 40, 45 )
		vars.vileGas = math.random( 28, 35 )
	
	elseif vars.gastricBloat <= 0 then
	
		unit:CastSpell( 72219 )
		vars.gastricBloat = math.random( 15, 17 )
	
	elseif vars.berserk <= 0 then
	
		unit:CastSpell( 47008 )
		unit:SendChatMessage( 14, 0, "Fun time over!" )
		unit:PlaySoundToSet( 16905 )
		vars.berserk = 60 * 5
	
	end

end

RegisterUnitEvent( 36626, 1, Festergut_onEnterCombat )
RegisterUnitEvent( 36626, 3, Festergut_onTargetDied )
RegisterUnitEvent( 36626, 21, Festergut_onAIUpdate )