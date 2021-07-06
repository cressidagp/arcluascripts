--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest
	Creature: Cylina Darkheart (6374)	
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.	

	Developer notes: since summons spells are bugged or unimplemented in arcemu
                     (if unit is creature) we dont have more choice than spawn them
                     manually... at least for now.
--]]

--local FACTION_ALLIANCE = 12;
--local UNIT_FIELD_SUMMONEDBY = 0x0006 + 0x0008;
--local UNIT_FIELD_CREATEDBY  = 0x0006 + 0x000A;

CYLINA_DARKHEART = {};

function CYLINA_DARKHEART.OnSpawnAndDeath( unit, event )
	
	--
	-- on spawn
	--
	
	if( event == 18 )
    then
		-- unit:CastSpell( 11939 ); -- cast "Summon Imp" (bugged spell on creature cast)

		local minion = unit:SpawnCreature( 12922, -9466, -6.72, 49.79, 4.5, 12, 0, 0, 0, 0, 1, 0 );

		local guid = unit:GetGUID();

		-- set summoned by
		minion:SetUInt64Value( 0x0006 + 0x0008, guid );

		-- set created by
		minion:SetUInt64Value( 0x0006 + 0x000A, guid );

	--
	-- on death
	--

	else
		local minion = unit:GetCreatureNearestCoords( -9466, -6.72, 49.79, 12922 );
		
		if( minion ~= nil )
		then
			minion:Despawn( 1000, 0 );
		end
	end
end

RegisterUnitEvent( 6374, 4, CYLINA_DARKHEART.OnSpawnAndDeath );
RegisterUnitEvent( 6374, 18, CYLINA_DARKHEART.OnSpawnAndDeath );
