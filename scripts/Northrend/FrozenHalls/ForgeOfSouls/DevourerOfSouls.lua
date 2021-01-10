--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Forge of Souls: Devourer Of Souls
	Engine: A.L.E
	Credits: Trinity for texts, sound ids and spell ids, and timers.
	
	https://www.youtube.com/watch?v=zblAhfbAfOY
	
local NPC_DEVOURER			= 36502;
local H_NPC_DEVOURER		= 37677;
local NPC_CRUCIBLE_OF_SOULS	= 37094;

local BOSS_HP = { 647088, 903227 };

local DISPLAY_ANGER = 30148;
local DISPLAY_SORROW = 30149;
local DISPLAY_DESIRE = 30150;

local UNIT_FIELD_TARGET = 0x0006 + 0x000C;
local UNIT_FIELD_FLAGS_2 = 0x0006 + 0x0036;
local UNIT_FLAG2_ENABLE_POWER_REGEN = 0x0000800;

--]]

local SOUND = {
[ 1 ] = 16884;	-- OnCombatFaceAnger
[ 2 ] = 16890;	-- OnCombatFaceDesire
[ 3 ] = 16885;	-- OnTargetDiedFaceAnger 1
[ 4 ] = 16886;	-- OnTargetDiedFaceAnger 2
[ 5 ] = 16896;	-- OnTargetDiedFaceSorrow 1
[ 6 ] = 16897;	-- OnTargetDiedFaceSorrow 2
[ 7 ] = 16891;	-- OnTargetDiedFaceDesire 1
[ 8 ] = 16892;	-- OnTargetDiedFaceDesire 2
[ 9 ] = 16887;	-- OnDeathFaceAnger
[ 10 ] = 16898; -- OnDeathFaceSorrow
[ 11 ] = 16893; -- OnDeathFaceDesire
[ 12 ] = 16888; -- OnUnleashSoulAnger
[ 13 ] = 16899; -- OnUnleashSoulSorrow
[ 14 ] = 16894; -- OnUnleashSoulDesire
[ 15 ] = 16889; -- OnWailingSoulAnger
[ 16 ] = 16895; -- OnWailingSoulDesire
};

local YELL = {
[ 1 ] = "Damnation!";									-- OnTargetDiedFaceAnger 1
[ 2 ] = "Doomed for eternity!";							-- OnTargetDiedFaceAnger 2
[ 3 ] = "Damnation!";									-- OnTargetDiedFaceSorrow 1
[ 4 ] = "Doomed for eternity!";							-- OnTargetDiedFaceSorrow 2
[ 5 ] = "Damnation!";									-- OnTargetDiedFaceDesire 1
[ 6 ] = "Doomed for eternity!";							-- OnTargetDiedFaceDesire 2
[ 7 ] = "SUFFERING! ANGUISH! CHAOS! RISE AND FEED!";	-- OnUnleashSoulAnger
[ 8 ] = "SUFFERING! ANGUISH! CHAOS! RISE AND FEED!";	-- OnUnleashSoulSorrow
[ 9 ] = "SUFFERING! ANGUISH! CHAOS! RISE AND FEED!";	-- OnUnleashSoulDesire
[ 10 ] = "Stare into the abyss and see your end.";		-- OnWailingSoulAnger
[ 11 ] = "Stare into the abyss and see your end.";		-- OnWailingSoulDesire
};

local WHISPER = {
[ 1 ] = "%s casts |cFFFFFF00Mirrored Soul!|r";		-- MirroerSoul
[ 2 ] = "%s begins to |cFFFF0000Unleash Souls!|r";	-- UnleashSoul
[ 3 ] = "%s begins to cast Wailing Souls!";			-- WailingSoul
};

-- Spells:
local SPELL_PHANTOM_BLAST					= 68982;
--local H_SPELL_PHANTOM_BLAST				= 70322;
--local SPELL_MIRRORED_SOUL_PROC_AURA		= 69023;
--local SPELL_MIRRORED_SOUL_DAMAGE			= 69034;
local SPELL_MIRRORED_SOUL_TARGET_SELECTOR	= 69048; -- has a scripted effect
--local SPELL_MIRRORED_SOUL_BUFF			= 69051;
local SPELL_WELL_OF_SOULS					= 68820;
local SPELL_UNLEASHED_SOULS					= 68939; -- client crash
local SPELL_WAILING_SOULS_STARTING			= 68912; -- initial spell cast at begining of wailing souls phase, has an apply dummy aura effect
local SPELL_WAILING_SOULS_BEAM				= 68875; -- the beam visual, has an apply periodic trigger dummy aura effect
local SPELL_WAILING_SOULS					= 68873; -- the actual spell
local H_SPELL_WAILING_SOULS					= 70324;

local self = getfenv( 1 );

function OnSpawn( unit )

	if( unit:GetDungeonDifficulty() ~= 0 )
	then
		unit:SetMaxHealth( 903227 );
		unit:SetHealth( 903227 );
	end
	unit:SetFlag( 0x0006 + 0x0036, 0x0000800 );
end

function OnCombat( unit )

	self[ tostring( unit )] = {

	diff = unit:GetDungeonDifficulty(),
	threeFaced = true,
	phantomBlast = 5,
	mirroredSoul = 8,
	wellOfSouls = 30,
	unleashedSouls = 20,
	faceAnger = 999,
	wailingSouls = math.random( 60, 70 ),
	soulTick = 999,
	soulCounter = 0
	};

	unit:PlaySoundToSet( SOUND[ 1 ] );
	
    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]
	
	local crucibleOfSouls = unit:GetCreatureNearestCoords( 5672.294, 2520.686, 713.4386, 37094 );
	if( crucibleOfSouls == nil )
	then
		unit:SpawnCreature( 37094, 5672.294, 2520.686, 713.4386, 0.9599311, 190, 0, 0, 0, 0, 1, 0 );
	end
	unit:RegisterAIUpdateEvent( 1000 );
end

function OnLeaveCombat( unit )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

	--[[ Developer notes: contrary to popular believe, this is the right place
	to remove ai update event since if a creature is dead the ai update will not trigger, so
	one remove ai update event its more than enough. ]]

	unit:RemoveAIUpdateEvent();
	unit:Unroot();
	
	-- anger
	unit:SetModel( 30148 );
	
	-- react agresive
	unit:DisableCombat( 0 );

end

function OnTargetDied( unit, _, victim )

	if( victim:IsPlayer() == false ) then return; end
	
	local display = unit:GetDisplay();
	
	-- anger
	if( display == 30148 )
	then
		local randomAnger = math.random( 3, 4 );
		unit:PlaySoundToSet( SOUND[ randomAnger ] );
		unit:SendChatMessage( 14, 0, YELL[ randomAnger - 2 ] );
		
	-- sorrow	
	elseif( display == 30149 )
	then
		local randomSorrow = math.random( 5, 6 );
		unit:PlaySoundToSet( SOUND[ randomSorrow ] );
		unit:SendChatMessage( 14, 0, YELL[ randomSorrow - 2 ] );
	
	-- desire
	elseif( display == 30150 )
	then
		local randomDesire = math.random( 7, 8 );
		unit:PlaySoundToSet( SOUND[ randomDesire ] );
		unit:SendChatMessage( 14, 0, YELL[ randomDesire - 2 ] );
	end
end

function OnDeath( unit )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

	--[[ Developer notes: we dont need to send the chat here since our
	monstersay table will do the job, instance collision checked. ]]

	local display = unit:GetDisplay();
	
	-- anger
	if( display == 30148 )
	then
		unit:PlaySoundToSet( SOUND[ 9 ] );
	
	-- sorrow
	elseif( display == 30149 )
	then
		unit:PlaySoundToSet( SOUND[ 10 ] );
		
	-- desire
	elseif( display == 30150 )
	then
		unit:PlaySoundToSet( SOUND[ 11 ] );
	end	
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
	
	vars.phantomBlast = vars.phantomBlast - 1;
	vars.mirroredSoul = vars.mirroredSoul - 1;
	vars.wellOfSouls = vars.wellOfSouls - 1;
	vars.unleashedSouls = vars.unleashedSouls - 1;
	vars.faceAnger = vars.faceAnger - 1;
	vars.wailingSouls = vars.wailingSouls - 1;
	vars.soulTick = vars.soulTick - 1;
	
	if( vars.phantomBlast <= 0 )
	then
		unit:FullCastSpellOnTarget( SPELL_PHANTOM_BLAST, unit:GetNextTarget() );
		vars.phantomBlast = 5;
		
	elseif( vars.mirroredSoul <= 0 )
	then
		-- castAOE SPELL_MIRRORED_SOUL_TARGET_SELECTOR
		unit:SendChatMessage( 41, 0, WHISPER[ 1 ] );
		vars.mirroredSoul = math.random( 15, 30 );
	
	elseif( vars.wellOfSouls <= 0 )
	then
		local target = unit:GetRandomPlayer( 0 );
		if( target )
		then
			unit:CastSpellOnTarget( SPELL_WELL_OF_SOULS, target );
		end
		
		vars.wellOfSouls = 20;
	
	elseif( vars.unleashedSouls <= 0 )
	then
		local target = unit:GetRandomPlayer( 0 );
		if( target )
		then
			-- Client crash here if client if running in server. ToDo: Check no-server client.
			-- unit:CastSpellOnTarget( SPELL_UNLEASHED_SOULS, target );
		end
		
		local display = unit:GetDisplay();
	
		-- anger
		if( display == 30148 )
		then
			unit:PlaySoundToSet( SOUND[ 12 ] );
		
		-- sorrow
		elseif( display == 30149 )
		then
			unit:PlaySoundToSet( SOUND[ 13 ] );
	
		-- desire
		elseif( display == 30150 )
		then
			unit:PlaySoundToSet( SOUND[ 14 ] );
		end	
		
		unit:SendChatMessage( 14, 0, YELL[ 7 ] );
		unit:SendChatMessage( 41, 0, WHISPER[ 2 ] );
		vars.unleashedSouls = 30;
		vars.faceAnger = 5;
	
	elseif( vars.faceAnger <= 0 )
	then
		-- anger
		unit:SetModel( 30148 );
		vars.faceAnger = 999;
		
	elseif( vars.wailingSouls <= 0 )
	then
		-- desire
		unit:SetModel( 30150 );
		unit:PlaySoundToSet( SOUND[ 16 ] );
		
		unit:SendChatMessage( 14, 0, YELL[ 10 ] );
		unit:SendChatMessage( 41, 0, WHISPER[ 3 ] );
		unit:FullCastSpell( SPELL_WAILING_SOULS_STARTING );
		
		local target = unit:GetRandomPlayer( 0 );
		if( target )
		then
			-- face target
			unit:SetUInt64Value( 0x0006 + 0x000C, target:GetGUID() );
			
			unit:FullCastSpell( SPELL_WAILING_SOULS_BEAM );
		end
		
		vars.beamAngle = unit:GetO();
		vars.beamAngleDiff = 3.14159 / 30.0000;
		local chance = math.random( 1, 2 );
		if( chance == 1 )
		then
			vars.beamAngleDiff = vars.beamAngleDiff * ( -1 );
		end

		-- react pasive
		unit:DisableCombat( 1 );
		
		-- remove any target
		unit:SetUInt64Value( 0x0006 + 0x000C, 0 );
		
		unit:Root();
		
		-- delay events
		vars.phantomBlast = vars.phantomBlast + 18;
		vars.mirroredSoul = vars.mirroredSoul + 18;
		vars.wellOfSouls = vars.wellOfSouls + 18;
		vars.unleashedSouls = vars.unleashedSouls + 18;
		vars.wailingSouls = 999;
		vars.soulTick = 3;
	
	elseif( vars.soulTick <= 0 )
	then
		vars.beamAngle = vars.beamAngle + vars.beamAngleDiff;
		unit:SetFacing( vars.beamAngle );
		unit:CastSpell( SPELL_WAILING_SOULS );
		
		if( vars.soulCounter < 16 )
		then
			vars.soulCounter = vars.soulCounter + 1;
			vars.soulTick = 1;
		else
			-- react agresive
			unit:DisableCombat( 0 );
			
			-- anger
			unit:SetModel( 30148 );
			
			unit:Unroot();
			
			vars.soulTick = 999;
			vars.wailingSouls = math.random( 60, 70 );
			vars.soulCounter = 0;
		end
	end	
end

RegisterUnitEvent( 36502, 18, OnSpawn );
RegisterUnitEvent( 36502, 1 , OnCombat );
RegisterUnitEvent( 36502, 2 , OnLeaveCombat );
RegisterUnitEvent( 36502, 3 , OnTargetDied );
RegisterUnitEvent( 36502, 4 , OnDeath );
RegisterUnitEvent( 36502, 21, OnAIUpdate );