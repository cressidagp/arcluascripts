--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Server Hooks: Main Script

	Features:
	
	*) Add gm items to new characters.
	*) Add "Heroic Presence" aura for Draneis players.
	*) Cast "Blood Presence" and add "Undying Resolve" for Death Knights.
	*) Fix character start orientation since arcemu cant handle it.

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some inspiration.
	*) DarkAngel39 for his instance progression system.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

--]]

local GM_ITEMS = { 2586, 12064, 11508, 43651 };

HOOKS = {};

function HOOKS.Consolidated( event, plr )

	--
	-- ON FIRST ENTER WORLD
	--

	if( event == 3 )
	then
	
		-- add gm items
		if( plr:IsGm() == true )
		then
			for i = 1, #GM_ITEMS
			do
				plr:AddItem( GM_ITEMS[ i ], 1 );
			end
		end
		
		-- fix players start orientation
		if( plr:GetPlayerClass() ~= "Death Knight" )
		then
			local race = plr:GetPlayerRace();
			
			if( race == 1 or race == 2 or race == 6 or race == 7 or race == 8 ) then return; end
			
			if( race == 3 )
			then
				plr:SetFacing( 6.17716 );
				
			elseif( race == 4 )
			then
				plr:SetFacing( 5.48033 );
				
			elseif( race == 5 )
			then
				plr:SetFacing( 2.70526 );
				
			elseif( race == 10 )
			then
				plr:SetFacing( 5.31605 );
				
			elseif( race == 11 )
			then
				plr:SetFacing( 2.08364 );
			end

		else
			plr:SetFacing( 3.65997 );
		end

	--
	-- ON ENTER WORLD
	--
	
	elseif( event == 4 )
	then
		
		-- add heroic presence to draenei players
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

		-- add auras to death knight players
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
