--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Map: Global
	Creatures: Frost Armor casters

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPCID_SKELETAL_MAGE					= 203
--local NPCID_DEFIAS_ROGUE_WIZARD			= 474
--local NPCID_KOBOLD_GEOMANCER				= 476
--local NPCID_DEFIAS_PILLAGER				= 589
--local NPCID_DEFIAS_CONJURER				= 619
--local NPCID_SURENA_CALEDON				= 881
--local NPCID_DEFIAS_ENCHANTER				= 910
--local NPCID_MOSSHIDE_MISTWEAVER			= 1009
--local NPCID_SCARLET_NEOPHYTE				= 1539
--local NPCID_DALARAN_APPRENTICE			= 1867
--local NPCID_DALARAN_WIZARD				= 1889
--local NPCID_DALARAN_SPELLSCRIBE			= 1920
--local NPCID_BLOODFEATHER_SORCERESS		= 2018
--local NPCID_MAGISTRATE_HENRY_MALEB		= 2276
--local NPCID_SYNDICATE_WIZARD				= 2319
--local NPCID_HILLSBRAD_COUNCILMAN			= 2387
--local NPCID_BOULDERFIST_MAGUS				= 2567
--local NPCID_DRYWHISKER_SURVEYOR			= 2573
--local NPCID_CRESTING_EXILE				= 2761
--local NPCID_RAZORMANE_GEOMANCER			= 3269
--local NPCID_MURGKILL_LORD					= 4460
--local NPCID_COAST_CRAWL_DEEPSEER			= 5328
--local NPCID_HIGHBORNE_LICHLING			= 6117
--local NPCID_DARK_IRON_AMBASSADOR			= 6228
--local NPCID_COBALT_MAGEWEAVER				= 7437
--local NPCID_ARCHMAGE_ALLISTARJ			= 7666
--local NPCID_LADY_SEVINE					= 7667
--local NPCID_COLDMINE_EXPLORER				= 13096
--local NPCID_IRONDEEP_EXPLORER				= 13099
--local NPCID_SEASONED_IRONDEEP_EXPLORER	= 13540
--local NPCID_VETERAN_IRONDEEP_EXPLORER		= 13541
--local NPCID_CHAMPION_IRONDEEP_EXPLORER	= 13542
--local NPCID_SEASONED_COLDIMINE_EXPLORER	= 13546
--local NPCID_VETERAN_COLDIMINE_EXPLORER	= 13547
--local NPCID_CHAMPION_COLDMINE_EXPLORER	= 13548
--local NPCID_AGED_DALARAN_WIZARD			= 18664
--local NPCID_DURNHOLDE_MAGE				= 18934
--local NPCID_DARKSPINE_SIREN				= 25073
--local NPCID_GATEKEEPER_MELINDRA			= 32373

--local SPELL_FROST_ARMOR		= 12544

OOC_FROST_ARMOR = {}

function OOC_FROST_ARMOR.CastBuff( unit, event )

	--
	-- on ai update
	--
	
    if event == 21 then
	
        if unit:IsInCombat() == false and unit:HasAura( 12544 ) == false then
		
            unit:FullCastSpell( 12544 )
            unit:ModifyAIUpdateEvent( 1800000 )
			
        end
	
	--
	-- on spawn
	--
	
    else
		unit:RegisterAIUpdateEvent( 1000 )

    end
end

-- Sekeletal Mage:
RegisterUnitEvent( 203, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 203, 21, OOC_FROST_ARMOR.CastBuff );

-- Defias Rogue Wizard:
RegisterUnitEvent( 474, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 474, 21, OOC_FROST_ARMOR.CastBuff );

-- Kobold Geomancer:
RegisterUnitEvent( 476, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 476, 21, OOC_FROST_ARMOR.CastBuff );

-- Defias Pillager:
RegisterUnitEvent( 589, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 589, 21, OOC_FROST_ARMOR.CastBuff );

-- Defias Conjurer:
RegisterUnitEvent( 619, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 619, 21, OOC_FROST_ARMOR.CastBuff );

-- Surena Caledon:
RegisterUnitEvent( 881, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 881, 21, OOC_FROST_ARMOR.CastBuff );

-- Defias Enchanter:
RegisterUnitEvent( 910, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 910, 21, OOC_FROST_ARMOR.CastBuff );

-- Mosshide Mistweaver:
RegisterUnitEvent( 1009, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 1009, 21, OOC_FROST_ARMOR.CastBuff );

-- Scarlet Initiate:
RegisterUnitEvent( 1507, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 1507, 21, OOC_FROST_ARMOR.CastBuff );

-- Scarlet Neophyte:
RegisterUnitEvent( 1539, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 1539, 21, OOC_FROST_ARMOR.CastBuff );

-- Dalaran Apprentice:
RegisterUnitEvent( 1867, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 1867, 21, OOC_FROST_ARMOR.CastBuff );

-- Dalaran Wizard:
RegisterUnitEvent( 1889, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 1889, 21, OOC_FROST_ARMOR.CastBuff );

-- Dalaran Spellscribe:
RegisterUnitEvent( 1920, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 1920, 21, OOC_FROST_ARMOR.CastBuff );

-- Bloodfeather Sorceress:
RegisterUnitEvent( 2018, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 2018, 21, OOC_FROST_ARMOR.CastBuff );

-- Magistrate Henry Maleb:
RegisterUnitEvent( 2276, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 2276, 21, OOC_FROST_ARMOR.CastBuff );

-- Syndicate Wizard:
RegisterUnitEvent( 2319, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 2319, 21, OOC_FROST_ARMOR.CastBuff );

-- Hillsbrad Councilman:
RegisterUnitEvent( 2387, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 2387, 21, OOC_FROST_ARMOR.CastBuff );

-- Boulderfist Magus:
RegisterUnitEvent( 2267, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 2267, 21, OOC_FROST_ARMOR.CastBuff );

-- Drywhisker Surveyor:
RegisterUnitEvent( 2573, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 2573, 21, OOC_FROST_ARMOR.CastBuff );

-- Cresting Exile:
RegisterUnitEvent( 2761, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 2761, 21, OOC_FROST_ARMOR.CastBuff );

-- Razormane Geomancer:
RegisterUnitEvent( 3269, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 3269, 21, OOC_FROST_ARMOR.CastBuff );

-- Murkgill Lord:
RegisterUnitEvent( 4460, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 4460, 21, OOC_FROST_ARMOR.CastBuff );

-- Coast Crawl Deepseer:
RegisterUnitEvent( 5328, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 5328, 21, OOC_FROST_ARMOR.CastBuff );

-- Highborne Lichling:
RegisterUnitEvent( 6117, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 6117, 21, OOC_FROST_ARMOR.CastBuff );

-- Dark Iron Ambassador:
RegisterUnitEvent( 6228, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 6228, 21, OOC_FROST_ARMOR.CastBuff );

-- Cobalt Mageweaver:
RegisterUnitEvent( 7437, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 7437, 21, OOC_FROST_ARMOR.CastBuff );

-- Archmage Allistarj:
RegisterUnitEvent( 7666, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 7666, 21, OOC_FROST_ARMOR.CastBuff );

-- Lady Sevine
RegisterUnitEvent( 7667, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 7667, 21, OOC_FROST_ARMOR.CastBuff );

-- Coldmine Explorer
RegisterUnitEvent( 13096, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 13096, 21, OOC_FROST_ARMOR.CastBuff );

-- Irondeep Explorer
RegisterUnitEvent( 13099, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 13099, 21, OOC_FROST_ARMOR.CastBuff );

-- Seasoned Irondeep Explorer:
RegisterUnitEvent( 13540, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 13540, 21, OOC_FROST_ARMOR.CastBuff );

-- Veteran Irondeep Explorer:
RegisterUnitEvent( 13541, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 13541, 21, OOC_FROST_ARMOR.CastBuff );

-- Champion Irondeep Explorer:
RegisterUnitEvent( 13542, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 13542, 21, OOC_FROST_ARMOR.CastBuff );

-- Seasoned Coldmine Explorer:
RegisterUnitEvent( 13546, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 13546, 21, OOC_FROST_ARMOR.CastBuff );

-- Veteran Coldmine Explorer:
RegisterUnitEvent( 13547, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 13547, 21, OOC_FROST_ARMOR.CastBuff );

-- Coldmine Explorer:
RegisterUnitEvent( 13548, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 13548, 21, OOC_FROST_ARMOR.CastBuff );

-- Aged Dalaran Wizard:
RegisterUnitEvent( 18664, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 18664, 21, OOC_FROST_ARMOR.CastBuff );

-- Durnholde Mage:
RegisterUnitEvent( 18934, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 18934, 21, OOC_FROST_ARMOR.CastBuff );

-- Darkspine Siren:
RegisterUnitEvent( 25073, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 25073, 21, OOC_FROST_ARMOR.CastBuff );

-- Gatekeeper Melindra:
RegisterUnitEvent( 32373, 18, OOC_FROST_ARMOR.CastBuff );
RegisterUnitEvent( 32373, 21, OOC_FROST_ARMOR.CastBuff );


