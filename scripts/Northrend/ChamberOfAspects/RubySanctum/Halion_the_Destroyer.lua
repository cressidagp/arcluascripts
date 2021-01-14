--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: Halion the Destroyer
	Engine: A.L.E

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	yt
	
	ToDo:

	*) More clean up
	*) 75416: need spellscript?
	
	enUS locale:
	
	esMX locale:
	
local MAP_RUBY_SANCTUM	= 724;

local NPC_HALION	= 39863;
local NPC_25M_HALION	= 39864;
local H_NPC_HALION	= 39944;
local H_NPC_25M_HALION	= 39945;

local NPC_TWILIGHT_HALION	= 40142;
local NPC_25M_TWILIGHT_HALION	= 40143;
local H_NPC_TWILIGHT_HALION = 40144;
local H_NPC_25M_TWILIGHT_HALION	= 40145;

local NPC_CONTROLLER = 40146;

-- For 3.3.5a
local GAMEOBJECT_BYTES_1		= 0x0006 + 0x000B;
local UNIT_FIELD_FLAGS			= 0x0006 + 0x0035;
local UNIT_FLAG_NOT_SELECTABLE	= 0x02000000;
local UNIT_FIELD_FLAGS_2		= 0x0006 + 0x0036;
local UNIT_FLAG2_ENABLE_POWER_REGEN	= 0x0000800;

--]]

--local mod = getfenv( 1 );
--assert( mod );
--module( mod._NAME..".HALION_DESTROYER", package.seeall );

local BOSS_HP = { 11156000, 40440500, 15339500, 58569000 };

local SOUND = {
[ 1 ] = 17499;  -- Intro
[ 2 ] = 17500;  -- OnCombat
[ 3 ] = 17505;  -- OnMeteorStrike
[ 4 ] = 17507;  -- OnPhaseTwo
[ 5 ] = 17503;  -- OnDeath
[ 6 ] = 17501;  -- OnTargetDied
[ 7 ] = 17504;  -- OnBerserk
};

local YELL = {
[ 1 ] = "Meddlesome insects! You are too late. The Ruby Sanctum is lost!";  -- Intro
[ 2 ] = "The heavens burn!";  -- OnMeterStrike
[ 3 ] = "You will find only suffering within the realm of twilight! Enter if you dare!";  -- OnPhaseTwo
[ 4 ] = "Another 'hero' falls.";  -- OnTargetDied (shoud be "hero", but "" caused problems)
[ 5 ] = "Not good enough...."; -- OnBerserk
};

local TEXT = {
[ 1 ] = "Without pressure in both realms, %s begins to regenerate.";  -- Shared (type 41)
[ 2 ] = "Your efforts force %s further out of the physical realm!"; -- (type 41)
[ 3 ] = "Your companions' efforts force %s further into the physical realm!"; -- (type 41)
};

-- Spells (Halion):
local SPELL_FLAME_BREATH		= 74525;
local SPELL_CLEAVE				= 74524;
local SPELL_METEOR_STRIKE		= 74637; -- aoe, need a dummy effect
local SPELL_TAIL_LASH			= 74531;

local SPELL_TWILIGHT_PRECISION  = 78243; -- not aura displayed... not working?

local SPELL_FIERY_COMBUSTION    = 74562;

-- Spells (Twilight Halion):
local SPELL_SOUL_CONSUMPTION 	= 74792;

-- Spells (Halion Controller):
local SPELL_COSMETIC_FIRE_PILLAR	= 76006; -- need a dummy effect and 2 dummys aura effect

-- Spells (Misc):
local SPELL_TWILIGHT_PHASING    	= 74808; -- Phase spell from phase 1 to phase 2
local SPELL_DUSK_SHROUD         	= 75476;
local SPELL_COPY_DAMAGE         	= 74810;
local SPELL_SUMMON_TWILIGHT_PORTAL	= 74809; -- Summons go 202794

local TREES = { 203034, 203035, 203036, 203037 };

local self = getfenv( 1 );

function OnSpawn( unit )

	-- set health acording to difficulty
    local diff = unit:GetDungeonDifficulty();

    unit:SetMaxHealth( BOSS_HP[ diff + 1 ] );

    unit:SetHealth( BOSS_HP[ diff + 1 ] );
	
	unit:SetFlag( 0x0006 + 0x0036, 0x0000800 );

end

function OnCombat( unit )

	-- create protected variables
	self[ tostring( unit )] = {

	phase = 2,
	firewallInClosed = false,
	cleave = math.random( 6, 10 ),
	tailLash = math.random( 7, 12 ),
	flameBreath = math.random( 5, 15 ),
	firewallTime = 5,
	meteorStrike = 18,
	fieryCombustion = math.random( 15, 18 )
	
	};

	--[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

    unit:PlaySoundToSet( SOUND[ 2 ] );

	unit:AddAura( SPELL_TWILIGHT_PRECISION, 0 );
	unit:RegisterAIUpdateEvent( 1000 );

end

function OnDamageTaken( unit, event, attacker, damage )

	local vars = self[ tostring( unit ) ];

	local hp = unit:GetHealth();
	
    if( damage >= hp and vars.phase ~= 4 )
	then
        damage = hp - 1;
	end

	local pct = unit:GetHealthPct();
	
	if( pct < 75 and vars.phase == 2 )
	then
		unit:PlaySoundToSet( SOUND[ 4 ] );
		unit:SendChatMessage( 14, 0, YELL[ 4 - 1 ] );
		vars.phase = 3;
		unit:SetFlag( 0x0006 + 0x0035, 0x02000000 );
		unit:CastSpell( SPELL_TWILIGHT_PHASING );
	end

	if( vars.phase == 4 )
	then
		if( unit:GetPhase() ~= attacker:GetPhase() ) then return; end

		local iid = unit:GetInstanceID();
		local controller = local controller = GetInstanceCreature( 724, iid, 200631 );
		if( controller )
		then
			controller:SetHealth( controller:GetHealth() - damage );
		end
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
    	unit:PlaySoundToSet( SOUND[ 6 ] );
    	unit:SendChatMessage( 14, 0, YELL[ 6 - 2 ] );
	end
end

function OnDeath( unit )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

	--[[ Developer notes: we dont need to send the chat here since our
	monstersay table will do the job, instance collision checked. ]]

    unit:PlaySoundToSet( SOUND[ 5 ] );

	local twlightHalion = unit:GetClosestCreature( 3156.04, 533.27, 72.97, 40142 );
	if( twlightHalion )
	then
		if( twlightHalion:IsAlive() == true )
		then
			twlightHalion:Kill();
		end
	end

	local iid = unit:GetInstanceID();
	local controller = GetInstanceCreature( 724, iid, 200631 );
	if( controller )
	then
		if( controller:IsAlive() == true )
		then
			controller:Kill();
		end
	end
end

function OnAIUpdate( unit )

	local vars = self[ tostring( unit ) ];

	if( vars.phase = 3 ) then return; end

	if( unit:GetNextTarget() == nil ) then
		unit:WipeThreatList()
		return;
	end
	
	--if( unit:IsCasting() == true ) then return; end

	--if( unit:GetAIState() == 2 ) then return; end

	if( unit:GetCurrentSpell() ~= nil ) then return; end

	vars.cleave = vars.cleave - 1;
	vars.tailLash = vars.tailLash - 1;
	vars.flameBreath = vars.flameBreath - 1;
	if( vars.firewallTime ~= nil ) then vars.firewallTime = vars.firewallTime - 1; end
	vars.meteorStrike = vars.meteorStrike - 1;
	vars.fieryCombustion = vars.fieryCombustion - 1;

	if( vars.cleave <= 0 )
	then
		unit:CastSpell( SPELL_CLEAVE );
		vars.cleave = math.random( 6, 10 );

	elseif( vars.tailLash <= 0 )
	then
		unit:CastSpell( SPELL_TAIL_LASH );
		vars.tailLash = math.random( 7, 12 )

	elseif( vars.flameBreath <= 0 )
    then
		unit:FullCastSpell( SPELL_FLAME_BREATH );
		vars.flameBreath = math.random( 5, 15 );

	elseif( vars.firewallTime and vars.firewallTime <= 0 and vars.firewallIsClosed == false )
	then
		local flameRing = unit:GetGameObjectNearestCoords( 3154.99, 535.64, 72.89, 203007 );
		if( flamering )
		then
			flamering:SetByte( 0x0006 + 0x000B, 0, 0 );
			--vars.firewallTime = 0;
			vars.fireWallTime = nil;
			vars.firewallIsClosed = true;
		end
		
	elseif( vars.meteorStrike <= 0 )
	then
	
	elseif( vars.fieryCombustion <= 0 )
	then
		local target = unit:GetRandomPlayer( 0 );
		if( target )
		then
			unit:CastSpellOnTarget( SPELL_FIERY_COMBUSTION, target );
		end
		vars.fieryCombustion = 25;
	end
end

RegisterUnitEvent( 39863, 18, OnSpawn );
RegisterUnitEvent( 39863, 1, OnCombat );
RegisterUnitEvent( 39863, 23, OnDamageTaken );
RegisterUnitEvent( 39863, 2, OnLeaveCombat );
RegisterUnitEvent( 39863, 3, OnTargetDied );
RegisterUnitEvent( 39863, 4, OnDeath );
RegisterUnitEvent( 39863, 21, OnAIUpdate );

--[[
		Twilight Halion AI (40142)
--]]

function TwilightHalionOnSpawn( unit )

	self[ tostring( unit )] = {

	tail = 12,
	soul = 15

	};

	-- set halion health
	unit:AddAura( SPELL_COPY_DAMAGE, 0 );
	-- to halion unit:AddAura( SPELL_COPY_DAMAGE, 0 );
	unit:CastSpell( SPELL_DUSK_SHROUD );
end

function TwilightHalionOnSpawn( unit )

	local vars = self[ tostring( unit ) ];

	if( unit:IsCasting() == true ) then return; end

	if( unit:GetNextTarget() == nil ) then
		unit:WipeThreatList()
		return;
	end

	vars.tail = vars.tail - 1;
	vars.soul = vars.soul - 1;

	if( vars.tail <= 0 )
	then
		unit:FullCastSpellOnTarget( SPELL_TAIL_LASH, unit:GetRandomPlayer( 0 ) ); -- AoE?
		vars.tail = math.random( 12, 16 );

	elseif( vars.soul <= 0 )
	then
		unit:FullCastSpellOnTarget( SPELL_SOUL_CONSUMPTION, unit:GetRandomPlayer( 0 ) ); -- Any
		vars.soul = 28;

	end
end

RegisterUnitEvent( 40142, 18, TwilightHalionOnSpawn );
RegisterUnitEvent( 40142, 21, TwilightHalionOnAIUpdate );

--[[
		Halion Controller AI (40146)
--]]

-- def unit flags 256 + 33554432 (256 for development :P)

function ControllerOnSpawn( unit )

	-- created protected variables
	self[ tostring( unit )] = {

	materialCorporealityValue = 5,
	materialDamageTaken = 0,
	twilightDamageTaken = 0
	--event = 0,
	--timer = 4
	
	};
	
	-- created shared variables
	local iid = unit:GetInstanceID();
	
	HSHARED = {}
	HSHARED[ iid ] = {
	
	halionIsDone = false

	};

	unit:RegisterAIUpdateEvent( 1000 );

end

function ControllerOnCombat( unit )

	-- add more protected variables
	local vars = self[ tostring( unit ) ];
	
	vars.twilightDamageTaken = 0;
	vars.materialDamageTaken = 0;
	vars.triggerBerserk = 1000 * 30 * 60;
	vars.evadeCheck = 5;
	
end

function ControllerOnLeaveCombat( unit )

	if( SHARED[ iid ].halionIsDone == true )
	then return; end
	
	local twlightHalion = unit:GetClosestCreature( 3156.04, 533.27, 72.97, 40142 );
	if( twlightHalion )
	then
		twlightHalion:Despawn( 1000, 0 );
	end	

	local halion = unit:GetClosestCreature( 3156.04, 533.27, 72.97, 39863 );
	if( halion )
	then
		Halion:Despawn( 1000, 0 );
	end
end

function ControllerOnAIUpdate( unit )

	local vars = self[ tostring( unit ) ];

	vars.timer = vars.timer - 1;

	if( vars.event == 0 )
	then
		--[[ Developer notes: we have a problem here, since arcemu didnt implemented extra_flags why miss
		CREATURE_FLAG_EXTRA_TRIGGER (creature is trigger-NPC (invisible to players only)). We can
		manually make the trigger invisible but invisible creatures cast invisible spells. ]]

		unit:CastSpell( SPELL_COSMETIC_FIRE_PILLAR );
		vars.event = vars.event + 1;
		vars.timer = 4;

	elseif( vars.event == 1 and vars.timer == 0 )
	then
		unit:SendChatMessage( 12, 0, "debug: event 1" );
		for k, v in ipairs( unit:GetInRangeObjects() )
		do
			if( v:GetEntry() == TREES[ i ] )
			then
				v:SetByte( GAMEOBJECT_BYTES_1, 0, 2 );
				unit:SendChatMessage( 12, 0, "debug: got a tree" );
			end
		end

		vars.event = vars.event + 1;
		vars.timer = 4;
	end
end

RegisterUnitEvent( 40146, 18, ControllerOnSpawn );
RegisterUnitEvent( 40146, 1, ControllerOnCombat );
RegisterUnitEvent( 40146, 2, ControllerOnLeaveCombat );
RegisterUnitEvent( 40146, 21, ControllerOnAIUpdate );

--[[
		Spell: Twilight Phasing (74808)


function SpellHalionTwilightPhasing( _, _, spellid, spellObject )

	if( spellid == 74808 )
	then
		local caster = spellObject:GetCaster();
		local x = caster:GetX();
		local y = caster:GetY();
		local z = caster:GetZ();
		local o = caster:GetO();

	caster:CastSpellAoE( x, y, z, SPELL_SUMMON_TWILIGHT_PORTAL );
	caster:SpawnCreature( 40142, x, y, z, o, 14, 0, 1, 1, 1, 1, 0 );

	end
end

RegisterServerHook( 33, SpellHalionTwilightPhasing );
--]]