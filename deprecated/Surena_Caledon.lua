--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest
	Creature: Surena Caledon (881)	

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPC_SURENA_CALEDON = 881;
--local SPELL_FROST_ARMOR = 12544;

SURENA_CALEDON = {}

function SURENA_CALEDON.OoCCastBuff( unit, event )

	-- on ai update
    if( event == 21 )
    then
        if( unit:IsInCombat() == false and unit:HasAura( 12544 ) == false )
        then
            unit:FullCastSpell( 12544 );
            unit:ModifyAIUpdateEvent( 1800000 );
        end
	
	-- on spawn
    else
		local n = math.random( 3, 5 );
		unit:RegisterAIUpdateEvent( n * 1000 );

    end
end

RegisterUnitEvent( 881, 18, SURENA_CALEDON.OoCCastBuff );
RegisterUnitEvent( 881, 21, SURENA_CALEDON.OoCCastBuff );
