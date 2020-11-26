--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
    Tirisfall Glades: Vile Fin Minor Oracle
    Engine: A.L.E
    Credits: nil
--]]

VILE_FIN_MINOR_ORACLE = {}

function VILE_FIN_MINOR_ORACLE.OoCCastBuff( unit, event )

    if( event == 18 )
	
    then
	
        local n = math.random( 1, 5 );
		
        unit:RegisterAIUpdateEvent( n * 1000 );
		
    else
	
        if( unit:IsInCombat() == false and unit:HasAura( 324 ) == false )
		
        then
		
            unit:FullCastSpell( 324 ); -- Lightning Shield
			
            unit:ModifyAIUpdateEvent( 600000 );
			
        end
		
    end
	
end

RegisterUnitEvent( 1544, 18, VILE_FIN_MINOR_ORACLE.OoCCastBuff );

RegisterUnitEvent( 1544, 21, VILE_FIN_MINOR_ORACLE.OoCCastBuff );
