--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Forge of Souls: Bronjahm
	Engine: A.L.E
	Credits: Trinity for texts, sound ids and spell ids, and timers.
	
	https://www.youtube.com/watch?v=2jBZyDGO1YM
	https://www.youtube.com/watch?v=XKbtRjGV0Qo
	

local NPC_BRONJAHM					= 36497;
local H_NPC_BRONJHAM				= 36498;
local NPC_CORRUPTED_SOUL_FRAGMENT	= 36535;
local H_NPC_CORRUPTED_SOUL_FRAGMENT	= 36617;

local BOSS_HP		= { 539240, 903227 };
local BOSS_MANA		= { 166760, 279323 };
local CREATURE_HP	= { 18900, 56700 };

local UNIT_FIELD_SUMMONEDBY			= 0x0006 + 0x0008;
local UNIT_FIELD_FLAGS_2			= 0x0006 + 0x0036;
local UNIT_FLAG2_ENABLE_POWER_REGEN	= 0x0000800;

--]]

local SOUND = {
[ 1 ] = 16595; -- OnCombat
[ 2 ] = 16596; -- OnTargetDied 1
[ 3 ] = 16597; -- OnTargetDied 2
[ 4 ] = 16598; -- OnDeath
[ 5 ] = 16599; -- OnCast: "Soul Storm"
[ 6 ] = 16600; -- OnCast: "Corrupt Soul"
};

local YELL = {
--[ 1 ] = "Finally, a captive audience!";
[ 1 ] = "Fodder for the engine.";
[ 2 ] = "Another soul to strengthen the host!";
--[ 4 ] = "The Devourer awaits...";
[ 3 ] = "The vortex of the harvested calls to you!";
[ 4 ] = "I will sever your soul from your body!";
};

-- Spells:
local SPELL_SOULSTORM_CHANNEL		= 69008; -- prefight, has an apply periodic trigger dummy aura effect
local SPELL_TELEPORT				= 68988;
local SPELL_MAGICS_BANE				= 68793;
local SPELL_SHADOW_BOLT				= 70043;
local SPELL_CORRUPT_SOUL			= 68839; -- has a apply dummy aura effect
--local SPELL_DRAW_CORRUPTED_SOUL	= 68846;
local SPELL_SOULSTORM_VISUAL		= 68870; -- precast Soulstorm, has an apply periodic trigger dummy aura effect
local SPELL_SOULSTORM				= 68872;
--local SPELL_SOULSTORM				= 68925; -- has a dummy effect
local SPELL_FEAR					= 68950;
local SPELL_CONSUME_SOUL			= 68861; -- has a scripted effect
--local SPELL_PURPLE_BANISH_VISUAL	= 68862; -- used by Soul Fragment (Aura), has an apply dummy aura effect

local self = getfenv( 1 );

function OnSpawn( unit )

	if( unit:GetDungeonDifficulty() ~= 0 )
	then
		unit:SetMaxHealth( 903227 );
		unit:SetHealth( 903227 );
		unit:SetMaxMana( 279323 );
		unit:SetMana( 279323 );
	end
	unit:SetFlag( 0x0006 + 0x0036, 0x0000800 );
	--unit:CastSpell( SPELL_SOULSTORM_CHANNEL );
	unit:FullCastSpell( SPELL_SOULSTORM_CHANNEL );
end

RegisterUnitEvent( 36502, 18, OnSpawn );

function OnCombat( unit )

	self[ tostring( unit )] = {

	diff = unit:GetDungeonDifficulty(),
	phase = 1,
	magicsBane = math.random( 8, 20 ),
	shadowBolt = 2,
	corruptSoul = math.random( 25, 35 ),
	fear = math.random( 8, 12 )
	};

	unit:PlaySoundToSet( SOUND[ 1 ] );
	
    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]
	
	unit:RemoveAura( SPELL_SOULSTORM_CHANNEL );

	unit:RegisterAIUpdateEvent( 1000 );
end

function OnDamageTaken( unit )

	local vars = self[ tostring( unit ) ];

	local hp = unit:GetHealthPct();

	if( vars.phase == 1 and hp <= 30 ) -- not hp > 30
	then
		vars.phase = 2;
		vars.soulstorm = 1;
		vars.shadowBolt = 2;
		vars.endPhase = 600;
		unit:CastSpell( SPELL_TELEPORT );
		unit:Root();
	end
end

function OnLeaveCombat( unit )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

	--[[ Developer notes: contrary to popular believe, this is the right place
	to remove ai update event since if a creature is dead the ai update will not trigger, so
	one remove ai update event its more than enough. ]]

	unit:RemoveAIUpdateEvent();
end

function OnTargetDied( unit, _, victim )

	if( victim:IsPlayer() == true )
	then
		local rand = math.random( 2, 3 );
		unit:PlaySoundToSet( SOUND[ rand ] );
		unit:SendChatMessage( 14, 0, YELL[ rand - 1 ] );
	end
end

function OnDeath( unit )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

	--[[ Developer notes: we dont need to send the chat here since our
	monstersay table will do the job, instance collision checked. ]]

	unit:PlaySoundToSet( SOUND[ 4 ] );

end

function OnAIUpdate( unit )
	
	--if( unit:IsCasting() == true ) then return; end
	
	--if( unit:GetAIState() == 2 ) then return; end
	
	if( unit:GetCurrentSpell() ~= nil ) then return; end

	if( unit:GetNextTarget() == nil ) then
		unit:WipeThreatList();
		return;
	end
	
	local vars = self[ tostring( unit ) ];
	
	if( vars.phase == 1 )
	then
		vars.magicsBane = vars.magicsBane - 1;
		vars.shadowBolt = vars.shadowBolt - 1;
		vars.corruptSoul = vars.corruptSoul - 1;
		
		if( vars.magicsBane <= 0 )
		then
			unit:CastSpell( SPELL_MAGICS_BANE );
			vars.magicsBane = math.random( 8, 20 );
		
		elseif( vars.shadowBolt <= 0 )
		then
			local target = unit:GetNextTarget();
			if( unit:GetDistanceYards( target ) >= 5 )
			then
				unit:FullCastSpellOnTarget( SPELL_SHADOW_BOLT, target );
			end
			vars.shadowBolt = 2;
		
		elseif( vars.corruptSoul <= 0 )
		then
			local target = unit:GetRandomPlayer( 0 );
			if( target )
			then
				unit:FullCastSpellOnTarget( SPELL_CORRUPT_SOUL, target );
				unit:PlaySoundToSet( SOUND[ 6 ] );
				unit:SendChatMessage( 14, 0, YELL[ 4 ] );	
			end
			vars.corruptSoul = math.random( 25, 35 );
		end
	
	else
		vars.soulstorm = vars.soulstorm - 1;
		vars.shadowBolt = vars.shadowBolt - 1;
		vars.fear = vars.fear - 1;
		vars.endPhase = vars.endPhase - 1;
		
		if( vars.soulstorm <= 0 )
		then
			unit:PlaySoundToSet( SOUND[ 5 ] );
			unit:SendChatMessage( 14, 0, YELL[ 3 ] );
			unit:CastSpell( SPELL_SOULSTORM_VISUAL );
			unit:FullCastSpell( SPELL_SOULSTORM );
			vars.soulstorm = 9999;
		
		elseif( vars.shadowBolt <= 0 )
		then
			unit:FullCastSpellOnTarget( SPELL_SHADOW_BOLT, unit:GetNextTarget() );
			vars.shadowBolt = math.random( 1, 2 );
		
		elseif( vars.fear <= 0 )
		then
			SetDBCSpellVar( SPELL_FEAR, "MaxTargets", 1 );
			unit:CastSpell( SPELL_FEAR );
			vars.fear = math.random( 8, 12 );
			
		elseif( vars.endPhase <= 0 )
		then
			vars.phase = 1;
			unit:Unroot();
		end	
	end
end

RegisterUnitEvent( 36497, 18, OnSpawn );
RegisterUnitEvent( 36497, 1 , OnCombat );
RegisterUnitEvent( 36497, 23, OnDamageTaken );
RegisterUnitEvent( 36497, 2 , OnLeaveCombat );
RegisterUnitEvent( 36497, 3 , OnTargetDied );
RegisterUnitEvent( 36497, 4 , OnDeath );
RegisterUnitEvent( 36497, 21, OnAIUpdate );

--[[
	Corrupted Soul Fragment AI (36535)
--]]

function NpcOnSpawn( unit )

	if( unit:GetDungeonDifficulty() ~= 0 )
	then
		unit:SetMaxHealth( 56700 );
		unit:SetHealth( 56700 );
	end
	
	unit:SetFlag( 0x0006 + 0x0036, 0x0000800 );

	unit:DisableCombat( 1 );
	
	unit:CastSpell( SPELL_PURPLE_BANISH_VISUAL );
	
	local summoner = unit:GetUInt64Value( 0x0006 + 0x0008 );
	
	unit:SetUnitToFollow( summoner, 1, 1 );
	
	unit:RegisterAIUpdateEvent( 1000 );
	
end

function NpcOnAIUpdate( unit )
	
	if( unit:IsCreatureMoving() == false )
	then
		unit:SendChatMessage( 14, 0, "debug: consume soul" );
		unit:CastSpell( SPELL_CONSUME_SOUL );
		unit:Despawn( 1000, 0 );
	end
end

RegisterUnitEvent( 36535, 18, NpcOnSpawn );
RegisterUnitEvent( 36535, 21, NpcOnAIUpdate );
