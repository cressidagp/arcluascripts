--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest
	Creature: Defias Cutpurse

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--NPC_DEFIAS_CUTPURSE = 94;
--SPELL_BACKSTAB = 53;

DEFIAS_CUTPURSE = {}

function DEFIAS_CUTPURSE.CastBackstab( unit, _ )

	local target = unit:GetNextTarget()
	
	if target == nil then
	
		unit:RemoveEvents()
		return
		
	end

    unit:CastSpellOnTarget( 53, target )

end

function DEFIAS_CUTPURSE.OnCombat( unit, _, _ )

    unit:RegisterEvent( DEFIAS_CUTPURSE.CastBackstab, 1100, 1 )

    unit:RegisterEvent( DEFIAS_CUTPURSE.CastBackstab, math.random( 2400, 7900 ), 0 )

end

RegisterUnitEvent( 94, 1, DEFIAS_CUTPURSE.OnCombat );