--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Hooks Main script
	Engine: A.L.E

	Credits:

	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.
	
	Features:
	
	*) Add gm items to new characters.
	*) Add "Heroic Presence" aura for Draneis players.
	*) Cast "Blood Presence" and add "Undying Resolve" for Death Knights.

--]]

local GM_ITEMS = { 2586, 12064, 11508, 43651 };

HOOKS = {}

function HOOKS.Consolidated( event, plr )

	if( event == 3 ) -- OnFirstEnterWorld
	then
		if( plr:IsGm() == true )
		then
			for i = 1, #GM_ITEMS
			do
				plr:AddItem( GM_ITEMS[ i ], 1 );
			end
		end

	elseif( event == 4 ) -- OnEnterWorld
	then
		if( plr:GetPlayerRace() == 11 )
		then
			local class = plr:GetPlayerClass();
			if( class == "Priest" or class == "Shaman" or class == "Mage" )
			then
				plr:AddAura( 28878, 0 ); -- Heroic Presence
			else
				plr:AddAura( 6562, 0 ); -- Heroic Presence
			end
		end

		if( plr:GetPlayerClass() == "Death Knight" )
		then
			plr:CastSpell( 48266 ); -- Blood Presence
			if( plr:GetMapId() == 609 )
			then
				plr:AddAura( 51915, 0 ); -- Undying Resolve
			end
		end
	end
end

RegisterServerHook( 3, HOOKS.Consolidated );
RegisterServerHook( 4, HOOKS.Consolidated );
