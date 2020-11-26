--[[ 
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Elwynn Forest: Surena Caledon
	Engine: A.L.E
	Credits: nil
--]]

SURENA_CALEDON = {}

function SURENA_CALEDON.OoCCastBuff( unit, event )

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

RegisterUnitEvent( 881, 18, SURENA_CALEDON.OoCCastBuff );

RegisterUnitEvent( 881, 21, SURENA_CALEDON.OoCCastBuff );
