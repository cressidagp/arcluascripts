--[[
 * ArcLuaScripts for ArcEmu
 * 2026
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

local RottingFrostGiant = {}

function RottingFrostGiant.onReset( unit, event )

	unit:RegisterAIUpdateEvent(1000)

	local guid = tostring(unit)

	if RottingFrostGiant[guid] == nil then

        RottingFrostGiant[guid] = {

			deathPlague = 15,
			stomp = math.random(5, 8),
			articBreath = math.random(10, 15)
		}
    end
end

function RottingFrostGiant.onDied( unit, event, killer )

	RottingFrostGiant[ tostring( unit ) ] = nil

end

function RottingFrostGiant.onAIUpdate( unit, event )

	if unit:GetNextTarget() == nil then
		return
	end

	local vars = RottingFrostGiant[ tostring( unit ) ]

	vars.deathPlague = vars.deathPlague - 1
	vars.stomp = vars.stomp - 1
	vars.articBreath = vars.articBreath - 1

	-- is casting check
	if unit:GetAIState() == 2 then
		return
	end

	if vars.deathPlague <= 0 then

		local targetPlayer = unit:GetRandomPlayer(0)
		if targetPlayer then
			unit:SendChatMessage( 41, 0, "$n is infected with the Death Plague!" )
            -- emote 25?
			unit:FullCastSpellOnTarget(72865, targetPlayer)
		end

		vars.deathPlague = 15

	elseif vars.stomp <= 0 then

		unit:FullCastSpellOnTarget(64652, unit:GetMainTank())
		vars.stomp = math.random(15, 18)

	elseif vars.articBreath <= 0 then

		unit:FullCastSpellOnTarget(72848, unit:GetMainTank())
		vars.articBreath = math.random(26, 33)
	end
end

RegisterUnitEvent( 38490, 18, RottingFrostGiant.onReset )
RegisterUnitEvent( 38490, 3, RottingFrostGiant.onReset )
RegisterUnitEvent( 38490, 4, RottingFrostGiant.onDied )
RegisterUnitEvent( 38490, 21, RottingFrostGiant.onAIUpdate )

RegisterUnitEvent( 38494, 18, RottingFrostGiant.onReset )
RegisterUnitEvent( 38494, 3, RottingFrostGiant.onReset )
RegisterUnitEvent( 38494, 4, RottingFrostGiant.onDied )
RegisterUnitEvent( 38494, 21, RottingFrostGiant.onAIUpdate )