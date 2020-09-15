GO_SCALE_FIX = {}

function GO_SCALE_FIX.OnSpawn( go, event )
    if( go:GetEntry() == 161513 )
    then
        -- Case: Farm Chicken Egg

        go:SetScale( 0.2 );

    elseif( go:GetEntry() == 181597 )
    then
        -- Case: Silithyst Mound

        go:SetScale( 0.3 );
    end
end

RegisterGameObjectEvent( 161513, 2, GO_SCALE_FIX.OnSpawn );
RegisterGameObjectEvent( 181597, 2, GO_SCALE_FIX.OnSpawn );
