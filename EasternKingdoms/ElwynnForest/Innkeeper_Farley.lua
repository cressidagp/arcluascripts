--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Elwynn Forest: Innkeeper Farley
	Engine: A.L.E
	Credits: to Trinity for creature texts and timers.

	enUS:

	[ 1 ] = "Welcome to the Lion's Pride In.  Make yourself at home!";
	[ 2 ] = "So much to do, so much to do!  Where does the time go?";
	[ 3 ] = "If your glass is full may it be again!";

	esMX:

	[ 1 ] = "Bienvenido a la Posada Orgullo del León.  Siéntete como en casa!";
	[ 2 ] = "Tanto que hacer, tanto que hacer!  Donde se va el tiempo?";
	[ 3 ] = "Si tu copa esta llena puede volver a estarlo!";

--]]

local EMOTE_ONESHOT_WAVE = 3;

local CHAT = {
[ 1 ] = "Welcome to the Lion's Pride In.  Make yourself at home!";
[ 2 ] = "So much to do, so much to do!  Where does the time go?";
[ 3 ] = "If your glass is full may it be again!";
};

INN_FARLEY = {}

function INN_FARLEY.DoChat( unit )

    local args = INN_FARLEY[ tostring( unit ) ];

    args.chat = args.chat - 1;

    if( args.chat <= 0 )

    then

        unit:SendChatMessage( 12, 7, CHAT[ math.random( 2, 3 ) ] );

        args.chat = math.random( 150, 180 );

    end

end

function INN_FARLEY.OnSpawnOnAIUpdate( unit, event )

    if( event == 18 )

    then

        local sUnit = tostring( unit )

        INN_FARLEY[ sUnit ] = {}

        local ref = INN_FARLEY[ sUnit ]

        ref.chat = math.random( 1, 15 );

        unit:RegisterAIUpdateEvent( 1000 );

        unit:RegisterEvent( INN_FARLEY.DoChat, 1000, 0 );

    elseif( event == 21 )

    then

        local target = unit:GetClosestPlayer();

        if (target ~= nil )

        then

            if( unit:IsHostile( target ) == false and unit:GetDistanceYards( target ) < 20 )

            then

                unit:SendChatMessage( 12, 7, CHAT[ 1 ] );

                unit:Emote( EMOTE_ONESHOT_WAVE, 0 );

                unit:ModifyAIUpdateEvent( 40000 );

            end

        end

    end

end

RegisterUnitEvent( 295, 18, INN_FARLEY.OnSpawnOnAIUpdate );

RegisterUnitEvent( 295, 21, INN_FARLEY.OnSpawnOnAIUpdate );
