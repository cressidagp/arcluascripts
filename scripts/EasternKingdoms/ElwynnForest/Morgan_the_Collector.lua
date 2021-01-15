--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest
	Creature: Morgan The Collector (794)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

MORGAN_THE_COLLECTOR = {}

function MORGAN_THE_COLLECTOR.CastGouge( unit )

	local target = unit:GetNextTarget();
	
	if( target == nil )
	then
		unit:WipeThreatList();
		unit:RemoveEvents();
		return;
	end

    unit:CastSpellOnTarget( 1776, target );

end

function MORGAN_THE_COLLECTOR.OnCombat( unit )

    unit:RegisterEvent( MORGAN_THE_COLLECTOR.CastGouge, 2000, 1 );

    unit:RegisterEvent( MORGAN_THE_COLLECTOR.CastGouge, math.random( 12000, 14000 ), 0 );

end

RegisterUnitEvent( 473, 1, MORGAN_THE_COLLECTOR.OnCombat );