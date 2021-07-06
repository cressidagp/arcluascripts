--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Silvermoon City
	Creature: Keyanomir and Minion

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	Developer notes: since summons spells are bugged or unimplemented in arcemu
					(if unit is creature) we dont have more choice than spawn them
					manually... at least for now.
--]]

--local UNIT_FIELD_SUMMONEDBY = 0x0006 + 0x0008;
--local UNIT_FIELD_CREATEDBY  = 0x0006 + 0x000A;

KEYANOMIR = {};

function KEYANOMIR.OnSpawnAndDeath( unit, event )

	--
	-- on spawn
	--

	if( event == 18 )
    then
        local minion = unit:SpawnCreature( 18232, 9715.04, -7311.68, 24.84, 4.8, 1604, 0, 0, 0, 0, 1, 0 );
		
        local guid = unit:GetGUID();

		-- set summoned by
        minion:SetUInt64Value( 0x0006 + 0x0008, guid );

		-- set created by
        minion:SetUInt64Value( 0x0006 + 0x000A, guid );

	--
	-- on death
	--

	else
		local minion = unit:GetCreatureNearestCoords( 9715.04, -7311.68, 24.84, 18232 );
		
		if( minion ~= nil )
		then
			minion:Despawn( 1000, 0 );
		end
	end
end

RegisterUnitEvent( 18231, 4, KEYANOMIR.OnSpawnAndDeath );
RegisterUnitEvent( 18231, 18, KEYANOMIR.OnSpawnAndDeath );