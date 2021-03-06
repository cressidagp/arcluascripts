--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Halls of Reflection: Captain Marwyn
	Engine: A.L.E
	Credits: Trinity for texts, sound ids, spell ids and timers.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local BOSS_HP = { 539240, 903227 };

local SOUND = {
[ 1 ] = 16734; -- OnEnterCombat
[ 2 ] = 16735; -- OnTargetDied 1
[ 3 ] = 16736; -- OnTargetDied 2
[ 4 ] = 16737; -- OnDeath
[ 5 ] = 16739; -- OnCast: Corrupted Flesh 1
[ 6 ] = 16740; -- OnCast: Corrupted Flesh 2
[ 7 ] = 16741; -- Intro
};

local CHAT = {
[ 1 ] = "Death is all that you will find here!";
[ 2 ] = "I saw the same look in his eyes when he died. Terenas could hardly believe it.";
[ 3 ] = "Choke on your suffering!";
[ 4 ] = "Yes... Run... Run to meet your destiny... Its bitter, cold embrace, awaits you.";
[ 5 ] = "Your flesh shall decay before your very eyes!";
[ 6 ] = "Waste away into nothingness!";
[ 7 ] = "As you wish, my lord.";
};

-- Spells:
SPELL_OBLITERATE              = 72360;
SPELL_WELL_OF_CORRUPTION      = 72362;
SPELL_CORRUPTED_FLESH         = 72363;
SPELL_SHARED_SUFFERING        = 72368;
SPELL_SHARED_SUFFERING_DISPEL = 72373;

local self = getfenv( 1 );

function OnSpawn( unit, event )

    local diff = unit:GetDungeonDifficulty();

    unit:SetMaxHealth( BOSS_HP [ diff + 1 ] );

    unit:SetHealth( BOSS_HP [ diff + 1 ] );

end

function OnCombat( unit, event )

	self[ tostring( unit )] = {

	obliterate = math.random( 8, 13 ),
	well = 12,
	flesh = 20,
	suffering = math.random( 14, 15 )

	};

    unit:PlaySoundToSet( SOUND[ 1 ] );

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

    local random = math.random( 2, 3 );
    unit:PlaySoundToSet( SOUND[ random ] );
    unit:SendChatMessage( 14, 0, CHAT[ random ] );

end

function OnDeath( unit, event )

    unit:PlaySoundToSet( SOUND[ 4 ] );

    --[[ Developer notes: we dont need to send the chat here since our
    monstersay table will do the job, instance collision checked. ]]

end

function OnAIUpdate( unit, event )

	if( unit:IsCasting() == true ) then return; end

	if( unit:GetNextTarget() == nil ) then
		unit:WipeThreatList()
		return;
	end

	local vars = self[ tostring( unit ) ];

	vars.obliterate = vars.obliterate - 1;
	vars.well = vars.well - 1;
	vars.flesh = vars.flesh - 1;
	vars.suffering = vars.suffering - 1;

	if( vars.obliterate <= 0 )
    then
		unit:CastSpellOnTarget( SPELL_OBLITERATE, unit:GetMainTank() );
		vars.obliterate = math.random( 8, 13 );

	elseif( vars.well <= 0 )
	then
		local targeta = unit:GetRandomPlayer( 3 ); -- long range 100
		unit:CastSpellOnTarget( SPELL_WELL_OF_CORRUPTION, targeta );
		vars.well = 13;

	elseif( vars.flesh <= 0 )
	then
		unit:CastSpell( SPELL_CORRUPTED_FLESH );
		vars.flesh = 20;
		local random = math.random( 5, 6 );
		unit:PlaySoundToSet( SOUND[ random ] );
		unit:SendChatMessage( 14, 0, CHAT[ random ] );

	elseif( vars.suffering <= 0 )
	then
		local targetb = unit:GetClosestPlayer(); -- range 0
		unit:CastSpellOnTarget( SPELL_SHARED_SUFFERING, targetb );
		vars.suffering = math.random( 14, 15 );
	end
end

--RegisterUnitEvent( 38113, 18, OnSpawn );
--RegisterUnitEvent( 38113, 1 , OnCombat );
--RegisterUnitEvent( 38113, 2 , OnLeaveCombat );
--RegisterUnitEvent( 38113, 3 , OnTargetDied );
--RegisterUnitEvent( 38113, 4 , OnDeath );
--RegisterUnitEvent( 38113, 21, OnAIUpdate );
