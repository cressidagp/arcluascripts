--local NPC_NERUBAR_BROODKEEPER	= 36725

--local SPELL_WEB_BEAM = 69887
--local SPELL_CRYPT_SCARABS = 70965
--local SPELL_WEB_WRAP = 70980
--local SPELL_DARK_MENDING = 71020

local self = getfenv( 1 )

function NerubarBroodkeeper_onLoad( unit, event )

	unit:SetUInt32Value( 0x0006 + 0x004D, 420 )

end

function NerubarBroodkeeper_onEnterCombat( unit, event, attacker )

	local vars = self[ tostring( unit ) ]
	
	vars.cryptScarabs = math.random( 1, 3 )
	vars.darkMending = 5
	vars.webWrap = 20
	
	unit:RegisterAIUpdateEvent( 1000 )

end

function NerubarBroodkeeper_doAction( unit, action )

	unit:CastSpell( 69887 )
	unit:SetUInt32Value( 0x0006 + 0x004D, 0 )

end

function NerubarBroodkeeper_onAIUpdate( unit, event )

	if unit:GetNextTarget() == nil then
		unit:WipeThreatList()
		return 
	end
	
	if unit:GetAIState() == 2 then
		return
	end

	local vars = self[ tostring( unit ) ]
	
	vars.cryptScarabs = vars.cryptScarabs - 1
	vars.darkMending = vars.darkMending - 1
	vars.webWrap = vars.webWrap - 1
	
	if vars.cryptScarabs <= 0 then
	
		unit:CastSpellOnTarget( 70965, victim )
		
		vars.cryptScarabs = math.random( 4, 5 )
	
	elseif vars.darkMending <= 0 then
	
		local allies = unit:GetInRangeFriends()
		
		for i, v in ipairs ( allies ) do
		
			if v:GetDistanceYards( unit ) < 50 and v:GetHealthPct() < 75 then
			
				unit:CastSpellOnTarget( 71020, v )
			
			end
		
		end
		
		vars.darkMending = math.random( 3, 10 )
	
	elseif vars.webWrap <= 0 then
	
		target = unit:GetRandomTarget( 2 )
		
		if target ~= nil then
		
			unit:CastSpellOnTarget( 70980, target )
			
		end
		
		vars.webWrap = math.random( 16, 20 )
	
	end

end

--RegisterUnitEvent( 36725, 18, NerubarBroodkeeper_onLoad )
RegisterUnitEvent( 36725, 1, NerubarBroodkeeper_onEnterCombat )
RegisterUnitEvent( 36725, 21, NerubarBroodkeeper_onAIupdate )
