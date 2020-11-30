--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Halls of Reflection: Frostworn General
	Engine: A.L.E
	Credits: Trinity for texts and sound ids.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local SOUND = {
[ 1 ] = 16921; -- OnCombat
[ 2 ] = 16922; -- OnDeath
};

-- Spells:
SPELL_SHIELD_THROWN     = 69222;
SPELL_SPIKE             = 69184;
SPELL_CLONE             = 69828;
SPELL_GHOST_VISUAL      = 69861;
SPELL_BALEFUL_STRIKE    = 69933;
SPELL_SPIRIT_BURST      = 69900;

local self = getfenv( 1 );

function OnCombat( unit, event )

    unit:PlaySoundToSet( SOUND[ 1 ] );

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

    unit:RegisterAIUpdateEvent( 1000 );
end

function OnDeath( unit, event )

	unit:RemoveAIUpdateEvent();
    unit:PlaySoundToSet( SOUND[ 2 ] );

    --[[ Developer notes: we dont need to send the chat here since our
    monstersay table will do the job, instance collision checked. ]]

end

RegisterUnitEvent( 36723, 1 , OnCombat );
RegisterUnitEvent( 36723, 4 , OnDeath );
