--[[ 
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest 
	Creature: Kobold Geomancer (476)
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

--]]

KOBOLD_GEOMANCER = {}

function KOBOLD_GEOMANCER.OoCCastBuff( unit, event )

	-- on aiupdate
    if( event == 21 )
    then
		if( unit:IsInCombat() == false and unit:HasAura( 12544 ) == false )
        then
			unit:FullCastSpell( 12544 ); -- Frost Amor
			unit:ModifyAIUpdateEvent( 1800000 );
		end
	
	-- on spawn
	else
        local n = math.random( 1, 5 );
        unit:RegisterAIUpdateEvent( n * 1000 );
    end	
end

RegisterUnitEvent( 476, 18, KOBOLD_GEOMANCER.OoCCastBuff );
RegisterUnitEvent( 476, 21, KOBOLD_GEOMANCER.OoCCastBuff );
