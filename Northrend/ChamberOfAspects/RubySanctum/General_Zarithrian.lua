--[[
      ArcLuaScripts for ArcEmu
      www.ArcEmu.org
	  The Ruby Sanctum: General Zarithrian
      Engine: A.L.E
      Credits: Trinity for texts and sound ids.

      Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local SOUND = {
[ 1 ] = 17512;  -- OnCombat
[ 2 ] = 17513;  -- OnTargetDied 1
[ 3 ] = 17514;  -- OnTargetDied 2
[ 4 ] = 17516;  -- Minions
[ 5 ] = 17515;  -- OnDeath
};

local CHAT = {
[ 2 ] = "You thought you stood a chance?";  -- OnTargetDied 1
[ 3 ] = "It's for the best.";               -- OnTargetDied 2
[ 4 ] = "Turn them to ash, minions!";       -- OnDeath
};

local self = getfenv( 1 );

function OnCombat( unit, event )

    unit:PlaySoundToSet( SOUND[ 1 ] );

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

end

function OnTargetDied( unit, event )

    local random = math.random( 2, 3 );
    unit:PlaySoundToSet( SOUND[ random ] );
    unit:SendChatMessage( 14, 0, CHAT[ random ] );

end

function OnDeath( unit, event )

    unit:PlaySoundToSet( SOUND[ 5 ] );

    --[[ Developer notes: we dont need to send the chat here since our
    monstersay table will do the job, instance collision checked. ]]

end

RegisterUnitEvent( 39746, 1 , OnCombat );
RegisterUnitEvent( 39746, 3 , OnTargetDied );
RegisterUnitEvent( 39746, 4 , OnDeath );
