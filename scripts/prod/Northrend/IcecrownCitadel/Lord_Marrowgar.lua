--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Icecrown Citadel: Lord Marrowgar
	Engine: A.L.E

--]]

local self = getfenv( 1 )

function LordMarrowgar_onSpawn( unit, event )

	unit:PlaySoundToSet( 16950 )
	unit:SendChatMessage( 14, 0, "This is the beginning AND the end, mortals. None may enter the master's sanctum!" )

end

function LordMarrowgar_onEnterCombat( unit, event, attacker )

	unit:PlaySoundToSet( 16941 )
	
	unit:RegisterAIUpdateEvent( 1000 )
	
	self[ tostring( unit ) ] = {
	
		boneSliceEnabled = false,
		boneSlice = 10,
		boneSliceAttack = 10,
		coldFlame = 5,
		boneSpikeGraveyard = 15,
		warnBoneStorm = math.random( 45, 50 ),
		boneStormBegin = nil,
		boneStormMove = nil,
		boneStormEnd = nil,
		berserk = 10 * 60 * 1000
	
	}

end

function LordMarrowgar_onTargetDied( unit, event, victim )

	local chance = math.random( 0, 1 )
	
	if chance == 0 then
	
		unit:PlaySoundToSet( 16942 )
		unit:SendChatMessage( 14, 0, "More bones for the offering!" )

	else
		
		unit:PlaySoundToSet( 16943 )
		unit:SendChatMessage( 14, 0, "Languish in damnation!" )
	
	end
	
end

function LordMarrowgar_onDied( unit, event, killer )

	unit:PlaySoundToSet( 16944 )

end

function LordMarrowgar_onAIUpdate( unit )

	-- dont bother with this function if boss dont have target
	if unit:GetNextTarget() == nil then
		unit:WipeThreatList()
		return 
	end
	
	
	-- dont bother with this function if boss its casting
	if unit:GetAIState() == 2 then 
		return
	end

	local vars = self[ tostring( unit ) ]
	
	if vars.boneSliceEnabled == false then
	
		vars.boneSlice = vars.boneSlice - 1
		
		if vars.boneSlice <= 0 then
		
			vars.boneSliceEnabled = true
			unit:DisableMelee( 1 )
			
		end

	else
	
		vars.boneSliceAttack = vars.boneSliceAttack - 1
		
		if vars.boneSliceAttack <= 0 then
		
			unit:CastSpellOnTarget( 69055, unit:GetMainTank() )
			vars.boneSliceAttack = 10
		
		end
	
	end
	
	vars.boneSpikeGraveyard = vars.boneSpikeGraveyard - 1
	vars.coldFlame = vars.coldFlame - 1
	vars.warnBoneStorm = vars.warnBoneStorm - 1
	vars.berserk = vars.berserk - 1
	
	if vars.boneStormBegin ~= nil then vars.boneStormBegin = vars.boneStormBegin - 1 end
	if vars.boneStormMove ~= nil then vars.boneStormMove = vars.boneStormMove - 1 end
	if vars.boneStormEnd ~= nil then vars.boneStormEnd = vars.boneStormEnd -1 end
	
	if vars.boneSpikeGraveyard <= 0 then
	
		-- dont cast if boss has bonestorm aura
		if unit:HasAura( 69076 ) == false then
	
			unit:FullCastSpell( 69057 )
		
			local chance = math.random( 0, 2 )
		
			if chance == 0 then
		
				unit:PlaySoundToSet( 16947 )
				unit:SendChatMessage( 14, 0, "Bound by bone!" )
		
			elseif chance == 1 then
		
				unit:PlaySoundToSet( 16948 )
				unit:SendChatMessage( 14, 0, "Stick around!" )
		
			else
		
				unit:PlaySoundToSet( 16949 )
				unit:SendChatMessage( 14, 0, "The only escape is death!" )
		
			end
		
		end 
		
		vars.boneSpikeGraveyard = math.random( 15, 20 )
	
	elseif vars.coldFlame <= 0 then
	
		-- check for bonestorm aura
		if unit:HasAura( 69076 ) == false then
		
			--- cast normal coldflame
			unit:FullCastSpell( 69140 )
			
		else
		
			--- cast coldflame bonestorm
			unit:FullCastSpell( 72705 )
			
		end
		
		vars.coldFlame = 5
	
	elseif vars.warnBoneStorm <= 0 then
	
		unit:SendChatMessage( 42, 0, "%s creates a whirling storm of bone!" )
		vars.warnBoneStorm = 95
		vars.boneStormBegin = 3
	
	elseif vars.boneStormBegin ~= nil and vars.boneStormBegin <= 0 then
		
		unit:CastSpell( 69076 )
		unit:PlaySoundToSet( 16946 )
		unit:SendChatMessage( 14, 0, "BONE STORM!" )
		vars.boneStormBegin = nil
		vars.boneStormEnd = 60 + 1
	
	elseif vars.boneStormEnd ~= nil and vars.boneStormEnd <= 0 then
	
		vars.boneStormEnd = nil
	
	elseif vars.berserk <= 0 then
	
		unit:CastSpell( 26662 )
		unit:PlaySoundToSet( 16945 )
		unit:SendChatMessage( 14, 0, "THE MASTER'S RAGE COURSES THROUGH ME!" )
		vars.berserk = 10 * 60 * 1000
	
	end

end

RegisterUnitEvent( 36612, 18, LordMarrowgar_onSpawn )
RegisterUnitEvent( 36612, 1, LordMarrowgar_onEnterCombat )
RegisterUnitEvent( 36612, 3, LordMarrowgar_onTargetDied )
RegisterUnitEvent( 36612, 4, LordMarrowgar_onDied )
RegisterUnitEvent( 36612, 21, LordMarrowgar_onAIUpdate )