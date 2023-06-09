--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Global
	Creature: Demon Skin casters

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPC_MOGH_THE_UNDYING			= 1060
--local NPC_FROSTMANE_SHADOWCASTER		= 1124
--local NPC_DALARAN_CONJUROR			= 1915
--local NPC_GAZZUZ						= 3204
--local NPC_SANDFURY_SHADOWCASTER		= 5648
--local NPC_DEATHOLME_ACOLYTE			= 16315

--local SPELL_DEMON_SKIN = 20798;

OOC_DEMON_SKIN = {}

function OOC_DEMON_SKIN.CastBuff( unit, event )

	--
	-- on ai update
	--
	
	if event == 21 then
	
		if unit:IsInCombat() == false and unit:HasAura( 20798 ) == false then
		
			unit:FullCastSpell( 20798 )
			unit:ModifyAIUpdateEvent( 1800000 )
			
		end
	--
	-- on spawn
	--
	
	else
		local n = math.random( 3, 5 )
		unit:RegisterAIUpdateEvent( n * 1000 )	
	end	
end

-- Mogh the Undying:
RegisterUnitEvent( 1060, 18, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 1060, 21, OOC_DEMON_SKIN.CastBuff );

-- Frostmane Shadowcaster:
RegisterUnitEvent( 1124, 18, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 1124, 21, OOC_DEMON_SKIN.CastBuff );

-- Dalaran Conjuror:
RegisterUnitEvent( 1915, 18, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 1915, 21, OOC_DEMON_SKIN.CastBuff );

-- Gazzuz:
RegisterUnitEvent( 3204, 18, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 3204, 21, OOC_DEMON_SKIN.CastBuff );

-- Sandfury Shadowcaster:
RegisterUnitEvent( 5648, 18, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 5648, 21, OOC_DEMON_SKIN.CastBuff );

-- Deatholme Acolyte:
RegisterUnitEvent( 5648, 18, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 5648, 21, OOC_DEMON_SKIN.CastBuff );