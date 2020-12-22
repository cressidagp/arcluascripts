--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Elwynn Forest: Matt
	Engine: A.L.E
	Credits: to Trinity for creature texts and timers.

	enUS:

	[ 1 ] = "Dang! Fish arent biting here either. I am gonna go back to my ol fishin hole!";
	[ 2 ] = "Gee, fish sure dont seem to be biting here. Maybe I should go over to Crystal Lake to try my luck there!";

	esMX:

	[ 1 ] = "¡Demonios! Los peces tampoco están mordiendo aquí. ¡Volveré a mi antiguo lugar de pezca!";
	[ 2 ] = "Caramba, los peces no parecen estar mordiendo aquí. ¡Tal vez deberia ir al Lago de Cristal y probar suerte allí!";

--]]

local CHAT = {
[ 1 ] = "Dang! Fish arent biting here either. I am gonna go back to my ol fishin hole!";
[ 2 ] = "Gee, fish sure dont seem to be biting here. Maybe I should go over to Crystal Lake to try my luck there!";
};

MATT = {}

function MATT.TalkOnReachWP( unit, event, wpID )
	
	-- OnSpawn:
	
    if( event == 18 )
	
    then
	
        unit:RegisterAIUpdateEvent( 60000 );
		
	-- OnReachWaypoint:

    elseif( event == 19 )
	
    then

        if( wpID == 1 )
		
        then
		
            unit:SetByteValue( 0x7A, 0, 1 );
			
	          --unit:RegisterEvent( MATT.RunScript, 60000, 1 ); --3597000
			  
            unit:ModifyAIUpdateEvent( 60000 );

        elseif( wpID == 26 )
		
        then
		
            unit:SetByteValue( 0x7A, 0, 1 );
			
            --unit:RegisterEvent( MATT.RunScript, 60000, 1 ); --90000
			
            unit:ModifyAIUpdateEvent( 60000 );
        end
		
	-- OnAIUpdate:

    elseif( event == 21 )
	
    then
	
        local c_WP = unit:GetCurrentWaypoint();
		
        if( c_WP == 1 )
		
        then
		
            unit:SetByteValue( 0x7A, 0, 0 );
			
            unit:SendChatMessage( 12, 7, CHAT[ 1 ] );
			
            unit:SetFacing( 2.61799 );

        elseif( c_WP == 26 )
		
        then
		
            unit:SetByteValue( 0x7A, 0, 0 );
			
            unit:SendChatMessage( 12, 7, CHAT[ 2 ] );
			
            unit:SetFacing( 2.118 );
			
        end
		
    end
	
end

RegisterUnitEvent( 794, 18, MATT.TalkOnReachWP );

RegisterUnitEvent( 794, 19, MATT.TalkOnReachWP );

RegisterUnitEvent( 794, 21, MATT.TalkOnReachWP );
