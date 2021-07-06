--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Map: Eastern Kingdoms
	Creatures: Frost Armor casters

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPC_DEFIAS_ROGUE_WIZARD = 474;
--local NPC_KOBOLD_GEOMANCER = 476;
--local NPC_SURENA_CALEDON = 881;
--local NPC_SCARLET_INITIATE = 1507;

--local SPELL_FROST_ARMOR = 12544;

OOC_FROST_ARMOR = {};

function OOC_FROST_ARMOR.CastBuff( unit, event )

	--
	-- on ai update
	--
	
	if( event == 21 )
	then
		if( unit:IsInCombat() == false and unit:HasAura( 12544 ) == false )
		then
			unit:FullCastSpell( 12544 );
			unit:ModifyAIUpdateEvent( 1800000 );
		end
	
	--
	-- on spawn
	--
	
	else
		local n = math.random( 3, 5 );
		unit:RegisterAIUpdateEvent( n * 1000 );
	end
end

RegisterUnitEvent( 474, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 474, 21, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 476, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 476, 21, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 881, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 881, 21, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 1507, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 1507, 21, OOC_FROST_ARMOR.CastBuff );