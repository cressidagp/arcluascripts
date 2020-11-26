--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Durotar: Gazzuz
	Engine: A.L.E
	Credits: nil
--]]

GAZZUZ = {}

function GAZZUZ.OoCCastBuff( unit, event )

    if( event == 18 )
	
    then
        local n = math.random( 1, 5 );
		
        unit:RegisterAIUpdateEvent( n * 1000 );
		
    else
	
        if( unit:IsInCombat() == false and unit:HasAura( 20798 ) == false )
		
        then
		
            unit:FullCastSpell( 20798 ); -- Demon Skin
			
            unit:ModifyAIUpdateEvent( 1800000 );
			
        end
		
    end
	
end

RegisterUnitEvent( 3204, 18, GAZZUZ.OoCCastBuff );

RegisterUnitEvent( 3204, 21, GAZZUZ.OoCCastBuff );
