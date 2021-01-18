--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest
	Creature: Kira Songshine (3937)	

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	[ 1 ] = "Fresh bread, baked this very morning!";
	[ 2 ] = "Come get yer fresh bread!";
	[ 3 ] = "Fresh bread for sale!";
	
	esMX locale:

	[ 1 ] = "Pan casero, horneado esta mañana!";
	[ 2 ] = "Venga a buscar su pan casero!";
	[ 3 ] = "Pan casero a la venta!";

--]]

local CHAT = {
[ 1 ] = "Fresh bread, baked this very morning!";
[ 2 ] = "Come get yer fresh bread!";
[ 3 ] = "Fresh bread for sale!";
};

KIRA_SONGSHINE = {}

function KIRA_SONGSHINE.OoCRandomChat( unit, event )

	-- on ai update
	if( event == 21 )
	then
        if( unit:IsInCombat() == false )
        then
            unit:SendChatMessage( 12, 7, CHAT[ math.random( 1, 3 ) ] );
            unit:ModifyAIUpdateEvent( math.random( 30000, 45000 ) );
        end
		
	-- on spawn
	else
        unit:RegisterAIUpdateEvent( math.random( 5000, 10000 ) );
	end
end

RegisterUnitEvent( 3937, 18, KIRA_SONGSHINE.OoCRandomChat );
RegisterUnitEvent( 3937, 21, KIRA_SONGSHINE.OoCRandomChat );