--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Dun Morogh
	Creature: John Turner (6175)	

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	"Don't forget the orphans of Stormwind!",
	"Help the children of Stormwind... victims of the war and plague!",
	"Give of your hearts and your purses! Give to the children of Stormwind who have lost their parents.",
	"Give to the charities who seek to help the victims of these hard times! Please."
	
	esMX locale:

	"¡No te olvides de los huerfanos de Stormwind!",
	"¡Ayuda a los niños de Stormwind... Victimas de la guerra y la plaga!" ,
	"¡Entrega tu corazón y tu cartera! Dad a los niños de Stormwind quienes perdieron a sus parientes.",
	"¡Caridad con aquellos que buscan ayudar a las victimas de estos tiempos dificiles! Por favor."

--]]

--local NPC_JOHN_TURNER = 6175;

local chat = {
"¡Don't forget the orphans of Stormwind!",
"Help the children of Stormwind... victims of the war and plague!",
"Give of your hearts and your purses! Give to the children of Stormwind who have lost their parents.",
"Give to the charities who seek to help the victims of these hard times! Please."
};

JOHN_TURNER = {}

function JOHN_TURNER.OoCRandomChat( unit, event )

	-- on ai update
    if( event == 21 )
    then
		if( unit:IsInCombat() == false )
		then
			unit:SendChatMessage( 12, 7, chat[math.random( 1, 4 ) ] );
			unit:ModifyAIUpdateEvent( math.random( 120000, 135000 ) );
		end
		
	-- on spawn
    else
        unit:RegisterAIUpdateEvent( math.random( 5000, 12000 ) );
    end
end

RegisterUnitEvent( 6175, 18, JOHN_TURNER.OoCRandomChat );
RegisterUnitEvent( 6175, 21, JOHN_TURNER.OoCRandomChat );