--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest
	Creature: Morgan the Collector (473)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--NPC_MORGAN_THE_COLLECTOR = 473;
--SPELL_GOUGE = 1776;

MORGAN_THE_COLLECTOR = {};

function MORGAN_THE_COLLECTOR.OnCombat( unit, event )

	if( event == 21 )
	then
		local target = unit:GetNextTarget();
	
		if( target == nil )
		then
			unit:RemoveAIUpdateEvent();
			return;
		end

		unit:CastSpellOnTarget( 1776, target );
		unit:ModifyAIUpdateEvent(  math.random( 12, 14 ) * 1000 );
	else
		unit:RegisterAIUpdateEvent( 2000 );
	end	
end

RegisterUnitEvent( 473, 1, MORGAN_THE_COLLECTOR.OnCombat );
RegisterUnitEvent( 473, 21, MORGAN_THE_COLLECTOR.OnCombat );