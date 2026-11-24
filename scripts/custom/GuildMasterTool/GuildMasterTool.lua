local NPCID = 31111

function MohawkOnActivate( unit, activator )

	print("ON ACTIVATE")
	print(unit:GetName())
	--print(event)
	print(activator:GetName())
end

function MohawkOnDeactivate( unit, event )

	print("ON DE-ACTIVATE")
	--print(event)
	print(unit:GetName())
end

function MohawkOnHello( unit, event, player )

	unit:GossipCreateMenu( 1, player, 0 )
	unit:GossipMenuAddItem( 0, "Set AI type Loner", 1, 0 )
	unit:GossipMenuAddItem( 0, "Set AI type Agro", 2, 0 )
	unit:GossipMenuAddItem( 0, "Set AI type Social", 3, 0 )
	unit:GossipMenuAddItem( 0, "Set AI type Pet", 4, 0 )
	unit:GossipMenuAddItem( 0, "Set AI type Totem", 5, 0 )
	unit:GossipMenuAddItem( 0, "Set AI type Guardian", 6, 0 )
	unit:GossipMenuAddItem( 0, "Set AI type Passive", 7, 0 )
	unit:GossipMenuAddItem( 0, "Set Allowed to Combat true", 8, 0 )
	unit:GossipMenuAddItem( 0, "Set Allowed to Combat false", 9, 0 )
	unit:GossipMenuAddItem( 0, "Set AI to use True", 10, 0 )
	unit:GossipSendMenu( player )

end

function MohawkOnSelect( unit, event, player, textId, id, code )

	if id == 1 then
	
		local target = player:GetSelection()
		target:SetAIType(0) -- loner
		target:SendChatMessage(12, 0, "My AI type its Loner")
	
	elseif id == 2 then
	
		local target = player:GetSelection()
		target:SetAIType(1) -- Agro
		target:SendChatMessage(12, 0, "My AI type its Agro")
		
	elseif id == 3 then
	
		local target = player:GetSelection()
		target:SetAIType(2) -- Social
		target:SendChatMessage(12, 0, "My AI type its Social")
		
	elseif id == 4 then
	
		local target = player:GetSelection()
		target:SetAIType(3) -- Pet
		target:SendChatMessage(12, 0, "My AI type its Pet")
		
	elseif id == 5 then
	
		local target = player:GetSelection()
		target:SetAIType(4) -- Totem
		target:SendChatMessage(12, 0, "My AI type its Totem")
	
	elseif id == 6 then
	
		local target = player:GetSelection()
		target:SetAIType(5) -- Guardian
		target:SendChatMessage(12, 0, "My AI type its Guardian")
	
	elseif id == 7 then
	
		local target = player:GetSelection()
		target:SetAIType(6) -- Passive
		target:SendChatMessage(12, 0, "My AI type its Pasive")
		
	elseif id == 8 then
	
		local target = player:GetSelection()
		target:SetAllowedToEnterCombat(1)
		local v = target:GetVehicleBase()
		if v then v:SetAllowedToEnterCombat(1) end
	
	elseif id == 9 then
	
		local target = player:GetSelection()
		target:SetAllowedToEnterCombat(0)
		local v = target:GetVehicleBase()
		if v then v:SetAllowedToEnterCombat(0) end
		
	elseif id == 10 then
	
		local target = player:GetSelection()
		target:UseAI()
		local v = target:GetVehicleBase()
		if v then v:UseAI() end
	end
	player:GossipComplete()
end

--RegisterUnitGossipEvent( NPCID, 1, MohawkOnHello )
--RegisterUnitGossipEvent( NPCID, 2, MohawkOnSelect )


local ITEM_ID = 58001

GUILD_MASTER_TOOL = {}

function GUILD_MASTER_TOOL.itemOnHello( item, event, player )

	item:GossipCreateMenu( 1, player, 0 )	
	item:GossipMenuAddItem(0, "Guild Notifications", 2, 0)
	item:GossipMenuAddItem(4, "Guild Management", 3, 0)
	item:GossipMenuAddItem(6, "Guild Bank", 4, 0)
    item:GossipSendMenu( player )
end

function GUILD_MASTER_TOOL.itemOnSelect( item, event, player, id, option, code )
	
	if option == 1 then
	
		GuildOnHello( item, event, player )
	end
	
	item:GossipCreateMenu( 1, player, 0 )
		
	if option == 2 then
	
		item:GossipMenuAddItem(0, "Guild Chat Notification", 21, 1, "")
		item:GossipMenuAddItem(0, "Guild Warning Notification", 22, 1, "")
		item:GossipMenuAddItem(7, "[Back]", 1, 0)
		item:GossipSendMenu( player )
	end
	
	if option == 3 then
	
		item:GossipMenuAddItem(4, "Summon ALL Guild Members", 31, 0)
		item:GossipMenuAddItem(4, "Summon a Guild Member", 32, 1, "")
		item:GossipMenuAddItem(4, "Promote New Guildmaster", 33, 1, "")
		item:GossipMenuAddItem(4, "Disband Guild", 34, 1, "")
		item:GossipMenuAddItem(7, "[Back]", 1, 0)
		item:GossipSendMenu( player )
	end
	
	if option == 4 then
	
		item:GossipMenuAddItem(6, "Check Guild Bank Gold Amount", 41, 0)
		item:GossipMenuAddItem(6, "Withdraw Gold from Guild Bank", 42, 1)
		item:GossipMenuAddItem(6, "Deposit Gold to Guild Bank", 43, 1)
		item:GossipMenuAddItem(7, "[Back]", 1, 0)
		item:GossipSendMenu( player )
	end
	
	if option == 21 or option == 22 then
	
		local playerGuildId = player:GetGuildId()
		
		for _, v in ipairs(GetPlayersInWorld()) do
		
			if v:GetGuildId() == playerGuildId then
		
				if option == 21 then
			
					v:SendBroadcastMessage("|cFF33FF33[Guild Notification]: |cFFFFFFFF"..code.."")
				
				elseif option == 22 then
			
					v:SendAreaTriggerMessage("|cFF33FF33[Guild Warning]: |cFFFFFFFF"..code.."")
				end
			end
		end		
	end
	
	if option == 31 then
	
		local playerGuildId = player:GetGuildId()
		
		for _, v in ipairs(GetPlayersInWorld()) do
		
			if v:GetGuildId() == playerGuildId then
		
				v:Teleport(player:GetMapId(), player:GetX()+math.random(-3,3), player:GetY()+math.random(-3,3), player:GetZ(), 0)	
				v:SendBroadcastMessage("You have been summoned by your Guild Master!")
			end
			player:SendBroadcastMessage("All guild members have been summoned.")
		end
	end
	
	if option == 32 then
	
		local playerGuildId = player:GetGuildId()
		
		for _, v in ipairs(GetPlayersInWorld()) do
		
			if v:GetGuildId() == playerGuildId then
			
				if v:GetName() == ""..code.."" then
				
					v:Teleport(player:GetMapId(), player:GetX()+math.random(-3,3), player:GetY()+math.random(-3,3), player:GetZ(), 0)
					v:SendBroadcastMessage("You have been summoned by your Guild Master!")
				end
				player:SendBroadcastMessage("You have summoned "..code..".")
			end
		end	
	end
	
	if option == 41 then

		local qry = CharDBQuery(string.format("SELECT bankBalance FROM guilds WHERE guildId = %d", player:GetGuildId()))
		if qry then
		
			local goldStored = qry:GetColumn( 0 ):GetULong() / 10000
			player:SendGuildChatMessage("Our Guild Bank contains "..goldStored.." Gold.", 0)
		end
	end
	
	--- Withdraw:
	if option == 42 then
	
		local qry = CharDBQuery(string.format("SELECT bankBalance FROM guilds WHERE guildId = %d", player:GetGuildId()))
		if qry then
		
			local goldStored = qry:GetColumn( 0 ):GetULong()
		
			local amount = code * 10000

			if amount < goldStored then
		
				player:GuildBankWithdrawMoney(amount)
				player:SendGuildChatMessage(""..player:GetName().."has withdraw "..code.." Gold.", 0)
			end
		end
	end
	
	--- Deposit:
	if option == 43 then
	
		local amount = code * 10000
	
		if player:GetCoinage() < amount then
		
			player:SendBroadcastMessage("You do not have "..code.." Gold!")
		else
			player:SendGuildChatMessage(""..player:GetName().."has deposit "..code.." Gold.", 0)
			player:GuildBankDepositMoney(amount)
		end
	end
	
    --player:GossipComplete()
end

RegisterItemGossipEvent( ITEM_ID, 1, GUILD_MASTER_TOOL.itemOnHello )
RegisterItemGossipEvent( ITEM_ID, 2, GUILD_MASTER_TOOL.itemOnSelect )