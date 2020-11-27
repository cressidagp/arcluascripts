--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: Halion the Destroyer
	Engine: A.L.E
	Credits: Trinity for texts and sound ids.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

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
[ 6 ] = "Another "hero" falls.";  -- OnTargetDied
[ 7 ] = "Not good enough....";
};

local TEXT = {
[ 1 ] = "Without pressure in both realms, %s begins to regenerate.";  -- Shared (type 41)
[ 2 ] = "Your efforts force %s further out of the physical realm!"; -- (type 41)
[ 3 ] = "Your companions' efforts force %s further into the physical realm!"; -- (type 41)
};

local self = getfenv( 1 );

function OnCombat( unit, event )

    unit:PlaySoundToSet( SOUND[ 2 ] );

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

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

RegisterUnitEvent( 39863, 1 , OnCombat );
RegisterUnitEvent( 39863, 3 , OnTargetDied );
RegisterUnitEvent( 39863, 4 , OnDeath );
