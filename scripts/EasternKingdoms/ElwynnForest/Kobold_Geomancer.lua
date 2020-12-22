--[[ 
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Elwynn Forest: Kobold Geomancer
	Engine: A.L.E
	Credits: nil
--]]

KOBOLD_GEOMANCER = {}

function KOBOLD_GEOMANCER.OoCCastBuff( unit, event )

    if( event == 18 )
	
    then
	
        local n = math.random( 1, 5 );
		
        unit:RegisterAIUpdateEvent( n * 1000 );
		
    else
	
        if( unit:IsInCombat() == false and unit:HasAura( 12544 ) == false )
		
        then
		
            unit:FullCastSpell( 12544 ); -- Frost Amor
			
            unit:ModifyAIUpdateEvent( 1800000 );
			
        end
		
    end
	
end

RegisterUnitEvent( 476, 18, KOBOLD_GEOMANCER.OoCCastBuff );

RegisterUnitEvent( 476, 21, KOBOLD_GEOMANCER.OoCCastBuff );
