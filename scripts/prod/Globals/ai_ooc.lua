--[[

	ArcLuaScripts for ArcEmu
	Engine: A.L.E
	2024
	
	AI "Out Of Combat" cast loaded from database

--]]

OOC = {}
--OOC.NPCID = { 474, 476 }

function OOC.onSpawn( unit, event )

	unit:RegisterAIUpdateEvent( 3 * 1000 )

end

function OOC.onAIUpdate( unit, event )

	if unit:IsInCombat() == true then return end
	
	local q2 = WorldDBQuery( "SELECT `spellId`, `cooldown` FROM `ai_ooc` WHERE `casterId` = '"..unit:GetEntry().."'" )
	
	if q2 ~= nil then
	
		local data = {}
		
		local colcount = q2:GetColumnCount()
		
		for col = 0, colcount -1 do
		
			data[ col ] = q2:GetColumn( col ):GetUShort()
			--print(data[col])
	
		end
	
		unit:CastSpell( data[ 0 ] )
		unit:ModifyAIUpdateEvent( data[ 1 ] * 1000 )
		
		data = nil
		
	end 

end

local q1 = WorldDBQuery( "SELECT `casterId`, `spellId`, `cooldown` FROM `ai_ooc` LIMIT 100 " )

if q1 ~= nil then

	local colcount = q1:GetColumnCount()
	
	repeat
	
		for col = 0, colcount - 3 do
		
			local npcid = q1:GetColumn( col ):GetUShort()
		
			RegisterUnitEvent( npcid, 18, OOC.onSpawn )
			RegisterUnitEvent( npcid, 21, OOC.onAIUpdate )	
		
		end
	
	until q1:NextRow() ~= true

end

--[[
for i = 1, #OOC.NPCID do


	RegisterUnitEvent( OOC.NPCID[ i ], 18, OOC.onSpawn )
	RegisterUnitEvent( OOC.NPCID[ i ], 21, OOC.onAIUpdate )

end
--]]