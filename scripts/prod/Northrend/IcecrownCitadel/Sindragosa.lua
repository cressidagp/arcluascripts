--[[

local NPC_SINDRAGOSA = 36853

local SPELL_FROST_AURA = 70084
local SPELL_PERMAEATING_CHILL = 70109
local SPELL_SINDRAGOSA_S_FURY = 70608

--]]

local self = getfenv( 1 )

function Sindragosa_onEnterCombat( unit, event, attacker )

	self[ tostring( unit ) ] = {
	
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

RegisterUnitEvent( 36853, 1, Sindragosa_onEnterCombat )