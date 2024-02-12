--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Debug Commands
	
	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

--]]

local COMMANDS = { "help", "gprint", "removeauras", "getphase", "jail", "npc", "movetype" }

HOOKS_DEBUG = {}

function HOOKS_DEBUG.onChatMessage( event, plr, message )

	if plr:IsGm() == true then

		if message == "#help" then

			for i = 1, #COMMANDS do

				plr:SendBroadcastMessage( " "..COMMANDS[ i ].." " )

			end

		elseif message == "#gprint" then

			for n in pairs( _G ) do

				print( n )

				plr:SendBroadcastMessage( " "..n.." " )

			end

			plr:SendBroadcastMessage( "Lua global table has been printed." )

		elseif message == "#removeauras" then

			local selection = plr:GetSelection()

			if selection ~= nil then

				selection:RemoveAllAuras()

			else

				plr:RemoveAllAuras()

			end

		elseif message == "#getphase" then

			local selection = plr:GetSelection()

			if selection ~= nil then

				plr:SendBroadcastMessage( "Target phase: "..selection:GetPhase().." " )

			end

		elseif message == "#jail" then

			local selection = plr:GetSelection()

			if selection ~= nil then

				if selection:IsPlayer() then

					selection:Teleport( 0, -8667.677, 624.130, 95.69, 2.2 )
					selection:SendBroadcastMessage( "You are in jail." )

				end

			else

				plr:Teleport( 0, -8667.677, 624.130, 95.69, 2.2 )
				plr:SendBroadcastMessage( "Player has been send to jail." )

			end

		elseif message == "#npc" then

			local selection = plr:GetSelection()

			if selection ~= nil and selection:IsCreature() then

				local name = selection:GetName()
				local entry = selection:GetEntry()
				local id = selection:GetSpawnId()

				plr:SendBroadcastMessage( "Entry: "..entry.." " )
				plr:SendBroadcastMessage( "Spawnid: "..id.." " )

				print()
				print(""..name.."")
				print("npcid: "..entry.."")
				print("spawnid: "..id.."")

			end

		elseif message == "#movetype" then

			local selection = plr:GetSelection()

			if selection ~= nil and selection:IsCreature() then

				plr:SendBroadcastMessage( "moveType: "..selection:GetMoveType().." " )

			end

		elseif message == "#distance" then

			local selection = plr:GetSelection()

			if selection ~= nil then

				plr:SendBroadcastMessage( "Distance: "..plr:GetDistance( selection ).." " )
				plr:SendBroadcastMessage( "Yards: "..plr:GetDistanceYards( selection ).." " )

			end

		end

	end

end

RegisterServerHook( 16, HOOKS_DEBUG.onChatMessage );