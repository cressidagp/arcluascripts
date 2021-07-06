--[[ 
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest
	Creature: Supervisor Raelen

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	"We have yet to meet our quota for the wood demand. Now back to work with you.",
	"Daylight is still upon us so let's see that axe of yours chopping some more wood.",
	"We need to get this wagon filled by the end of the day. So back to work with you. Chop, chop!"
	
	esMX locale:

	"We have yet to meet our quota for the wood demand. Ahora regresen a trabajar.",
	"Daylight is still upon us so let's see that axe of yours chopping some more wood.",
	"Necesitamos llenar este vagon para el final del día. Asique vuelta al trabajo. Corten, corten!"
	
--]]

--local NPC_SUPERVISOR_RAELEN = 10616;
--local NPC_EASTVALE_PEASANT = 11328;

local chat = {
"We have yet to meet our quota for the wood demand. Now back to work with you.",
"Daylight is still upon us so let's see that axe of yours chopping some more wood.",
"We need to get this wagon filled by the end of the day. So back to work with you. Chop, chop!"
};

local emote = { 25, 1, 5 };

SUPERVISOR_RAELEN = {};

function SUPERVISOR_RAELEN.OnRangePeasant( unit )

    if( unit:IsInCombat() == true or unit:IsDead() == true )
    then return; end

    for k, v in pairs( unit:GetInRangeUnits() ) do
        if( v:GetEntry() == 11328 and unit:GetDistanceYards( v ) <= 1*10 )
        then
                local i = math.random( 1, 3 );
                unit:SendChatMessage( 12, 7, chat[ i ] );
                unit:Emote( emote[ i ], 0 );
                break;
        end
    end
end

function SUPERVISOR_RAELEN.OnSpawn( unit )

    unit:RegisterEvent( SUPERVISOR_RAELEN.OnRangePeasant, 20000, 0 );
	
end

RegisterUnitEvent( 10616, 18, SUPERVISOR_RAELEN.OnSpawn );