--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Durotar
	Creature: Gazzuz

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPC_GAZZUZ = 3204;
--local SPELL_DEMON_SKIN = 20798;

GAZZUZ = {}

function GAZZUZ.OoCCastBuff( unit, event )

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

RegisterUnitEvent( 3204, 18, GAZZUZ.OoCCastBuff );
RegisterUnitEvent( 3204, 21, GAZZUZ.OoCCastBuff );
