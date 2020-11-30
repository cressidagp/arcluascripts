--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Halls of Reflection: Captain Marwyn
	Engine: A.L.E
	Credits: Trinity for texts and sound ids.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

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

	unit:RemoveAIUpdateEvent();
    unit:PlaySoundToSet( SOUND[ 4 ] );

    --[[ Developer notes: we dont need to send the chat here since our
    monstersay table will do the job, instance collision checked. ]]

end

function OnAIUpdate( unit, event )

end

RegisterUnitEvent( 38113, 1 , OnCombat );
RegisterUnitEvent( 38113, 3 , OnTargetDied );
RegisterUnitEvent( 38113, 4 , OnDeath );
RegisterUnitEvent( 38113, 21, OnAIUpdate );
