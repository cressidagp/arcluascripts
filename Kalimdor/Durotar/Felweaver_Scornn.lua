--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
    Durotar: Felweaver Scornn
    Engine: A.L.E
    Credits: nil
--]]

FELWEAVER_SCORNN = {}

function FELWEAVER_SCORNN.OoCCastBuff( unit, event )

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

RegisterUnitEvent( 5822, 18, FELWEAVER_SCORNN.OoCCastBuff );

RegisterUnitEvent( 5822, 21, FELWEAVER_SCORNN.OoCCastBuff );
