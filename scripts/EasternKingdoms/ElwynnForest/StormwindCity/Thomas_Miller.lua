--[[ 
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Stormwind City
	Creature: Thomas Miller

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:
	
	[ 1 ] = "Fresh bread for sale!",
	[ 2 ] = "Freshly baked bread for sale!",
	[ 3 ] = "Rolls, buns and bread. Baked fresh!",
	[ 4 ] = "Warm, wholesome bread!"
	
	esMX locale:
	
	[ 1 ] = "¡Pan casero a la venta!",
	[ 2 ] = "¡Pan recién horneado para la venta!",
	[ 3 ] = "¡Panecillos, criollos y pan. Recién horneados!",
	[ 4 ] = "¡Calentito, saludable pan!"	

--]]

--NPC_THOMAS_MILLER = 3518;

local chat = {
[ 1 ] = "Fresh bread for sale!",
[ 2 ] = "Freshly baked bread for sale!",
[ 3 ] = "Rolls, buns and bread. Baked fresh!",
[ 4 ] = "Warm, wholesome bread!"
};

THOMAS_MILLER = {}

function THOMAS_MILLER.OnReachWP( unit, _, waypointId )

    if( waypointId == 2 or waypointId == 23 )
    then
	    unit:SendChatMessage( 12, 7, chat[math.random( 1, 4 )] );
        unit:EventChat( 12, 7, chat[math.random( 1, 4 )], 4000 );
    end
end

RegisterUnitEvent( 3518, 19, THOMAS_MILLER.OnReachWP );
