-- Frezza, Snurk, Zelli
local NPC_ENTRY = { 3149, 3150, 9564, 9566, 12136, 12137, 26537, 26538, 26539, 26540, 34765, 34766 };

local DATA = {
{ 9564, 164871, "The zeppelin to Undercity has just arrived! All aboard to Tirisfall Glades!" },   -- Frezza, The Thundercaller
{ 9566, 164871, "The zeppelin to Orgrimmar has just arrived! All aboard for Durotar!" },           -- Zappeta, The Thundercaller
{ 12136, 175080, "The zeppelin to Grom'gol has just arrived! All aboard for Stranglethorn!" },     -- Snurk, The Iron Eagle
{ 3149, 175080, "The zeppelin to Orgrimmar has just arrived! All aboard for Durotar!" },           -- Nezraz, The Iron Eagle
{ 12137, 176495, "The zeppelin to Undercity has just arrived! All aboard for Tirisfal Glades!" },  -- Squibby, The Purple Princess
{ 3150, 176495, "The zeppelin to Grom'gol has just arrived! All aboard for Stranglethorn!" },      -- Hin, The Purple Princess
{ 26537, 186238, "The zeppelin to Warsong Hold has just arrived! All aboard for Borean Tundra!" }, -- Greeb, The Mighty Wind
{ 26538, 186238, "The zeppelin to Orgrimmar has just arrived! All aboard for Durotar!" },          -- Nargo, The Mighty Wind
{ 26539, 195459, "The zeppelin to Vengeance Landing has just arrived! All aboard for Howling Fjord!" }, -- Meefi, The Cloudkisser
{ 26540, 195459, "The zeppelin to Undercity has just arrived! All aboard for Tirisfal Glades!" },       -- Drenk, The Cloudkisser
{ 34765, 190549, "The zeppelin to Thunder Bluff has arrived! All aboard for a smooth ride across the Barrens!" },  -- Zelli, The Zephyr
{ 34766, 190549, "Step right up! The zeppelin to Orgrimmar has arrived! All aboard to Durotar!" }                  -- Krendle, The Zephyr
}

T_ZEPPELIN = {}

function T_ZEPPELIN.CheckForTransport( unit, event )
    local sUnit = tostring( unit );
    if( unit:IsAlive() == true and T_ZEPPELIN[ sUnit ].var == false )
    then
        -- Frezza, The Thundercaller
        if( unit:GetEntry() == DATA[1][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[1][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[1][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Zappeta, The Thundercaller
        elseif( unit:GetEntry() == DATA[2][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[2][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[2][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Snurk, The Iron Eagle
        elseif( unit:GetEntry() == DATA[3][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[3][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[3][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Nezraz, The Iron Eagle
        elseif( unit:GetEntry() == DATA[4][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[4][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[4][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Squibby, The Purple Princess
        elseif( unit:GetEntry() == DATA[5][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[5][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[5][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Hin, The Purple Princess
        elseif( unit:GetEntry() == DATA[6][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[6][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[6][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Greeb, The Mighty Wind
        elseif( unit:GetEntry() == DATA[7][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[7][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[7][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Nargo, The Mighty Wind
        elseif( unit:GetEntry() == DATA[8][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[8][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[8][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Meefi, The Cloudkisser
        elseif( unit:GetEntry() == DATA[9][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[9][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[9][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Drenk, The Cloudkisser
        elseif( unit:GetEntry() == DATA[10][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[10][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[10][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Zelli, The Zephyr
        elseif( unit:GetEntry() == DATA[11][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[11][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[11][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end

        -- Krendle, The Zephyr
        elseif( unit:GetEntry() == DATA[12][1] )
        then
            local zep = unit:GetGameObjectNearestCoords( unit:GetX(), unit:GetY(), unit:GetZ(), DATA[12][2] );
            if( zep ~= nil )
            then
                unit:SendChatMessage( 14, 0, DATA[12][3] );
                T_ZEPPELIN[ sUnit ].var = true;
            else
                T_ZEPPELIN[ sUnit ].var = false;
            end
        end
    end
end

function T_ZEPPELIN.OnSpawn( unit, event )
    local sUnit = tostring( unit );
    T_ZEPPELIN[ sUnit ] = {}
    T_ZEPPELIN[ sUnit ].var = false;
    unit:RegisterEvent( T_ZEPPELIN.CheckForTransport, 1000, 0 );
end

for i = 1, #NPC_ENTRY do
    RegisterUnitEvent( NPC_ENTRY[ i ], 18, T_ZEPPELIN.OnSpawn );
end
