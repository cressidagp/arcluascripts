--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Debug Kit

	Credits:

	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	Developer notes: this one save me a lot of time in debuggin quest and spells.
	
	NOTE: disabled by default.


--]]

HOOKS_DEBUG = {}

--OnCastSpell( event, player, spellid, spellObject )
--OnQuestAccept( event, player, questId, questGiver )
--OnQuestComplete( event, player, questId, questGiver )
--OnAreaTrigger( event, player, areaTriggerId )

function HOOKS_DEBUG.onEventSendArgumentsToPlayer( event, plr, arg1, arg2 )

	if plr:IsGm() == true then

		--
		-- OnCastSpell
		--
		if event == 10 then

			local name = plr:GetName()
			print( "LuaEngine: Player " .. ""..name.." " .. "has casted spell " .. ""..arg1.." " )
			plr:SendBroadcastMessage( "Spellid: "..arg1.." " )
			plr:SendBroadcastMessage( "spellType: "..arg2:GetSpellType().." " )

		--
		-- OnQuestAccept or OnQuestComplete
		--
		elseif event == 14 or event == 22 then

			plr:SendBroadcastMessage( "QuestId: "..arg1.." " )

			if arg2 ~= nil then

				plr:SendBroadcastMessage( "QuestGiver: "..arg2:GetEntry().. " " )

			end

		-- 
		-- OnAreaTrigger
		--
		elseif event == 26 then

			plr:SendBroadcastMessage( "AreaTriggerId: "..arg1.. " " )

		end

	end

end

RegisterServerHook( 10, HOOKS_DEBUG.onEventSendArgumentsToPlayer );
RegisterServerHook( 14, HOOKS_DEBUG.onEventSendArgumentsToPlayer );
RegisterServerHook( 22, HOOKS_DEBUG.onEventSendArgumentsToPlayer );
RegisterServerHook( 26, HOOKS_DEBUG.onEventSendArgumentsToPlayer );