--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
    Durotar: Voodoo Troll
    Engine: A.L.E
    Credits: nil
--]]

VOODOO_TROLL = {}

function VOODOO_TROLL.OoCCastBuff( unit, event )

    if( event == 18 )
	
    then
	
        local n = math.random( 1, 5 );
		
        unit:RegisterAIUpdateEvent( n * 1000 );
		
    else
	
        if( unit:IsInCombat() == false and unit:HasAura( 324 ) == false )
		
        then
		
            unit:FullCastSpell( 324 ); -- Lighting Shield
			
            unit:ModifyAIUpdateEvent( 600000 );
			
        end
		
    end
	
end

RegisterUnitEvent( 3206, 18, VOODOO_TROLL.OoCCastBuff );

RegisterUnitEvent( 3206, 21, VOODOO_TROLL.OoCCastBuff );
