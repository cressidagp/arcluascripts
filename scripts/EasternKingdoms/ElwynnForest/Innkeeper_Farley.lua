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

	[ 1 ] = "Welcome to the Lion's Pride In.  Make yourself at home!",
	[ 2 ] = "So much to do, so much to do!  Where does the time go?",
	[ 3 ] = "If your glass is full may it be again!"

	esMX local:

	[ 1 ] = "¡Bienvenido a la Posada Orgullo del León.  Siéntete como en casa!",
	[ 2 ] = "¡Tanto que hacer, tanto que hacer!  ¿Donde se va el tiempo?",
	[ 3 ] = "¡Si tu copa esta llena puede volver a estarlo!"

--]]

--local NPC_INNKEEPER_FARLEY = 295;
--local EMOTE_ONESHOT_WAVE = 3;
--local UNIT_FIELD_TARGET = 0x0006 + 0x000C;

local chat = {
[ 1 ] = "Welcome to the Lion's Pride In.  Make yourself at home!",
[ 2 ] = "So much to do, so much to do!  Where does the time go?",
[ 3 ] = "If your glass is full may it be again!"
};

INNKEEPER_FARLEY = {}

function INNKEEPER_FARLEY.OnSpawnOnAIUpdate( unit, event )

	local sUnit = tostring( unit )

	-- on ai update
    if( event == 21 )
    then
		
		if( unit:IsInCombat() == true ) then return; end
		
		local vars = INNKEEPER_FARLEY[ sUnit ];
		
		vars.welcomeTime = vars.welcomeTime - 1;
		vars.randomChatTime = vars.randomChatTime - 1;
		
		unit:SetUInt64Value( 0x0006 + 0x000C, 0 );
		
		if( vars.welcomeTime <= 0 )
		then
		
			local target = unit:GetClosestPlayer();

			if (target ~= nil )
			then
				if( unit:IsHostile( target ) == false and unit:GetDistanceYards( target ) < 20 )
				then
					unit:SetUInt64Value( 0x0006 + 0x000C, target:GetGUID() );
					unit:SendChatMessage( 12, 7, chat[ 1 ] );
					unit:Emote( 3, 0 );
					vars.welcomeTime = 40;
				end
			end
		
		elseif( vars.randomChatTime <= 0 )
		then
			unit:SendChatMessage( 12, 7, chat[ math.random( 2, 3 ) ] );
			vars.randomChatTime = math.random( 150, 180 );
		end
	
	-- on spawn
    else

        INNKEEPER_FARLEY[ sUnit ] = {
		
		welcomeTime = 1,
		randomChatTime = math.random( 1, 15 ),
		
		};

        unit:RegisterAIUpdateEvent( 1000 );
	end
end

RegisterUnitEvent( 295, 18, INNKEEPER_FARLEY.OnSpawnOnAIUpdate );
RegisterUnitEvent( 295, 21, INNKEEPER_FARLEY.OnSpawnOnAIUpdate );
