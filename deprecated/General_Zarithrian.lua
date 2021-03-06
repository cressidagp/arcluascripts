--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: General Zarithrian
	Engine: A.L.E
	Credits: Trinity for texts, sound ids, timers and spell ids.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local BOSS_HP = { 4141665, 14098395, 4141665, 14098395 };

local SOUND = {
[ 1 ] = 17512;  -- OnCombat
[ 2 ] = 17513;  -- OnTargetDied 1
[ 3 ] = 17514;  -- OnTargetDied 2
[ 4 ] = 17516;  -- Minions
[ 5 ] = 17515;  -- OnDeath
};

local CHAT = {
[ 1 ] = "You thought you stood a chance?";  -- OnTargetDied 1
[ 2 ] = "It's for the best.";               -- OnTargetDied 2
[ 3 ] = "Turn them to ash, minions!";       -- OnMinions
};

-- Spells:
local SPELL_INTIMIDATING_ROAR     = 74384;
local SPELL_CLEAVE_ARMOR          = 74367;
local SPELL_SUMMON_FLAMECALLER    = 74398; -- Zarithrian Spawn Stalker
local SPELL_BLAST_NOVA            = 74392; -- Onyx Flamecaller
local SPELL_LAVA_GOUT             = 74394; -- Onyx Flamecaller

local self = getfenv( 1 );

function OnSpawn( unit )

    local diff = unit:GetDungeonDifficulty();

    unit:SetMaxHealth( BOSS_HP [ diff + 1 ] );

    unit:SetHealth( BOSS_HP [ diff + 1 ] );

	-- [[ Moved this to SQL file.
	-- unit:DisableCombat( true ); --]]

end

function OnCombat( unit )

	self[ tostring( unit )] = {
	phase = 1,
	diff = unit:GetDungeonDifficulty(); -- TODO: implement LCF for Is25Man
	cleave = 8,
	roar = 14,
	minions = 15,
	minions25 = 16
	};

	unit:PlaySoundToSet( SOUND[ 1 ] );

	--[[ Developer notes: we dont need to send the chat here since
	our monstersay table will do the job, instance collision checked. ]]

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
    	local random = math.random( 2, 3 );
    	unit:PlaySoundToSet( SOUND[ random ] );
    	unit:SendChatMessage( 14, 0, CHAT[ random - 1 ] );
	end
end

function OnDeath( unit )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

	--[[ Developer notes: we dont need to send the chat here since our
	monstersay table will do the job, instance collision checked. ]]

	unit:PlaySoundToSet( SOUND[ 5 ] );

end

function OnAIUpdate( unit )

	if( unit:IsCasting() == true ) then return; end

	if( unit:GetNextTarget() == nil ) then
		unit:WipeThreatList()
		return;
	end

	local vars = self[ tostring( unit ) ];

	vars.cleave = vars.cleave - 1;
	vars.minions = vars.minions - 1;
	vars.minions25 = vars.minions25 - 1;
	vars.roar = vars.roar - 1;

	if( vars.cleave <= 0 )
    then
		unit:CastSpellOnTarget( SPELL_CLEAVE_ARMOR, unit:GetMainTank() );
		vars.cleave = 15;

	elseif( vars.roar <= 0 )
	then
		unit:FullCastSpell( SPELL_INTIMIDATING_ROAR );
		vars.roar = math.random( 35, 40 );

	elseif( vars.minions <= 0 )
	then
		unit:CastSpell( SPELL_SUMMON_FLAMECALLER );
		unit:PlaySoundToSet( SOUND[ 4 ] );
		unit:SendChatMessage( 14, 0, CHAT[ 3 ] );
		vars.minions = 45;

	elseif( vars.minions25 <= 0 and (vars.diff == 1 or vars.diff == 3 ) )
	then
		unit:CastSpell( SPELL_SUMMON_FLAMECALLER );
		vars.minions25 = 45;
		unit:SendChatMessage( 12, 0, "debug: minions 2" );
	end
end

--RegisterUnitEvent( 39746, 18, OnSpawn );
--RegisterUnitEvent( 39746, 1 , OnCombat );
--RegisterUnitEvent( 39746, 2 , OnLeaveCombat );
--RegisterUnitEvent( 39746, 3 , OnTargetDied );
--RegisterUnitEvent( 39746, 4 , OnDeath );
--RegisterUnitEvent( 39746, 21, OnAIUpdate );