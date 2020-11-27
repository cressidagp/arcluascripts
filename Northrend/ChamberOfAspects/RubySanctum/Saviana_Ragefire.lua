--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: Saviana Ragefire
	Engine: A.L.E
	Credits: Trinity for texts and sound ids.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local SOUND = {
[ 1 ] = 17528;  -- OnCombat
[ 2 ] = 17532;  -- OnCast: "Conflagration"
[ 3 ] = 17530;  -- OnTargetDied 1
[ 4 ] = 17529;  -- OnTargetDied 2
};

local CHAT = {
[ 1 ] = "Burn in the master's flame!";  -- OnCast: "Conflagration"
[ 2 ] = "%s becomes enraged!";          -- OnEnrage (type 16)
[ 3 ] = "Halion will be pleased.";      -- OnTargetDied 1
[ 4 ] = "As it should be....";          -- OnTargetDied 2
};

local self = getfenv( 1 );

function OnCombat( unit, event )

    unit:PlaySoundToSet( SOUND[ 1 ] );

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

end

function OnTargetDied( unit, event )

    local random = math.random( 3, 4 );
    unit:PlaySoundToSet( SOUND[ random ] );
    unit:SendChatMessage( 14, 0, CHAT[ random ] );

end

RegisterUnitEvent( 39747, 1 , OnCombat );
RegisterUnitEvent( 39747, 3 , OnTargetDied );
