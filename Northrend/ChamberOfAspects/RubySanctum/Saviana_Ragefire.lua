--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: Saviana Ragefire
	Engine: A.L.E
	Credits: Trinity for texts, sound ids, timers and spell ids.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local BOSS_HP = { 4183500, 13945000, 4183500, 13945000 };

local SOUND = {
[ 1 ] = 17528;  -- OnCombat
[ 2 ] = 17532;  -- OnCast: "Conflagration"
[ 3 ] = 17530;  -- OnTargetDied 1
[ 4 ] = 17529;  -- OnTargetDied 2
[ 5 ] = 17531;	-- OnDeath
};

local CHAT = {
[ 1 ] = "Burn in the master's flame!";  -- OnCast: "Conflagration"
[ 2 ] = "%s becomes enraged!";          -- OnEnrage (type 16)
[ 3 ] = "Halion will be pleased.";      -- OnTargetDied 1
[ 4 ] = "As it should be....";          -- OnTargetDied 2
};

-- Spells:
local SPELL_CONFLAGRATION       = 74452; -- need a dummy
local SPELL_FLAME_BEACON        = 74453;
local SPELL_CONFLAGRATION_2     = 74454; -- dummy effect
local SPELL_CONFLAGRATION_3		= 74455; -- TODO: need a scripted effect
local SPELL_ENRAGE              = 78722;
local SPELL_FLAME_BREATH        = 74403;

local self = getfenv( 1 );

function OnSpawn( unit )

    local diff = unit:GetDungeonDifficulty();

    unit:SetMaxHealth( BOSS_HP [ diff + 1 ] );
    unit:SetHealth( BOSS_HP [ diff + 1 ] );
end

function OnCombat( unit )

	self[ tostring( unit )] = {
	phase = 1,
	flamebreath = 14,
	flight = 60,
	movement = 0;
	enrage = 20

	};

	--[[ Developer notes: we dont need to send the chat here since
	our monstersay table will do the job, instance collision checked. ]]

	unit:PlaySoundToSet( SOUND[ 1 ] );

	unit:RegisterAIUpdateEvent( 1000 );

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
		local random = math.random( 3, 4 );
		unit:PlaySoundToSet( SOUND[ random ] );
		unit:SendChatMessage( 14, 0, CHAT[ random ] );
	end
end

function OnDeath( unit )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

	--[[ Developer notes: we dont need to send the chat here since
	our monstersay table will do the job, instance collision checked. ]]

	unit:PlaySoundToSet( SOUND[ 5 ] );

end

function OnAIUpdate( unit )

	if( unit:IsCasting() == true ) then return; end

	if( unit:GetNextTarget() == nil ) then
		unit:WipeThreatList()
		return;
	end

	local vars = self[ tostring( unit ) ];

	vars.flamebreath = vars.flamebreath - 1;
	vars.enrage = vars.enrage - 1;
	vars.flight = vars.flight - 1;

	if( vars.flamebreath <= 0 )
    then
		unit:FullCastSpellOnTarget( SPELL_FLAME_BREATH, unit:GetMainTank() );
		vars.flamebreath = math.random( 20, 30 );

	elseif( vars.enrage <= 0 )
	then
		unit:FullCastSpell( SPELL_ENRAGE );
		unit:SendChatMessage( 16, 0, CHAT[ 2 ] );
		vars.enrage = 24;

	elseif( vars.flight <= 0 )
	then
		unit:DisableCombat( 1 );
		unit:RemoveAIUpdateEvent();

		-- take off

		unit:SetFlying();
		unit:MoveTo( unit:GetX(), unit:GetY(), unit:GetZ() + 10, unit:GetO() );

		unit:RegisterEvent( MovementInform, 1000, 0 );
		vars.flight = 50;
	end
end

function MovementInform( unit )

	if( unit:IsCreatureMoving() == true ) then return; end

	local vars = self[ tostring( unit ) ];

	vars.movement = vars.movement + 1;

	if( vars.movement == 2 )
	then
		unit:MoveTo( 3155.51, 683.84, 95.00, 4.69 ); -- wp1

	elseif( vars.movement == 4 )
	then
		unit:CastSpell( SPELL_CONFLAGRATION )
		unit:SendChatMessage( 14, 0, CHAT[ 1 ] );
		unit:PlaySoundToSet( SOUND[ 2 ] );

	elseif( vars.movement == 8 )
	then
		unit:MoveTo( 3151.07, 636.44, 79.54, 4.69 ); -- wp2

	elseif( vars.movement == 9 )
	then
		unit:MoveTo( 3151.07, 636.44, 78.65, 4.69 ); -- wp3

	elseif( vars.movement == 10 )
	then
		unit:Land();
		unit:DisableCombat( 0 );
		unit:RemoveEvents();
		unit:RegisterAIUpdateEvent( 1000 );
		vars.movement = 0;
	end
end

RegisterUnitEvent( 39747, 18, OnSpawn );
RegisterUnitEvent( 39747, 1 , OnCombat );
RegisterUnitEvent( 39747, 2 , OnLeaveCombat );
RegisterUnitEvent( 39747, 3 , OnTargetDied );
RegisterUnitEvent( 39747, 4 , OnDeath );
RegisterUnitEvent( 39747, 21, OnAIUpdate );


--[[
			Spell: Conflagration ( 74452 )
--]]

function ConflagrationInitDummy( effectIndex, spellObject )

	local caster = spellObject:GetCaster();
	local target = caster:GetRandomPlayer( 0 );

	local raidMode = { 3, 6, 3, 6 };
	local diff = caster:GetDungeonDifficulty();

	local targetNum = raidMode[ diff + 1 ];

	for i = 1, targetNum  -- targetNum its the "for" limiter
	do

		caster:CastSpellOnTarget( SPELL_FLAME_BEACON, target );
		caster:FullCastSpellOnTarget( SPELL_CONFLAGRATION_2, target );

	end
end

RegisterDummySpell( SPELL_CONFLAGRATION, ConflagrationInitDummy );
