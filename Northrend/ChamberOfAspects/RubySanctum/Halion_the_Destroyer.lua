--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: Halion the Destroyer
	Engine: A.L.E
	Credits: Trinity for texts and sound ids.

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
[ 3 ] = "The heavens burn!";  -- OnMeterStrike
[ 4 ] = "You will find only suffering within the realm of twilight! Enter if you dare!";  -- OnPhaseTwo
[ 6 ] = "Another hero falls.";  -- OnTargetDied (shoud be "hero", but "" caused problems)
[ 7 ] = "Not good enough....";
};

local TEXT = {
[ 1 ] = "Without pressure in both realms, %s begins to regenerate.";  -- Shared (type 41)
[ 2 ] = "Your efforts force %s further out of the physical realm!"; -- (type 41)
[ 3 ] = "Your companions' efforts force %s further into the physical realm!"; -- (type 41)
};

-- Spells:
SPELL_FLAME_BREATH 		= 74525;
SPELL_CLEAVE 			= 74524;
SPELL_METEOR_STRIKE 	= 74637; -- aoe, need a dummy
SPELL_TAIL_LASH 		= 74531;

local self = getfenv( 1 );

function OnSpawn( unit, event )

    local diff = unit:GetDungeonDifficulty();
	
    unit:SetMaxHealth( BOSS_HP [ diff + 1 ] );
	
    unit:SetHealth( BOSS_HP [ diff + 1 ] );

end

function OnCombat( unit, event )

		self[ tostring( unit )] = {

		phase = 1,
		flamebreath = math.random( 5, 15 ),
		cleave = math.random( 6, 10 ),
		tail = math.random( 7, 12 ),
		fierycombustion = math.random( 15, 18 ),
		meteorstrike = 18

		};

    unit:PlaySoundToSet( SOUND[ 2 ] );

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

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

    unit:PlaySoundToSet( SOUND[ 6 ] );
    unit:SendChatMessage( 14, 0, CHAT[ 6 ] );

end

function OnDeath( unit, event )

    unit:PlaySoundToSet( SOUND[ 5 ] );

    --[[ Developer notes: we dont need to send the chat here since our
    monstersay table will do the job, instance collision checked. ]]

end

function OnAIUpdate( unit, event )

	if( unit:IsCasting() == true ) then return; end

	local vars = self[ tostring( unit ) ];

	vars.flamebreath = vars.flamebreath - 1;
	vars.cleave = vars.cleave - 1;
	vars.tail = vars.tail - 1;

	if( vars.flamebreath <= 0 )
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

function HalionControllerOnSpawn( unit, event )

end

RegisterUnitEvent( 39863, 18, OnSpawn );
RegisterUnitEvent( 39863, 1 , OnCombat );
RegisterUnitEvent( 39863, 2 , OnLeaveCombat );
RegisterUnitEvent( 39863, 3 , OnTargetDied );
RegisterUnitEvent( 39863, 4 , OnDeath );
RegisterUnitEvent( 39863, 21, OnAIUpdate );

RegisterUnitEvent( 40146, 18 , HalionControllerOnSpawn );