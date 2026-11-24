--[[
 * ArcLuaScripts for ArcEmu
 * 2020-2026
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
]]
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