--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest
	Creature: Morgan The Collector

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--NPC_MORGAN_THE_COLLECTOR = 473;
--SPELL_GOUGE = 1776;

--print( "Lua memory used before: "..gcinfo().." Kb." );

MORGAN_THE_COLLECTOR = {}

function MORGAN_THE_COLLECTOR.OnCombatOnDeath( unit, event )

	local sUnit = tostring( unit );
	
	local target = unit:GetNextTarget();
			
	if( target == nil )
	then
		unit:RemoveAIUpdateEvent();
		MORGAN_THE_COLLECTOR[ sUnit ] = nil;
		return;
	end
	
	-- on ai update
	if( event == 21 )
	then
	
		local vars = MORGAN_THE_COLLECTOR[ sUnit ];
	
		vars.gouge = vars.gouge - 1;
	
		if( vars.gouge <= 0 )
		then
			unit:CastSpellOnTarget( 1776, target );
			vars.gouge = math.random( 12, 14 );
		end

	-- on death
	elseif( event == 4 )
	then
		MORGAN_THE_COLLECTOR[ sUnit ] = nil;
	
	-- on combat
	else

		unit:RegisterAIUpdateEvent( 1000 );

		MORGAN_THE_COLLECTOR[ sUnit ] = {

		gouge = 2
		
		};
	
	end
end

RegisterUnitEvent( 473, 1, MORGAN_THE_COLLECTOR.OnCombatOnDeath );
RegisterUnitEvent( 473, 4, MORGAN_THE_COLLECTOR.OnCombatOnDeath );
RegisterUnitEvent( 473, 21, MORGAN_THE_COLLECTOR.OnCombatOnDeath );
--print( "Lua memory used after: "..gcinfo().." Kb." );