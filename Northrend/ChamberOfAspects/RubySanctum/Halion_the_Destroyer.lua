--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: Halion the Destroyer
	Engine: A.L.E
	Credits: Trinity for texts, sound ids, timers and spell ids.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

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

local CHAT = {
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
local SPELL_METEOR_STRIKE		= 74637; -- aoe, need a dummy
local SPELL_TAIL_LASH			= 74531;
local SPELL_TWILIGHT_PRECISION  = 78243; -- not aura displayed... not working?

-- Spells (Halion Controller):

local  SPELL_COSMETIC_FIRE_PILLAR	= 76006; -- need a dummy effect and 2 dummys aura effect

-- Spells (Misc):
local SPELL_TWILIGHT_PHASING    = 74808; -- Phase spell from phase 1 to phase 2

local TREES = { 203034, 203035, 203036, 203037 };

-- For 3.3.5a
local UNIT_FIELD_FLAGS			= 0x0006 + 0x0035;
local UNIT_FLAG_NOT_SELECTABLE	= 0x02000000;
local GAMEOBJECT_BYTES_1		= 0x0006 + 0x000B;

local self = getfenv( 1 );

function OnSpawn( unit )

    local diff = unit:GetDungeonDifficulty();

    unit:SetMaxHealth( BOSS_HP [ diff + 1 ] );

    unit:SetHealth( BOSS_HP [ diff + 1 ] );

end

function OnCombat( unit )

	self[ tostring( unit )] = {

	phase = 1,
	firewallTime = 5,
	firewallInClosed = false,
	flamebreath = math.random( 5, 15 ),
	cleave = math.random( 6, 10 ),
	tail = math.random( 7, 12 ),
	fierycombustion = math.random( 15, 18 ),
	meteorstrike = 18

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
	local pct = unit:GetHealthPct();

    if( damage >= hp and vars.phase ~= 3 )
	then
        damage = hp - 1;

	end

	-- TODO: implement HealthBelowPctDamaged( %, damage )

	if( pct < 75 and vars.phase == 1 )
	then
		unit:PlaySoundToSet( SOUND[ 4 ] );
		unit:SendChatMessage( 14, 0, CHAT[ 4 - 1 ] );
		vars.phase = 2;
		unit:CastSpell( SPELL_TWILIGHT_PHASING );

	end

	if( vars.phase == 3 )
	then
		if( unit:GetPhase() ~= attacker:GetPhase() )
		then
			return;
		end

		local controller = unit:GetCreatureNearestCoords( 3156.04, 533.266, 72.9721, 40146 );
		controller:SetHealth( controller:GetHealth() - damage );
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
    	unit:SendChatMessage( 14, 0, CHAT[ 6 - 2 ] );
	end
end

function OnDeath( unit )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

	--[[ Developer notes: we dont need to send the chat here since our
	monstersay table will do the job, instance collision checked. ]]

    unit:PlaySoundToSet( SOUND[ 5 ] );

	local twlighthalion = unit:GetClosestCreature( unit:GetX(), unit:GetY(), unit:GetZ(), 40142 );

	if( twlighthalion:IsAlive() == true )
	then
		twlighthalion:Kill();
	end

	local controller = unit:GetClosestCreature( 3156.04, 533.266, 72.9721, 40146 );

	if( controller:IsAlive() == true )
	then
		controller:Kill();
	end
end

function OnAIUpdate( unit )

	if( unit:IsCasting() == true ) then return; end

	if( unit:GetNextTarget() == nil ) then
		unit:WipeThreatList()
		return;
	end

	local vars = self[ tostring( unit ) ];

	vars.firewall = vars.firewall - 1;
	vars.flamebreath = vars.flamebreath - 1;
	vars.cleave = vars.cleave - 1;
	vars.tail = vars.tail - 1;

	if( vars.firewallTime <= 0 and vars.firewallIsClosed == false )
	then
		local flamering = unit:GetGameObjectNearestCoords( 3154.99, 535.64, 72.89, 203007 );
		flamering:SetByte( GAMEOBJECT_BYTES_1, 0, 0 );
		vars.firewallTime = 0;
		vars.firewallIsClosed = true;


	elseif( vars.flamebreath <= 0 )
    then
		unit:FullCastSpell( SPELL_FLAME_BREATH );
		unit:SendChatMessage( 12, 0, "debug: flame breath" );
		vars.flamebreath = math.random( 5, 15 );

	elseif( vars.cleave <= 0 )
	then
		unit:CastSpellOnTarget( SPELL_CLEAVE, unit:GetMainTank() );
		unit:SendChatMessage( 12, 0, "debug: cleave" );
		vars.cleave = math.random( 6, 10 );

	elseif( vars.tail <= 0 )
	then
		unit:CastSpell( SPELL_TAIL_LASH );
		unit:SendChatMessage( 12, 0, "debug: tail lash" );
		vars.tail = math.random( 7, 12 )
	end
end

RegisterUnitEvent( 39863, 18, OnSpawn );
RegisterUnitEvent( 39863, 1 , OnCombat );
RegisterUnitEvent( 39863, 23, OnDamageTaken );
RegisterUnitEvent( 39863, 2 , OnLeaveCombat );
RegisterUnitEvent( 39863, 3 , OnTargetDied );
RegisterUnitEvent( 39863, 4 , OnDeath );
RegisterUnitEvent( 39863, 21, OnAIUpdate );

--[[
			Twilight Halion AI
--]]

function TwilightHalionOnSpawn( unit )

end

RegisterUnitEvent( 40142, 18 , TwilightHalionOnSpawn );

--[[
			Halion Controller AI
--]]

function HalionControllerOnSpawn( unit )

	self[ tostring( unit )] = {
	
	event = 0,
	timer = 4
	
	};

	unit:RegisterAIUpdateEvent( 1000 );

end

function HalionControllerOnAIUpdate( unit )

	local vars = self[ tostring( unit ) ];
	
	vars.timer = vars.timer - 1;

	if( vars.event == 0 )
	then
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
				--unit:SendChatMessage( 12, 0, "debug: got a tree" );
			end
		end
		
		vars.event = vars.event + 1;
		vars.timer = 4;
	end
end

RegisterUnitEvent( 40146, 18, HalionControllerOnSpawn );
RegisterUnitEvent( 40146, 21, HalionControllerOnAIUpdate );
