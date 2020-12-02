--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: Saviana Ragefire
	Engine: A.L.E
	Credits: Trinity for texts and sound ids.

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
local SPELL_CONFLAGRATION         = 74452;	-- need a dummy
local SPELL_FLAME_BEACON          = 74453;
local SPELL_CONFLAGRATION_2       = 74454;	-- unknown dummy effect
local SPELL_ENRAGE                = 78722;
local SPELL_FLAME_BREATH          = 74403;

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
	flamebeacon = 0,
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

	if( vars.flamebreath <= 0 )
    then
		unit:FullCastSpellOnTarget( SPELL_FLAME_BREATH, unit:GetMainTank() );
		unit:SendChatMessage( 12, 0, "debug: flame breath" );
		vars.flamebreath = 14;

	elseif( vars.enrage <= 0 )
	then
		unit:CastSpell( SPELL_ENRAGE );
		unit:SendChatMessage( 12, 0, "debug: enrage" );
		vars.enrage = 20;
	end
end

RegisterUnitEvent( 39747, 18, OnSpawn );
RegisterUnitEvent( 39747, 1 , OnCombat );
RegisterUnitEvent( 39747, 2 , OnLeaveCombat );
RegisterUnitEvent( 39747, 3 , OnTargetDied );
RegisterUnitEvent( 39747, 4 , OnDeath );
RegisterUnitEvent( 39747, 21, OnAIUpdate );
