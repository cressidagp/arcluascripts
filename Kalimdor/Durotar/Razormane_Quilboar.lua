--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
    Durotar: Razormane Quilboar
    Engine: A.L.E
    Credits: nil
--]]

RAZORMANE_QUILBOAR = {}

function RAZORMANE_QUILBOAR.OoCCastBuff( unit, event )

    if( event == 18 )
	
    then
	
        unit:RegisterAIUpdateEvent( 3000 );
		
    else
	
        if( unit:IsInCombat() == false )
		
        then
		
            unit:FullCastSpell( 5280 ); -- Razor Mane
			
            unit:ModifyAIUpdateEvent( 45000 );
			
        end
		
    end
	
end

RegisterUnitEvent( 3111, 18, RAZORMANE_QUILBOAR.OoCCastBuff );

RegisterUnitEvent( 3111, 21, RAZORMANE_QUILBOAR.OoCCastBuff );
