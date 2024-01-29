--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	AI Summons

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some inspiration.
	*) DarkAngel39 for his instance progression system.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

--]]

--NPCID_CYLINA_DARKHEART	= 6374
--NPCID_KEYANOMIR			= 18231

SUMMONS = {}
SUMMONS.NPCID = { 6374, 18231 }

function SUMMONS.onSpawnLoadSummonFromDB( unit, event )

	local q = WorldDBQuery( "SELECT `summonedId`, `pos_x`, `pos_y`, `pos_z`, `orientation` FROM `ai_summons` WHERE `summonerId` = '"..unit:GetEntry().."'" );

	if q ~= nil then

		local summonedId = q:GetColumn( 0 ):GetUShort()
		local x = q:GetColumn( 1 ):GetFloat()
		local y = q:GetColumn( 2 ):GetFloat()
		local z = q:GetColumn( 3 ):GetFloat()
		local o = q:GetColumn( 4 ):GetFloat()

		if summonedId and x and y and z and o then

			local summon = unit:SpawnCreature( summonedId, x, y, z, o, unit:GetFaction(), 0, 0, 0, 0, unit:GetPhase(), 0 )
			summon:SetLevel(unit:GetLevel())

			local guid = unit:GetGUID()

			-- set summoned by
			summon:SetUInt64Value( 0x0006 + 0x0008, guid )

			-- set created by
			summon:SetUInt64Value( 0x0006 + 0x000A, guid )

		end

	end

end

for i = 1, #SUMMONS.NPCID do

	RegisterUnitEvent( SUMMONS.NPCID[ i ], 18, SUMMONS.onSpawnLoadSummonFromDB )

end