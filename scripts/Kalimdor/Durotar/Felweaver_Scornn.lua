--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Durotar
	Creature: Felweaver Scornn (5822)

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPC_FELWEAVER_SCORN = 5822;
--local SPELL_DEMON_SKIN = 20798;

FELWEAVER_SCORNN = {}

function FELWEAVER_SCORNN.OoCCastBuff( unit, event )

    if( event == 21 )
    then
	    if( unit:IsInCombat() == false and unit:HasAura( 20798 ) == false )
        then
            unit:FullCastSpell( 20798 );
            unit:ModifyAIUpdateEvent( 1800000 );
		end
	
	else
	
        local n = math.random( 3, 5 );
        unit:RegisterAIUpdateEvent( n * 1000 );
    end	
end

RegisterUnitEvent( 5822, 18, FELWEAVER_SCORNN.OoCCastBuff );
RegisterUnitEvent( 5822, 21, FELWEAVER_SCORNN.OoCCastBuff );
