--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest 
	Creature: Innkeeper Farley (295)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:

	[ 1 ] = "Welcome to the Lion's Pride In.  Make yourself at home!";
	[ 2 ] = "So much to do, so much to do!  Where does the time go?";
	[ 3 ] = "If your glass is full may it be again!";

	esMX local:

	[ 1 ] = "¡Bienvenido a la Posada Orgullo del León.  Siéntete como en casa!";
	[ 2 ] = "¡Tanto que hacer, tanto que hacer!  Donde se va el tiempo?";
	[ 3 ] = "¡Si tu copa esta llena puede volver a estarlo!";

--]]

--local EMOTE_ONESHOT_WAVE = 3;

local CHAT = {
[ 1 ] = "Welcome to the Lion's Pride In.  Make yourself at home!";
[ 2 ] = "So much to do, so much to do!  Where does the time go?";
[ 3 ] = "If your glass is full may it be again!";
};

INNKEEPER_FARLEY = {}

function INNKEEPER_FARLEY.DoChat( unit )

	if( unit:IsInCombat() == false )
	then
		local vars = INNKEEPER_FARLEY[ tostring( unit ) ];

		vars.chatTime = vars.chatTime - 1;

		if( vars.chatTime <= 0 )
		then
			unit:SendChatMessage( 12, 7, CHAT[ math.random( 2, 3 ) ] );
			vars.chatTime = math.random( 150, 180 );
		end 
    end
end

function INNKEEPER_FARLEY.OnSpawnOnAIUpdate( unit, event )

	-- on ai update
    if( event == 21 )
    then
        local target = unit:GetClosestPlayer();

        if (target ~= nil )
        then
            if( unit:IsHostile( target ) == false and unit:GetDistanceYards( target ) < 20 )
            then
                unit:SendChatMessage( 12, 7, CHAT[ 1 ] );
                unit:Emote( 3, 0 );
                unit:ModifyAIUpdateEvent( 40000 );
            end
        end
	
	-- on spawn
    else
        local sUnit = tostring( unit );

        INNKEEPER_FARLEY[ sUnit ] = {
		
		chatTime = math.random( 1, 15 );
		
		};

        unit:RegisterAIUpdateEvent( 1000 );

        unit:RegisterEvent( INNKEEPER_FARLEY.DoChat, 1000, 0 );
	end
end

RegisterUnitEvent( 295, 18, INNKEEPER_FARLEY.OnSpawnOnAIUpdate );
RegisterUnitEvent( 295, 21, INNKEEPER_FARLEY.OnSpawnOnAIUpdate );
