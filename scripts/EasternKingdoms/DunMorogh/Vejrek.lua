--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Dun Morogh
	Creature: Vejrek (6113)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--NPC_VEJREK = 6113;
--SPELL_SUNDER_ARMOR = 7386;

VEJREK = {};

function VEJREK.OnCombat( unit, event )

	if( event == 21 )
	then
		local target = unit:GetNextTarget();
	
		if( target == nil )
		then
			unit:RemoveAIUpdateEvent();
			return;
		end

		unit:CastSpellOnTarget( 7386, target );
		unit:ModifyAIUpdateEvent(  math.random( 4000, 8000 ) );
	else
		unit:RegisterAIUpdateEvent( 3000 );
	end	
end

RegisterUnitEvent( 6113, 1, VEJREK.OnCombat );
RegisterUnitEvent( 6113, 21, VEJREK.OnCombat );