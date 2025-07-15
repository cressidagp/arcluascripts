--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Icecrown Citadel: Lord Marrowgar
	Engine: A.L.E
	
--- Spell Research:

SPELL_COLDFLAME = 69138 // Seems to shoot a line of frost who damaged enemies and friends?
SPELL_COLDFLAME_NORMAL = 69140 // spell triggered by aiupdate, cant be learn by player
SPELL_COLDFLAME_PASSIVE = 69145 // add a temporary aura: dbc EffectTriggerSpell2 = 69147
SPELL_COLDFLAME_SUMMON = 69147 // do a tiny circle frost effect, but its not summoning npc: dbc EffectTriggerSpell1 = 69146
SPELL_COLDFLAME_BONE_STORM = 72705 // spell triggered by aiupdate (when bonestorm its active), cant be learn by player

ColdflameDamage: 69146, 70823, 70824, 70825

--]]

local self = getfenv( 1 )

function LordMarrowgar_onSpawn( unit, event )

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
		berserk = 10 * 60,
		coldflameTarget = 0,
		coldflameLastPos = { nil, nil, nil }
	
	}

	unit:PlaySoundToSet( 16950 )
	unit:SendChatMessage( 14, 0, "This is the beginning AND the end, mortals. None may enter the master's sanctum!" )

end

function LordMarrowgar_onEnterCombat( unit, event, attacker )

	unit:PlaySoundToSet( 16941 )

	unit:RegisterAIUpdateEvent( 1000 )

	-- Lord Marrowgar's Entrance: close door stuff
	for k, v in pairs ( unit:GetInRangeObjects() ) do

		if v:GetEntry() == 201857 and v:GetByte( 0x0006 + 0x000B, 0 ) ~= 1 then

			v:Activate()

		end

	end

end

function LordMarrowgar_onTargetDied( unit, event, victim )

	if victim:IsPlayer() == true then

		local chance = math.random( 0, 1 )

		if chance == 0 then

			unit:PlaySoundToSet( 16942 )
			unit:SendChatMessage( 14, 0, "More bones for the offering!" )

		else

			unit:PlaySoundToSet( 16943 )
			unit:SendChatMessage( 14, 0, "Languish in damnation!" )

		end

	end

end

function LordMarrowgar_onDied( unit, event, killer )

	unit:PlaySoundToSet( 16944 )

	for k,v in pairs( unit:GetInRangeObjects() ) do

		--- Scourge Transporter
		--- Lord Marrowgar's Entrance: open door stuff
		--- Icewalls:
		--- Oratory of the Damned Entrance: open door stuff

		local go_entry = v:GetEntry()

		if go_entry == 202245 or go_entry == 201563 or go_entry == 201857 or go_entry == 201910 or go_entry == 201911 then

			v:Activate()

		end

	end

end

function LordMarrowgar_onAIUpdate( unit )

	-- dont bother with this function if boss dont have target
	if unit:GetNextTarget() == nil then
		unit:WipeThreatList()
		return 
	end

	-- dont bother with this function if boss its casting
	--if unit:GetAIState() == 2 then 
		--return
	--end

	local vars = self[ tostring( unit ) ]

	if vars.boneSliceEnabled == false then

		vars.boneSlice = vars.boneSlice - 1
	
		if vars.boneSlice <= 0 then
	
			vars.boneSliceEnabled = true
			unit:DisableMelee( 1 )
		
		end

	end

	vars.coldFlame = vars.coldFlame - 1

	if vars.boneStormMove ~= nil then vars.boneStormMove = vars.boneStormMove - 1 end

	if vars.coldFlame <= 0 then

		--vars.coldflameTarget = 0
		--vars.coldflameLastPos = { nil, nil, nil }

		--- check for bonestorm aura
		if unit:HasAura( 69076 ) == false then

			---- cast coldflame normal
			unit:FullCastSpell( 69140 )

		else

			---- cast coldflame bonestorm
			unit:FullCastSpell( 72705 )

		end

		vars.coldFlame = 5

	end

	-- boss dont have bone storm aura
	if unit:HasAura( 69076 ) == false then

		vars.boneSliceAttack = vars.boneSliceAttack - 1
		vars.boneSpikeGraveyard = vars.boneSpikeGraveyard - 1
		vars.warnBoneStorm = vars.warnBoneStorm - 1
		vars.berserk = vars.berserk - 1

		if vars.boneStormBegin ~= nil then vars.boneStormBegin = vars.boneStormBegin - 1 end

		if vars.boneSliceAttack <= 0 and unit:GetAIState() ~= 2 and unit:HasAura( 69057 ) == false and unit:HasAura( 69076 ) == false then

			unit:CastSpellOnTarget( 69055, unit:GetMainTank() )
			vars.boneSliceAttack = 10

		elseif vars.boneSpikeGraveyard <= 0 then

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

			vars.boneSpikeGraveyard = math.random( 15, 20 )

		elseif vars.warnBoneStorm <= 0 then

			unit:SendChatMessage( 42, 0, "%s creates a whirling storm of bone!" )
			unit:FullCastSpell( 69076 )
			vars.boneStormBegin = 2
			vars.warnBoneStorm = 95

		elseif vars.boneStormBegin ~= nil and vars.boneStormBegin <= 0 then

			unit:PlaySoundToSet( 16946 )
			unit:SendChatMessage( 14, 0, "BONE STORM!" )
			vars.boneStormBegin = nil
			vars.boneStormEnd = 60

		elseif vars.berserk <= 0 then

			unit:CastSpell( 26662 )
			unit:PlaySoundToSet( 16945 )
			unit:SendChatMessage( 14, 0, "THE MASTER'S RAGE COURSES THROUGH ME!" )
			vars.berserk = 10 * 60

		end

	else
		--vars.boneStormEnd = vars.boneStormEnd - 1

		if vars.boneStormEnd <= 0 then

			--vars.boneStormEnd = nil

		end

	end

end

-----------------------------------------------
--- Coldflame (36672) -------------------------
-----------------------------------------------
function npc_coldflame_onSpawn( unit, event )

	-- get lord marrowgar
	local summoner = unit:GetUnitByGUID( unit:GetUInt64Value( 0x0006 + 0x0008 ) )

	if summoner == nil then

		return

	end

	-- store coldflame position for later use?
	local vars = self[ tostring( summoner ) ]

	local pos = { nil, nil, nil }

	if vars.coldflameLastPos[ 1 ] ~= nil then

		pos = { vars.coldflameLastPos[ 1 ], vars.coldflameLastPos[ 2 ], unit:GetZ() }

	else
	
		--vars.coldflameLastPos = { unit:GetX(), unit:GetY(), unit:GetZ() }
		pos = { unit:GetX(), unit:GetY(), unit:GetZ() }
		
	end
	
	if summoner:HasAura( 69076 ) == true then
	
		--local ang = math.abs( )
		--unit:SetO( ang )
		summoner:MoveTo( pos[ 1 ], pos[ 2 ], summoner:GetZ(), 0 )
	
	else
	
		local target = unit:GetUnitByGUID( vars.coldflameTarget )
		
		if target == nil then
		
			unit:Despawn( 0, 0 )
			
			return
			
		end
		
		--local ang = math.abs( )
		--unit:SetO( ang )
		summoner:MoveTo( pos[ 1 ], pos[ 2 ], summoner:GetZ(), 0 )
		--print("crap5")
		
	end
	
	-- add temporary aura
	unit:CastSpell( 69145 )
	
	-- teleport spell creature to boss position
	unit:TeleportCreature( summoner:GetX(), summoner:GetY(), summoner:GetZ() )
	
	-- run baby, run!
	unit:SetMovementFlags( 1 )
	
	-- bugged
	--unit:ModifyRunSpeed( 16 )
	
	-- creature walk the line
	unit:MoveTo( pos[ 1 ], pos[ 2 ], unit:GetZ() )
	
	unit:RegisterAIUpdateEvent( 500 )

end

function npc_coldflame_onAIUpdate( unit, event )
	
	-- cast COLDFLAME_SUMMON over and over to create a spell path
	unit:CastSpellAoF( unit:GetX(), unit:GetY(), unit:GetZ(), 69147 )

end

-----------------------------------------------
--- Spell: Coldflame (69140) ------------------
-----------------------------------------------
function spell_coldflame_normal( spellIndex, spell )

	local caster = spell:GetCaster()

	--caster:SendChatMessage( 14, 0, "ano" )

	-- select any unit but no the tank
	local target = caster:GetRandomPlayer( 0 ) --7 bugged?

	-- or the tank if its solo
	if target == nil then

		local target = caster:GetMainTank()

		if target == nil then

			return

		end

	end

	caster:CastSpellOnTarget( 69138, target )

	-- Store target for further use?
	local vars = self[ tostring( caster ) ]

	vars.coldflameTarget = target:GetGUID()

end

-----------------------------------------------
--- Spell: Coldflame (damage) -----------------
--- 69146, 70823, 70824, 70825
-----------------------------------------------

function spell_coldflame_damage( spellIndex, spell )

end

-----------------------------------------------
--- Bonespike (36619, 38711, 38712) -----------
-----------------------------------------------
function npc_bone_spike_onSpawn( unit, event )

	local summoner = unit:GetUnitByGUID( unit:GetUInt64Value( 0x0006 + 0x0008 ) )

	if summoner == nil then

		return

	end

	local b = unit:GetVehicleBase()

	summoner:EnterVehicle( b:GetGUID(), 500 )

end

function npc_bone_spike_onTargetDied( unit, event, victim )

	unit:Despawn( 1000, 0 )

end

function npc_bone_spike_onDied( unit, event, killer )

	local trapped = unit:GetUInt64Value( 0x0006 + 0x0008 )

	if trapped ~= nil then 

		--trapped:RemoveAura( 69065 )

	end

end

-----------------------------------------------
-- Spell: summons (69062, 72669, 72670) -------
-----------------------------------------------
function spell_bone_spike_graveyard( spellIndex, spell )

	local caster = spell:GetCaster()

	--- is 10 men instance
	if caster:GetDungeonDifficulty() == 0 or caster:GetDungeonDifficulty() == 2 then

		local target = caster:GetRandomPlayer( 0 )

		if target then

			target:CastSpell( 69062 )

		end

	end

end

RegisterUnitEvent( 36612, 18, LordMarrowgar_onSpawn )
RegisterUnitEvent( 36612, 1, LordMarrowgar_onEnterCombat )
RegisterUnitEvent( 36612, 3, LordMarrowgar_onTargetDied )
RegisterUnitEvent( 36612, 4, LordMarrowgar_onDied )
RegisterUnitEvent( 36612, 21, LordMarrowgar_onAIUpdate )

RegisterUnitEvent( 36619, 18, npc_bone_spike_onSpawn )
RegisterUnitEvent( 38711, 18, npc_bone_spike_onSpawn )
RegisterUnitEvent( 38712, 18, npc_bone_spike_onSpawn )
RegisterUnitEvent( 36619, 3, npc_bone_spike_onTargetDied )
RegisterUnitEvent( 38711, 3, npc_bone_spike_onTargetDied )
RegisterUnitEvent( 38712, 3, npc_bone_spike_onTargetDied )
RegisterUnitEvent( 36619, 4, npc_bone_spike_onDied )
RegisterUnitEvent( 38711, 4, npc_bone_spike_onDied )
RegisterUnitEvent( 38712, 4, npc_bone_spike_onDied )
RegisterDummySpell( 69057, spell_bone_spike_graveyard )

RegisterUnitEvent( 36672, 18, npc_coldflame_onSpawn )
RegisterUnitEvent( 36672, 21, npc_coldflame_onAIUpdate )
RegisterDummySpell( 69140, spell_coldflame_normal )
RegisterDummySpell( 69146, spell_coldflame_damage )
--RegisterDummySpell( 72705, spell_coldflame_normal )

--[[ 
		DEBUG COMMANDS DISABLED BY DEFAULT

local COMMANDS = { "marrowgar", "port", "exit", "coldflame", "summon", "tele" }

function DebugCommands( event, plr, message )

	if( plr:IsGm() == true )
	then
		if( message == "#marrowgar" )
		then
			for i = 1, #COMMANDS
			do
				plr:SendBroadcastMessage( ""..COMMANDS[ i ].."" )
			end

		elseif( message == "#port" )
		then
			plr:Teleport( 631, -355.23, 2010.93, 42.36, 3.13 )

		elseif( message == "#exit" )
		then
			plr:Teleport( 571, 3597.61, 200.96, -113.74, 5.30 )

		elseif( message == "#coldflame" )
		then
			local selection = plr:GetSelection()
			if selection
			then
				selection:CastSpell( 69140 )
			else
				plr:SendBroadcastMessage( "Select marro first." )
			end

		elseif( message == "#summon" )
		then
			local selection = plr:GetSelection()
			if selection
			then
				selection:CastSpellAoF( selection:GetX(), selection:GetY(), selection:GetZ(), 69147 )
			else
				plr:SendBroadcastMessage( "Select marro first." )
			end

		elseif( message == "#tele" )
		then
			local selection = plr:GetSelection()
			if selection
			then
				selection:TeleportCreature( plr:GetX(), plr:GetY(), plr:GetZ() )
			else
				plr:SendBroadcastMessage( "Need to select a creature first." )
			end
		end		
	end
end

RegisterServerHook( 16, DebugCommands )
--]]