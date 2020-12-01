--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: Baltharus the Warborn
	Engine: A.L.E
	Credits: Trinity for texts, sound ids and spells.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local BOSS_HP = { 3486250, 11156000, 3486250, 11156000 };

local SOUND = {
[ 1 ] = 17525;  -- Intro
[ 2 ] = 17520;  -- OnCombat
[ 3 ] = 17521;  -- OnTargetDied 1
[ 4 ] = 17522;  -- OnTargetDied 2
[ 5 ] = 17524;  -- OnClone
[ 6 ] = 17523;  -- OnDeath
};

local TEXT = {
[ 1 ] = "Your power wanes, ancient one.... Soon you will join your friends.";
[ 3 ] = "Baltharus leaves no survivors!";
[ 4 ] = "This world has enough heroes.";
[ 5 ] = "Twice the pain and half the fun.";
};

-- Spells:
SPELL_BARRIER_CHANNEL       = 76221;
SPELL_ENERVATING_BRAND      = 74502;
SPELL_SIPHONED_MIGHT        = 74507;
SPELL_CLEAVE                = 40504;
SPELL_BLADE_TEMPEST         = 75125;
SPELL_CLONE                 = 74511;
SPELL_REPELLING_WAVE        = 74509;
SPELL_CLEAR_DEBUFFS         = 34098;
SPELL_SPAWN_EFFECT          = 64195;

-- For 3.3.5a
local GAMEOBJECT_BYTES_1	= 0x0006 + 0x000B;

local self = getfenv( 1 );

function OnSpawn( unit, event )

    local diff = unit:GetDungeonDifficulty();
	
    unit:SetMaxHealth( BOSS_HP [ diff + 1 ] );
	
    unit:SetHealth( BOSS_HP [ diff + 1 ] );

end

function OnCombat( unit, event )

    self[ tostring( unit )] = {
    phase = 1,
    cleave = 13,
    enervating = 13,
    bladetempest = 18
    };

    unit:PlaySoundToSet( SOUND[ 2 ] );

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

    unit:RegisterAIUpdateEvent( 1000 );

end

function OnLeaveCombat( unit, event )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

	--[[ Developer notes: contrary to popular believe, this is the right place
	to remove ai update event since if a creature is dead the ai update will not trigger, so
	one remove ai update event its more than enough. ]]

	unit:RemoveAIUpdateEvent();

end

function OnTargetDied( unit, event )

    local random = math.random( 3, 4 );
    unit:PlaySoundToSet( SOUND[ random ] );
    unit:SendChatMessage( 14, 0, CHAT[ random ] );

end

function OnDeath( unit, event )

    unit:PlaySoundToSet( SOUND[ 6 ] );

    --[[ Developer notes: we dont need to send the chat here since our
    monstersay table will do the job, instance collision checked. ]]

	local firefield = unit:GetGameObjectNearestCoords( 3153.27, 380.47, 86.36, 203005 );

	firefield:SetByte( GAMEOBJECT_BYTES_1, 0, 0 );

    local xerestrasza = unit:GetCreatureNearestCoords( 3155.54, 342.39, 84.60, 40429 );

    if( xerestrasza ~= nil )
    then
        xerestrasza:MoveTo( 3151.236, 379.8733, 86.31996, 0 );
    end
end

function OnAIUpdate( unit, event )

	if( unit:IsCasting() == true) then return; end
	
	if( unit:GetNextTarget() == nil ) then
		unit:WipeThreatList()
		return;
	end

    local vars = self[ tostring( unit ) ];

    vars.cleave = vars.cleave - 1;
    vars.enervating = vars.enervating - 1;
    vars.bladetempest = vars.bladetempest - 1;

    if( vars.cleave <= 0 )
    then
        unit:CastSpellOnTarget( SPELL_CLEAVE, unit:GetMainTank() );
        unit:SendChatMessage( 12, 0, "debug: cleave" );
        vars.cleave = 13;

    elseif( vars.enervating <= 0 )
    then
        unit:CastSpellOnTarget( SPELL_ENERVATING_BRAND, unit:GetRandomPlayer( 0 ) );
        unit:SendChatMessage( 12, 0, "debug: enervating brand" );
        vars.enervating = 13;

    elseif( vars.bladetempest <= 0 )
    then
        unit:FullCastSpell( SPELL_BLADE_TEMPEST );
        unit:SendChatMessage( 12, 0, "debug: blade tempest" );
        vars.bladetempest = 18;
    end
end

RegisterUnitEvent( 39751, 18, OnSpawn );
RegisterUnitEvent( 39751, 1 , OnCombat );
RegisterUnitEvent( 36751, 2 , OnLeaveCombat );
RegisterUnitEvent( 39751, 3 , OnTargetDied );
RegisterUnitEvent( 39751, 4 , OnDeath );
RegisterUnitEvent( 39751, 21, OnAIUpdate );