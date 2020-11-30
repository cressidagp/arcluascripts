--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Halls of Reflection: Frostworn General
	Engine: A.L.E
	Credits: Trinity for texts, sound ids, spells id and timers.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local SOUND = {
[ 1 ] = 16921; -- OnCombat
[ 2 ] = 16922; -- OnDeath
};

-- No need of chat table here, monstersay events will be enough.

-- Spells:
SPELL_SHIELD_THROWN     = 69222; -- need scripted effect
SPELL_SPIKE             = 69184;
SPELL_CLONE             = 69828; -- need scripted effect
SPELL_GHOST_VISUAL      = 69861; -- need a dummy

local self = getfenv( 1 );

function OnCombat( unit, event )

	self[ tostring( unit )] = {

	phase = 1,
	shield = 5,
	spike = 14,
	clone = 22

	};

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

function OnAIUpdate( unit, event )

	if( unit:IsCasting() == true ) then return; end

	local vars = self[ tostring( unit ) ];

	vars.shield = vars.shield - 1;
	vars.spike = vars.spike - 1;

	if( vars.shield <= 0 )
    then
		unit:CastSpellOnTarget( SPELL_SHIELD_THROWN, unit:GetMainTank() );
		unit:SendChatMessage( 12, 0, "debug: shield thrown" );
		vars.shield = math.random( 8, 12 );

	elseif( vars.spike <= 0 )
	then
		local target = unit:GetRandomPlayer( 1 );
		unit:FullCastSpellAoE( target:GetX(), target:GetY(), target:GetZ(), SPELL_SPIKE );
		unit:SendChatMessage( 12, 0, "debug: spike" );
		vars.spike = math.random( 15, 20 );
	end
end

RegisterUnitEvent( 36723, 1 , OnCombat );
RegisterUnitEvent( 36723, 4 , OnDeath );
RegisterUnitEvent( 36723, 21, OnAIUpdate );