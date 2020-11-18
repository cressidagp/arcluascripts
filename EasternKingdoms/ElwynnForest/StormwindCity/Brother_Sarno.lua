--[[  www.ArcEmu.org
      Stormwind City: Brother Sarno
      Engine: A.L.E
      Credits: to Trinity for creature texts and emote
--]]

local EMOTE_ONESHOT_WAVE = 3

BROTHER_SARNO = {}

function BROTHER_SARNO.ResetOrientation( unit )
    unit:SetFacing( unit:GetSpawnO() );
end

function BROTHER_SARNO.OnWelcome( unit )

    if( unit:IsHostile( BROTHER_SARNO.target ) == false and BROTHER_SARNO.var == 1 )
    then
        unit:SetFacing( 4.28 );
        unit:SendChatMessage( 12, 0, "Greetings, "..BROTHER_SARNO.target:GetPlayerClass().."! Welcome to the Cathedral of Light!" );
        unit:Emote( EMOTE_ONESHOT_WAVE, 0 );
        unit:RegisterEvent( BROTHER_SARNO.ResetOrientation, 9000, 1 ); -- when text expires...

        BROTHER_SARNO.target = nil; -- lets clean up to save some resources

        BROTHER_SARNO.var = 0; -- disabled till aiupdate

        unit:RegisterAIUpdateEvent( 60000 );
    end
end

function BROTHER_SARNO.OnSpawnOrAIUpdate( unit, event )

    -- Developers note: for some reason, OnWelcome will not trigger if we dont have OnSpawn.

    if( event == 18 )
    then
        BROTHER_SARNO.var = 1; -- enabled at spawn

    elseif( event == 21 )
    then
        BROTHER_SARNO.var = 1; -- enabled after aiupdate
        unit:RemoveAIUpdateEvent();
    end
end

function BROTHER_SARNO.OnAreaTrigger( event, plr, ATID )

    if( ATID == 1125 )
    then
        local unit = plr:GetCreatureNearestCoords( -8556.00, 835.86, 106.60, 7917 );
        if( unit ~= nil )
        then
            unit:RegisterEvent( BROTHER_SARNO.OnWelcome, 1000, 1 );
            BROTHER_SARNO.target = plr;
        end
    end
end

RegisterUnitEvent( 7917, 18, BROTHER_SARNO.OnSpawnOrAIUpdate );
RegisterUnitEvent( 7917, 21, BROTHER_SARNO.OnSpawnOrAIUpdate );
RegisterServerHook( 26, BROTHER_SARNO.OnAreaTrigger );
