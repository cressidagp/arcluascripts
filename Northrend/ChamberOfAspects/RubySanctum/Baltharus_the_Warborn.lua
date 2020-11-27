--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: Baltharus the Warborn
	Engine: A.L.E
	Credits: Trinity for texts and sound ids.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

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

local self = getfenv( 1 );

function OnCombat( unit, event )

    unit:PlaySoundToSet( SOUND[ 2 ] );

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

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

end

RegisterUnitEvent( 39751, 1 , OnCombat );
RegisterUnitEvent( 39751, 3 , OnTargetDied );
RegisterUnitEvent( 39751, 4 , OnDeath );
