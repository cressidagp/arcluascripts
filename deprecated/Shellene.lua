--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Stormwind City 
	Creature: Shellene
	
	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:
	
	[ 1 ] = "It's so sad for you poor children.",
	[ 2 ] = "Now children stop that!  I mean it!",
	[ 3 ] = "All will be well children.  The Light shall see to that!",
	[ 4 ] = "I believe you children are our future..."
	
	esMX locale:

	[ 1 ] = "Es tan triste para mis pobres niños.",
	[ 2 ] = "Ya basta niños!  Lo digo enserio!",
	[ 3 ] = "Todo estara bien niños.  La Luz se encargara de ello!",
	[ 4 ] = "Yo creo que los niños son el futuro..."

--]]

--NPC_SHELLENE = 14497;

local chat = {
[ 1 ] = "Es tan triste para mis pobres niños.",
[ 2 ] = "Ya basta niños!  Lo digo enserio!",
[ 3 ] = "Todo estara bien niños.  La Luz se encargara de ello!",
[ 4 ] = "Yo creo que los niños son el futuro..."
};

SHELLENE = {}

function SHELLENE.OoCRandomChat( unit, event )

    if( event == 21 )
    then
        if( unit:IsInCombat() == false )
        then
            unit:SendChatMessage( 12, 7, chat[ math.random( 1, 4 ) ] );
            unit:ModifyAIUpdateEvent( math.random( 150000, 180000 ) );	
		end
	
	else
	
        unit:RegisterAIUpdateEvent( math.random( 1000, 15000 ) );
    end
end

RegisterUnitEvent( 14497, 18, SHELLENE.OoCRandomChat );
RegisterUnitEvent( 14497, 21, SHELLENE.OoCRandomChat );
