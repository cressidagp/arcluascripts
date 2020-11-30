--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum: General Zarithrian
	Engine: A.L.E
	Credits: Trinity for texts, sound ids, timers and spell ids.

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

-- Spells:
SPELL_INTIMIDATING_ROAR     = 74384;
SPELL_CLEAVE_ARMOR          = 74367;

local self = getfenv( 1 );

function OnCombat( unit, event )

	self[ tostring( unit )] = {
	phase = 1,
	cleave = 8,
	roar = 14
	}

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
    unit:PlaySoundToSet( SOUND[ 5 ] );

    --[[ Developer notes: we dont need to send the chat here since our
    monstersay table will do the job, instance collision checked. ]]

end

function OnAIUpdate( unit, event )

	if( unit:IsCasting() == true ) then return; end

	local vars = self[ tostring( unit ) ];

	vars.cleave = vars.cleave - 1;
	vars.roar = vars.roar - 1;

	if( vars.cleave <= 0 )
    then
		unit:CastSpellOnTarget( SPELL_CLEAVE_ARMOR, unit:GetMainTank() );
		unit:SendChatMessage( 12, 0, "debug: cleave" );
		vars.cleave = 8;

	elseif( vars.roar <= 0 )
	then
		unit:FullCastSpell( SPELL_INTIMIDATING_ROAR );
		unit:SendChatMessage( 12, 0, "debug: roar" );
		vars.roar = 14;
	end
end

RegisterUnitEvent( 39746, 1 , OnCombat );
RegisterUnitEvent( 39746, 3 , OnTargetDied );
RegisterUnitEvent( 39746, 4 , OnDeath );
RegisterUnitEvent( 39746, 21, OnAIUpdate );