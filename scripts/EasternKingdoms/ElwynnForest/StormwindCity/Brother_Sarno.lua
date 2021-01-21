--[[	
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E	
	
	Zone: Stormwind City
	Creature: Brother Sarno (7917)
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale: "Greetings, "..BROTHER_SARNO.newVisitor:GetPlayerClass().."! Welcome to the Cathedral of Light!"
	
	esMX locale: "¡Saludos, "..BROTHER_SARNO.newVisitor:GetPlayerClass().."! ¡Bienvenido a la Catedral de la Luz!"
	
--]]

--local NPC_BROTHER_SARNO = 7917;
--local EMOTE_ONESHOT_WAVE = 3;
--local UNIT_FIELD_TARGET = 0x0006 + 0x000C;

BROTHER_SARNO = {}

function BROTHER_SARNO.ResetTarget( unit )

    unit:SetUInt64Value( 0x0006 + 0x000C, 0 );

end

function BROTHER_SARNO.OnWelcome( unit )

    if( unit:IsHostile( BROTHER_SARNO.newVisitor ) == false and BROTHER_SARNO.canWelcome == 1 )
    then

        unit:SetUInt64Value( 0x0006 + 0x000C, BROTHER_SARNO.newVisitor:GetGUID() );
        unit:SendChatMessage( 12, 0, "Greetings, "..BROTHER_SARNO.newVisitor:GetPlayerClass().."! Welcome to the Cathedral of Light!" );
        unit:Emote( 3, 0 );
        unit:RegisterEvent( ClearTarget, 9000, 1 );
		
		-- lets clean up to save some resources
        BROTHER_SARNO.newVisitor = nil; 

		-- disabled till aiupdate
        BROTHER_SARNO.canWelcome = false;

        unit:RegisterAIUpdateEvent( 60000 );

    end
end

function BROTHER_SARNO.OnSpawnOrAIUpdate( unit, event )
	
	if( event == 21 )
    then
		-- enabled after ai update
        BROTHER_SARNO.canWelcome = true; 
        unit:RemoveAIUpdateEvent();
    
	-- for some reason, OnWelcome will not trigger if we dont have OnSpawn.
    elseif( event == 18 )
    then
		-- enabled at spawn
        BROTHER_SARNO.canWelcome = true;
    end
end

function BROTHER_SARNO.OnAreaTrigger( _, plr, areaTriggerId )

    if( areaTriggerId == 1125 )
    then
        local unit = plr:GetCreatureNearestCoords( -8556.00, 835.86, 106.60, 7917 );
        if( unit ~= nil )
        then
            unit:RegisterEvent( BROTHER_SARNO.OnWelcome, 1000, 1 );
            BROTHER_SARNO.newVisitor = plr;
        end
    end
end

RegisterUnitEvent( 7917, 18, BROTHER_SARNO.OnSpawnOrAIUpdate );
RegisterUnitEvent( 7917, 21, BROTHER_SARNO.OnSpawnOrAIUpdate );
RegisterServerHook( 26, BROTHER_SARNO.OnAreaTrigger );