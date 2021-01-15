--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest
	Creature: Matt (794)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:
	
	[ 1 ] = "Dang! Fish arent biting here either. I am gonna go back to my ol fishin hole!";
	[ 2 ] = "Gee, fish sure dont seem to be biting here. Maybe I should go over to Crystal Lake to try my luck there!";
	
	esMX locale:
	
	[ 1 ] = "¡Demonios! Los peces tampoco están mordiendo aquí. ¡Volveré a mi antiguo lugar de pezca!";
	[ 2 ] = "Caramba, los peces no parecen estar mordiendo aquí. ¡Tal vez deberia ir al Lago de Cristal y probar suerte allí!";

--]]

local CHAT = {
[ 1 ] = "¡Demonios! Los peces tampoco están mordiendo aquí. ¡Volveré a mi antiguo lugar de pezca!";
[ 2 ] = "Caramba, los peces no parecen estar mordiendo aquí. ¡Tal vez deberia ir al Lago de Cristal y probar suerte allí!";
};

local ANGLE = {
[ 1 ] = 2.617; -- Crystal Lake
[ 2 ] = 2.118; -- Goldshire pond
};

MATT = {}

function MATT.ChatOnReachWP( unit, event, waypointId )

	-- on spawn
    if( event == 18 )
    then
        unit:RegisterAIUpdateEvent( 1000 );

	-- on reach waypoint
    elseif( event == 19 )
    then

		-- crystal lake
        if( waypointId == 1 )
        then
			-- set fishing pole at hand
            unit:SetByteValue( 0x7A, 0, 1 ); 
            unit:ModifyAIUpdateEvent( 3597000 );

		-- goldshire pond
        elseif( waypointId == 26 )
        then
			-- set fishing pole at hand
            unit:SetByteValue( 0x7A, 0, 1 );
            unit:ModifyAIUpdateEvent( 90000 );
		
		elseif( waypointId == 2 or waypointId == 27 )
		then
			unit:ModifyAIUpdateEvent( 1000 );
        end

	-- on ai update
    elseif( event == 21 )
    then
        local currentWaypoint = unit:GetCurrentWaypoint();
		
		--print(""..currentWaypoint.."");
		
        if( currentWaypoint == 1 or currentWaypoint == 26 )
        then
			-- hide pole
            unit:SetByteValue( 0x7A, 0, 0 );
			
			unit:SetFacing( ANGLE[ currentWaypoint ] );
            unit:SendChatMessage( 12, 7, CHAT[ currentWaypoint ] );
        end
    end
end

RegisterUnitEvent( 794, 18, MATT.ChatOnReachWP );
RegisterUnitEvent( 794, 19, MATT.ChatOnReachWP );
RegisterUnitEvent( 794, 21, MATT.ChatOnReachWP );

--[[ 
		Debug commands disabled by default


local COMMANDS = { "matt", "port", "setpole", "removepole" };

function MattCommands( _, plr, message )

	if( plr:IsGm() == true )
	then
		if( message == "#matt" )
		then
			for i = 1, #COMMANDS
			do
				plr:SendBroadcastMessage( ""..COMMANDS[ i ].."" );
			end

		elseif( message == "#port" )
		then
			plr:Teleport( 0, -9387.13, -117.859, 58.862, 3.11 );
						
		else
		
			local selection = plr:GetSelection();
			if( selection == nil)
			then
				plr:SendBroadcastMessage( "You need to select matt first." );
				
			else		

				if( message == "#setpole" )
				then
					selection:SetByteValue( 0x7A, 0, 1 );
					
				elseif( message == "#removepole" )
				then
					selection:SetByteValue( 0x7A, 0, 0 );

				end
			end
		end
    end
end

RegisterServerHook( 16, MattCommands );
--]]
