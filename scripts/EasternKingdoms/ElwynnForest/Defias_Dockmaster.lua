--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E	  

	Zone: Elwynn Forest
	Creature: Defias Dockmaster

 	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

--]]

--NPC_DEFIAS_DOCKMASTER	= 6846;
--NPC_DEFIAS_BODYGUARD = 6866;

DEFIAS_DOCKMASTER = {};

function DEFIAS_DOCKMASTER.OnCombat( unit, event )

	--
	-- on ai update
	--

	if( event == 21 )
	then
		DEFIAS_DOCKMASTER.hasSummoned = false;

	--
	-- on combat
	--
	
	else

		if( DEFIAS_DOCKMASTER.hasSummoned == false )
		then
			local bodyguard1 = unit:SpawnCreature( 6866, -9967.55, -135.956, 24.5909, 0.170326, 14, 60000, 2023, 0, 0, 1, 0 );
			local bodyguard2 = unit:SpawnCreature( 6866, -9958.49, -140.526, 24.2409, 4.0015, 14, 60000, 2023, 0, 0, 1, 0 );
			local bodyguard3 = unit:SpawnCreature( 6866, -9964.59, -140.567, 24.5105, 0.741307, 14, 60000, 2023, 0, 0, 1, 0 );

			DEFIAS_DOCKMASTER.hasSummoned = true;

			unit:RegisterAIUpdateEvent( 60000 );	
		end
	end
end

RegisterUnitEvent( 6846, 1, DEFIAS_DOCKMASTER.OnCombat );
RegisterUnitEvent( 6846, 21, DEFIAS_DOCKMASTER.OnCombat );