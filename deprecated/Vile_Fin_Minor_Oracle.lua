--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Tirisfall Glades
	Creature: Vile Fin Minor Oracle (1544)
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPC_VILE_FIN_MINOR_ORACLE = 1544;
--local SPELL_LIGHTING_SHIELD = 324;

VILE_FIN_MINOR_ORACLE = {}

function VILE_FIN_MINOR_ORACLE.OoCCastBuff( unit, event )

	-- on ai update
    if( event == 21 )
    then
	    if( unit:IsInCombat() == false and unit:HasAura( 324 ) == false )	
        then
            unit:FullCastSpell( 324 );
            unit:ModifyAIUpdateEvent( 600000 );
		end
	
	-- on spawn
	else
	
        local n = math.random( 3, 5 );
        unit:RegisterAIUpdateEvent( n * 1000 );	
    end	
end

RegisterUnitEvent( 1544, 18, VILE_FIN_MINOR_ORACLE.OoCCastBuff );
RegisterUnitEvent( 1544, 21, VILE_FIN_MINOR_ORACLE.OoCCastBuff );
