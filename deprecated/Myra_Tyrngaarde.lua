--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Dun Morogh
	Creature: Myra Tyrngaarde (5109)	

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	"Fresh bread, baked this very morning!",
	"Come get yer fresh bread!",
	"Fresh bread for sale!"
	
	esMX locale:

	"¡Pan casero, horneado esta mañana!",
	"!Venga a buscar su pan casero!",
	"!Pan casero a la venta!"

--]]

--local NPC_MYRA_TYRNGAARDE = 5109;

local chat = {
"Fresh bread, baked this very morning!",
"Come get yer fresh bread!",
"Fresh bread for sale!"
};

MYRA_TYRNGAARDE = {}

function MYRA_TYRNGAARDE.OoCRandomChat( unit, event )

	-- on ai update
    if( event == 21 )
    then
	
		if( unit:IsInCombat() == false )
		then
		    unit:SendChatMessage( 12, 7, chat[ math.random( 1, 3 ) ] );
            unit:ModifyAIUpdateEvent( math.random( 40000, 60000 ) );
		end
	
	-- on spawn
    else
		unit:RegisterAIUpdateEvent( math.random( 10000, 15000 ) );
    end
end

RegisterUnitEvent( 5109, 18, MYRA_TYRNGAARDE.OoCRandomChat );
RegisterUnitEvent( 5109, 21, MYRA_TYRNGAARDE.OoCRandomChat );
