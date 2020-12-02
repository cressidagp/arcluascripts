--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Debug Kit
	Engine: A.L.E
	Credits: nil

--]]

HOOKS = {}

function HOOKS.Consolidated( event, plr )

    if( event == 4 ) -- OnEnterWorld
    then
        if( plr:GetPlayerRace() == 11 )
        then
            local class = plr:GetPlayerClass();
            if( class == "Priest"  or class == "Shaman" or class == "Mage" )
            then
                plr:AddAura( 28878, 0 ); -- Heroic Presence
            else
                plr:AddAura( 6562, 0 ); -- Heroic Presence
            end
        end
    end
end

RegisterServerHook( 4, HOOKS.Consolidated );
