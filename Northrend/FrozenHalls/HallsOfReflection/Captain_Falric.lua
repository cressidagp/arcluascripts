--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Hall of Reflection: Captain Falric
	Engine: A.L.E
	Credits: Trinity for texts, sound ids and spell ids.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

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
SPELL_HOPELESSNESS_1      = 72395;
SPELL_HOPELESSNESS_2      = 72396;
SPELL_HOPELESSNESS_3      = 72397;

local self = getfenv( 1 );

function OnCombat( unit, event )

    unit:PlaySoundToSet( SOUND[ 1 ] );

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

    unit:RegisterAIUpdateEvent( 1000 );
end

function OnTargetDied( unit, event )

    local random = math.random( 2, 3 );
    unit:PlaySoundToSet( SOUND[ random ] );
    unit:SendChatMessage( 14, 0, CHAT[ random ] );

end

function OnDeath( unit, event )

	unit:RemoveAIUpdateEvent( 1000 );
    unit:PlaySoundToSet( SOUND[ 4 ] );

    --[[ Developer notes: we dont need to send the chat here since our
    monstersay table will do the job, instance collision checked. ]]

end

function OnAIUpdate( unit, event )

end

RegisterUnitEvent( 38112, 1 , OnCombat );
RegisterUnitEvent( 38112, 3 , OnTargetDied );
RegisterUnitEvent( 38112, 4 , OnDeath );
RegisterUnitEvent( 38112, 21, OnAIUpdate );
