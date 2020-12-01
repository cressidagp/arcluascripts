--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Hall of Reflection: Captain Falric
	Engine: A.L.E
	Credits: Trinity for texts, sound ids and spell ids.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local BOSS_HP = { 377468, 633607 };

local SOUND = {
[ 1 ] = 16710; -- OnCombat
[ 2 ] = 16711; -- OnTargetDied 1
[ 3 ] = 16712; -- OnTargetDied 2
[ 4 ] = 16713; -- OnDeath
[ 5 ] = 16715; -- OnCast: "Impending Despair"
[ 6 ] = 16716; -- OnCast: "Defiling Horror"
[ 7 ] = 16717; -- Intro 1
[ 8 ] = 16714; -- Intro 2
};

local CHAT = {
[ 2 ] = "Sniveling maggot!";
[ 3 ] = "The children of Stratholme fought with more ferocity!";
[ 5 ] = "Despair... so delicious...";
[ 6 ] = "Fear... so exhilarating...";
[ 7 ] = "As you wish, my lord.";
[ 8 ] = "Soldiers of Lordaeron, rise to meet your master's call!";
};

-- Spells:
SPELL_QUIVERING_STRIKE    = 72422;
SPELL_IMPENDING_DESPAIR   = 72426;
SPELL_DEFILING_HORROR     = 72435;
-- SPELL_HOPELESSNESS_1      = 72395;
-- SPELL_HOPELESSNESS_2      = 72396;
-- SPELL_HOPELESSNESS_3      = 72397;

HOPELESSNESS = {
{ 72395, 72390 },
{ 72396, 72391 },
{ 72397, 72393 }
};

local self = getfenv( 1 );

function OnSpawn( unit, event )

    local diff = unit:GetDungeonDifficulty();

    unit:SetMaxHealth( BOSS_HP [ diff + 1 ] );

    unit:SetHealth( BOSS_HP [ diff + 1 ] );

end

function OnCombat( unit, event )

	self[ tostring( unit )] = {

	phase = 1,
	quivering = 23,
	impending = 9,
	defiling = math.random( 21, 39 ),
	hopeless = 0,
	diff = unit:GetDungeonDifficulty()

	};

    unit:PlaySoundToSet( SOUND[ 1 ] );

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

    unit:RegisterAIUpdateEvent( 1000 );
end

function OnDamageTaken( unit, event, attacker, ammount )

	local vars = self[ tostring( unit ) ];

	local hp = unit:GetHealthPct();

	-- local n = unit:GetHealth() - ammount

	if( ( vars.hopeless < 1 and hp < 66 ) or ( vars.hopeless < 2 and hp < 33 ) or ( vars.hopeless < 3 and hp < 10 ) )
	then
		vars.hopeless = vars.hopeless + 1;
		unit:CastSpell( HOPELESSNESS[ vars.hopeless ][ vars.diff + 1 ] );
	end
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

	vars.quivering = vars.quivering - 1;
	vars.impending = vars.impending - 1;
	vars.defiling = vars.defiling - 1;

	if( vars.quivering <= 0 )
    then
		unit:CastSpellOnTarget( SPELL_QUIVERING_STRIKE, unit:GetMainTank() );
		unit:SendChatMessage( 12, 0, "debug: quivering strike" );
		vars.quivering = 10;

	elseif( vars.impending <= 0 )
	then
		unit:CastSpellOnTarget( SPELL_IMPENDING_DESPAIR, unit:GetRandomPlayer( 1 ) ); -- maybe give more range?
		unit:PlaySoundToSet( SOUND[ 5 ] );
		unit:SendChatMessage( 14, 0, CHAT[ 5 ] );
		vars.impending = 13;

	elseif( vars.defiling <= 0 )
	then
		unit:CastSpell( SPELL_DEFILING_HORROR );
		unit:PlaySoundToSet( SOUND[ 6 ] );
		unit:SendChatMessage( 14, 0, CHAT[ 6 ] );
		vars.defiling = math.random( 21, 39 );
	end
end

RegisterUnitEvent( 38112, 18, OnSpawn );
RegisterUnitEvent( 38112, 1 , OnCombat );
RegisterUnitEvent( 38112, 23, OnDamageTaken );
RegisterUnitEvent( 38112, 2 , OnLeaveCombat );
RegisterUnitEvent( 38112, 3 , OnTargetDied );
RegisterUnitEvent( 38112, 4 , OnDeath );
RegisterUnitEvent( 38112, 21, OnAIUpdate );

