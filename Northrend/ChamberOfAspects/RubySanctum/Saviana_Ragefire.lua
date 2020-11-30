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
[ 5 ] = 17531;	-- OnDeath
};

local CHAT = {
[ 1 ] = "Burn in the master's flame!";  -- OnCast: "Conflagration"
[ 2 ] = "%s becomes enraged!";          -- OnEnrage (type 16)
[ 3 ] = "Halion will be pleased.";      -- OnTargetDied 1
[ 4 ] = "As it should be....";          -- OnTargetDied 2
};

-- Spells:
SPELL_CONFLAGRATION         = 74452;	-- need a dummy
SPELL_FLAME_BEACON          = 74453;
SPELL_CONFLAGRATION_2       = 74454;	-- unknown dummy effect
SPELL_ENRAGE                = 78722;
SPELL_FLAME_BREATH          = 74403;

local self = getfenv( 1 );

function OnCombat( unit, event )

	self[ tostring( unit )] = {
	phase = 1,
	flamebreath = 14,
	flamebeacon = 0,
	enrage = 20
	}

	unit:PlaySoundToSet( SOUND[ 1 ] );

    --[[ Developer notes: we dont need to send the chat here since
    our monstersay table will do the job, instance collision checked. ]]

	unit:RegisterAIUpdateEvent( 1000 );

end

function OnTargetDied( unit, event, victim )

	if( victim:IsPlayer() == true )
	then
    	local random = math.random( 3, 4 );
    	unit:PlaySoundToSet( SOUND[ random ] );
    	unit:SendChatMessage( 14, 0, CHAT[ random ] );
	end
end

function OnDeath( unit, event )

		unit:RemoveAIUpdateEvent( 1000 );
		unit:PlaySoundToSet( SOUND[ 5 ] );
end

function OnAIUpdate( unit, event )

	if( unit:IsCasting() == true ) then return; end

	local vars = self[ tostring( unit ) ];

	vars.flamebreath = vars.flamebreath - 1;
	vars.enrage = vars.enrage - 1;

	if( vars.flamebreath <= 0 )
    then
		unit:FullCastSpellOnTarget( SPELL_FLAME_BREATH, unit:GetMainTank() );
		unit:SendChatMessage( 12, 0, "debug: flame breath" );
		vars.flamebreath = 14;

	elseif( vars.enrage <= 0 )
	then
		unit:CastSpell( SPELL_ENRAGE );
		unit:SendChatMessage( 12, 0, "debug: enrage" );
		vars.enrage = 20;
	end
end

RegisterUnitEvent( 39747, 1 , OnCombat );
RegisterUnitEvent( 39747, 3 , OnTargetDied );
RegisterUnitEvent( 39747, 4 , OnDeath );
RegisterUnitEvent( 39747, 21, OnAIUpdate );

