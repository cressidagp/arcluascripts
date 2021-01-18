--[[
    ArcLuaScripts for ArcEmu
    www.ArcEmu.org
	Engine: A.L.E
	
    Gameobject scale fix: Farm Chicken Egg, Silithyst Mound
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
--]]

GO_SCALE_FIX = {}

function GO_SCALE_FIX.OnSpawn( go )

    -- Case: Farm Chicken Egg
	
    if( go:GetEntry() == 161513 )
    then
		if( go:GetScale() ~= 0.2 )
		then
			go:SetScale( 0.2 );
		end

    -- Case: Silithyst Mound
	
    elseif( go:GetEntry() == 181597 )
    then
		if( go:GetScale() ~= 0.3 )
		then
			go:SetScale( 0.3 );

        end
    end
end

RegisterGameObjectEvent( 161513, 2, GO_SCALE_FIX.OnSpawn );
RegisterGameObjectEvent( 181597, 2, GO_SCALE_FIX.OnSpawn );
