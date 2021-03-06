--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: Baltharus the Warborn
	Engine: A.L.E
	Credits: Trinity for texts, sound ids, timers and spells.

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

local CHAT = {
[ 1 ] = "Your power wanes, ancient one.... Soon you will join your friends."; -- Intro
[ 2 ] = "Baltharus leaves no survivors!";	-- OnTargetDied 1
[ 3 ] = "This world has enough heroes.";	-- OnTargetDied 2
[ 4 ] = "Twice the pain and half the fun.";	-- OnClone
};

-- Spells:
local SPELL_BARRIER_CHANNEL       = 76221; -- TODO: need a dummy
local SPELL_ENERVATING_BRAND      = 74502; -- need spell script
local SPELL_ENERVATING_BRAND_2	  = 74505; -- TODO: WTF?
local SPELL_SIPHONED_MIGHT        = 74507;
local SPELL_CLEAVE                = 40504;
local SPELL_BLADE_TEMPEST         = 75125;
local SPELL_CLONE                 = 74511;
local SPELL_REPELLING_WAVE        = 74509;
local SPELL_CLEAR_DEBUFFS         = 34098;
local SPELL_SPAWN_EFFECT          = 64195;

-- For 3.3.5a
local GAMEOBJECT_BYTES_1	= 0x0006 + 0x000B;

local self = getfenv( 1 );

function OnSpawn( unit, event )

	local diff = unit:GetDungeonDifficulty();

	unit:SetMaxHealth( BOSS_HP [ diff + 1 ] );

	unit:SetHealth( BOSS_HP [ diff + 1 ] );


	local crystal = unit:GetCreatureNearestCoords( 3154.34, 366.58, 89.20, 26712 );

	unit:ChannelSpell( SPELL_BARRIER_CHANNEL, crystal );


	unit:PlaySoundToSet( SOUND[ 1 ] );

	unit:SendChatMessage( 14, 0, CHAT[ 1 ] );

end

function OnCombat( unit )

    self[ tostring( unit )] = {

    phase = 1,
	diff = unit:GetDungeonDifficulty() + 1,
    cleave = 13,
    enervatingBrand = 13,
    bladeTempest = 18,
	sharedHealth = 0,
	cloneCount = 0

    };

	unit:StopChannel();

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

	unit:PlaySoundToSet( SOUND[ 2 ] );

    unit:RegisterAIUpdateEvent( 1000 );

end

function OnDamageTaken( unit, event, attacker, ammount )

	local vars = self[ tostring( unit ) ];

	local hp = unit:GetHealthPct();

	if( unit:GetDungeonDifficulty() == 0 )
	then
		if( hp < 50 and vars.cloneCount == 0 )
		then
			vars.cloneCount = vars.cloneCount + 1;
			unit:CastSpell( SPELL_CLEAR_DEBUFFS );
			unit:CastSpell( SPELL_CLONE );
			unit:CastSpell( SPELL_REPELLING_WAVE );
			unit:PlaySoundToSet( SOUND[ 5 ] );
			unit:SendChatMessage( 14, 0, CHAT[ 5 - 1 ] );

		end
	else
		if( hp < 66 and vars.cloneCount == 0 )
		then
			vars.cloneCount = vars.cloneCount + 1;
			unit:CastSpell( SPELL_CLEAR_DEBUFFS );
			unit:CastSpell( SPELL_CLONE );
			unit:CastSpell( SPELL_REPELLING_WAVE );
			unit:PlaySoundToSet( SOUND[ 5 ] );
			unit:SendChatMessage( 14, 0, CHAT[ 5 - 1 ] );

		elseif( hp < 33 and vars.cloneCount == 1 )
		then
			vars.cloneCount = vars.cloneCount + 1;
			unit:CastSpell( SPELL_CLEAR_DEBUFFS );
			unit:CastSpell( SPELL_CLONE );
			unit:CastSpell( SPELL_REPELLING_WAVE );
			unit:PlaySoundToSet( SOUND[ 5 ] );
			unit:SendChatMessage( 14, 0, CHAT[ 5 - 1 ] );
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
    	local random = math.random( 3, 4 );
    	unit:PlaySoundToSet( SOUND[ random - 1 ] );
    	unit:SendChatMessage( 14, 0, CHAT[ random - 1 ] );
	end
end

function OnDeath( unit )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

    --[[ Developer notes: we dont need to send the chat here since our
    monstersay table will do the job, instance collision checked. ]]

	unit:PlaySoundToSet( SOUND[ 6 ] );

	local firefield = unit:GetGameObjectNearestCoords( 3153.27, 380.47, 86.36, 203005 );

	firefield:SetByte( GAMEOBJECT_BYTES_1, 0, 0 );

    local xerestrasza = unit:GetCreatureNearestCoords( 3155.54, 342.39, 84.60, 40429 );

    if( xerestrasza ~= nil )
    then
        xerestrasza:MoveTo( 3151.236, 379.8733, 86.31996, 0 );
    end
end

function OnAIUpdate( unit )

	if( unit:IsCasting() == true) then return; end

	if( unit:GetNextTarget() == nil ) then
			unit:WipeThreatList()
			return;
	end

	local vars = self[ tostring( unit ) ];

	vars.cleave = vars.cleave - 1;
	vars.enervatingBrand = vars.enervatingBrand - 1;
	vars.bladeTempest = vars.bladeTempest - 1;

	if( vars.cleave <= 0 )
	then
		unit:Unroot();
		unit:CastSpellOnTarget( SPELL_CLEAVE, unit:GetMainTank() );
		unit:SendChatMessage( 12, 0, "debug: cleave" );
		vars.cleave = math.random( 20, 24 );

	elseif( vars.enervatingBrand <= 0 )
	then
		unit:Unroot();
		local raidMode = { 2, 4, 2, 4 };
		local targetNum = raidMode[ vars.diff ];

		for i = 1, targetNum  -- targetNum its the "for" limiter
		do
			unit:CastSpellOnTarget( SPELL_ENERVATING_BRAND, unit:GetRandomPlayer( 2 ) ); -- range 45
		end

		unit:SendChatMessage( 12, 0, "debug: enervating brand" );
		vars.enervatingBrand = 26;

	elseif( vars.bladeTempest <= 0 )
	then
		unit:Root();
		unit:FullCastSpell( SPELL_BLADE_TEMPEST );
		vars.bladeTempest = 24;
	end
end

--RegisterUnitEvent( 39751, 18, OnSpawn );
--RegisterUnitEvent( 39751, 1 , OnCombat );
--RegisterUnitEvent( 39751, 23, OnDamageTaken );
--RegisterUnitEvent( 36751, 2 , OnLeaveCombat );
--RegisterUnitEvent( 39751, 3 , OnTargetDied );
--RegisterUnitEvent( 39751, 4 , OnDeath );
--RegisterUnitEvent( 39751, 21, OnAIUpdate );

--[[
			Clone AI
--]]

function CloneOnSpawn( unit )

	unit:CastSpell( SPELL_SPAWN_EFFECT );

end

function CloneOnCombat( unit )

	self[ tostring( unit ) ] = {

	cleave = 11,
	enervatingBrand = 15,
	bladeTempest = 10

	};

	unit:RegisterAIUpdateEvent( 1000 );

end

function OnDamageTaken( unit, event, attacker, damage )

	local baltharus = unit:GetCreator();

	local vars = self[ tostring( baltharus ) ];

	local hp = unit:GetHealth();

	if( hp > damage )
	then
		vars.sharedHealth = hp - damage;
	end
end

function CloneOnLeaveCombat( unit )

	-- destroy table with variables to recycle resources

	self[ tostring( unit ) ] = nil;

	--[[ Developer notes: contrary to popular believe, this is the right place
	to remove ai update event since if a creature is dead the ai update will not trigger, so
	one remove ai update event its more than enough. ]]

	unit:RemoveAIUpdateEvent();

end

function CloneOnAIUpdate( unit )

	if( unit:IsCasting() == true) then return; end

	if( unit:GetNextTarget() == nil ) then
		unit:WipeThreatList()
		return;
	end

	local baltharus = unit:GetCreator();

	local args = self[ tostring( baltharus ) ];

	unit:SetHealth( args.sharedHealth );

	local vars = self[ tostring( unit ) ];

	vars.cleave = vars.cleave - 1;
	vars.enervatingBrand = vars.enervatingBrand - 1;
	vars.bladeTempest = vars.bladeTempest - 1;

	if( vars.cleave <= 0 )
	then
		unit:Unroot();
		unit:CastSpellOnTarget( SPELL_CLEAVE, unit:GetMainTank() );
		unit:SendChatMessage( 12, 0, "debug: clone cleave" );
		vars.cleave = math.random( 20, 24 );

	elseif( vars.enervatingBrand <= 0 )
	then
		unit:Unroot();
		local raidMode = { 2, 4, 2, 4 };
		local targetNum = raidMode[ args.diff ];

		for i = 1, targetNum -- targetNum its the "for" limiter
		do
			unit:CastSpellOnTarget( SPELL_ENERVATING_BRAND, unit:GetRandomPlayer( 2 ) ); -- range 45
		end

		unit:SendChatMessage( 12, 0, "debug: clone enervating brand" );
		vars.enervatingBrand = 26;

	elseif( vars.bladeTempest <= 0 )
	then
		unit:Root();
		unit:FullCastSpell( SPELL_BLADE_TEMPEST );
		vars.bladeTempest = 24;
	end
end

--RegisterUnitEvent( 39899, 18, CloneOnSpawn );
--RegisterUnitEvent( 39899, 1 , CloneOnCombat );
--RegisterUnitEvent( 39899, 23, CloneOnDamageTaken );
--RegisterUnitEvent( 39899, 2 , CloneOnLeaveCombat );
--RegisterUnitEvent( 39899, 21, CloneOnAIUpdate );

--[[
			Spell: Enervating Brand
--]]

function HookOnCastSpell( event, plr, spell_id, spellObject )

	if( spell_id ~= SPELL_ENERVATING_BRAND ) then return; end

	if( spell_id == SPELL_ENERVATING_BRAND )
	then

		local caster = spellObject:GetCaster();

		caster:FullCastSpell( SPELL_SIPHONED_MIGHT );
	end
end

--RegisterServerHook( 10, HookOnCastSpell );
