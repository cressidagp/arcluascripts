--[[

	ArcLuaScripts for ArcEmu
	Engine: A.L.E
	2024
	
	AI "Out Of Combat" cast with database loading

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some inspiration.
	*) DarkAngel39 for his instance progression system.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and A.L.E, specially to dfighter1985.

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
	
		local spellId = q2:GetColumn( 0 ):GetUShort()
		local cooldown = q2:GetColumn( 1 ):GetUShort()
	
		unit:CastSpell( spellId )
	
		unit:ModifyAIUpdateEvent( cooldown * 1000 )
		
	end 

end

local q1 = WorldDBQuery( "SELECT `casterId`, `spellId`, `cooldown` FROM `ai_ooc` LIMIT 100 " )

if q1 ~= nil then

	local colcount = q1:GetColumnCount()
	
	repeat
	
		for col = 0, colcount -1 do
		
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