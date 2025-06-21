/* 
	ArcLuaScripts
	
	APPLY THIS FILE TO YOUR WORLD DATABASE IF YOU USE ARCLUASCRIPTS.
	
	-- FOR DB ONLY! --

*/

--
-- Settings:
--

SET @ID1 := 135619;	-- Durotar: Minshinas Spirit
SET @ID4 := 711234; -- Ruby Sanctum: Orb Carrier
SET @ID5 := 134428; -- Ruby Sanctum: Baltharus
SET @ID6 := 109436; -- Ruby Sanctum: Target Crystal
SET @ID7 := 200631; -- Ruby Sanctum: Halion Controller
SET @ID8 := 78482;	-- Terokkar Forest: Liutenant Gravelhammer
SET @ID9 := 77081;	-- Nagrand: Warden Moibff Jill
SET @ID10 := 66819; -- Azuremyst Isle: Zulduun

--
--
-- The next npc_monstersay has been ported to lua since its pointless to be casted on enter combat:
--
--

DELETE FROM `npc_monstersay` WHERE `event` = 0 and `entry` IN ( 295, 466, 794, 1395, 1402, 1405, 3188, 7917, 16483, 16502, 18408 );

/*
DELETE FROM `npc_monstersay` WHERE `entry` = 295 and `event` = 0; -- Elwynn Forest: Innkeeper Farley
DELETE FROM `npc_monstersay` WHERE `entry` = 794 and `event` = 0; -- Elwynn Forest: Matt
DELETE FROM `npc_monstersay` WHERE `entry` = 466 and `event` = 0; -- Stormwind City: General Marcus Jonathan
DELETE FROM `npc_monstersay` WHERE `entry` = 1395 and `event` = 0; -- Stormwind City: Ol Beasley
DELETE FROM `npc_monstersay` WHERE `entry` = 1402 and `event` = 0; -- Stormwind City: Topper McNabb
DELETE FROM `npc_monstersay` WHERE `entry` = 1405 and `event` = 0; -- Stormwind City: Morris Lawry
DELETE FROM `npc_monstersay` WHERE `entry` = 7917 and `event` = 0; -- Stormwind City: Brother Sarno
DELETE FROM `npc_monstersay` WHERE `entry` = 3188 and `event` = 0; -- Durotar: Master Gadrin
DELETE FROM `npc_monstersay` WHERE `entry` = 18408 and `event` = 0; -- Nagrand: Warden Moibff Jill
DELETE FROM `npc_monstersay` WHERE `entry` = 16502 and `event` = 0; -- Azuremyst Isle: Zalduun
DELETE FROM `npc_monstersay` WHERE `entry` = 16483 and `event` = 0; -- Azuremyst Isle: Draenei Survivor
*/

--
--
-- The next npc_gossip_textid had been ported to lua since arcemu database structure dont have support for them:
--
--

DELETE FROM `npc_gossip_textid` WHERE `creatureid` IN ( 3442, 6119, 6568, 8962, 8965, 16477, 16514, 16819, 17071, 17087 );

/*
DELETE FROM `npc_gossip_textid` WHERE `creatureid` = 3442; -- The Barrens: Sputtervalve
DELETE FROM `npc_gossip_textid` WHERE `creatureid` = 6119; -- Dun Morogh: Tog
DELETE FROM `npc_gossip_textid` WHERE `creatureid` = 6568; -- Tanaris: Vizzklick
DELETE FROM `npc_gossip_textid` WHERE `creatureid` = 8962; -- Redridge Mountains: Hilary
DELETE FROM `npc_gossip_textid` WHERE `creatureid` = 8965; -- Redridge Mountains: Shawn
DELETE FROM `npc_gossip_textid` WHERE `creatureid` = 16477; -- Azuremyst Isle: Proenitus
DELETE FROM `npc_gossip_textid` WHERE `creatureid` = 16514; -- Azuremyst Isle: Botanist Taerix
DELETE FROM `npc_gossip_textid` WHERE `creatureid` = 16819; -- Hellfire Peninsula: Danath Trollbane
DELETE FROM `npc_gossip_textid` WHERE `creatureid` = 17071; -- Azuremyst Isle: Technician Zhanaa
DELETE FROM `npc_gossip_textid` WHERE `creatureid` = 17087; -- Azuremyst Isle: Spirit of the Vale
*/

--
--
-- Frozen Halls: Forge of Souls
--
--

-- Bronjahm: monstersay OnCombat, OnDeath
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 36497;

/*
-- Corrupted Fragmented Soul:
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 36535;
*/

-- Devourer Of Souls
UPDATE `creature_spawns` SET `flags` = 64 WHERE `entry` = 36502;


--
--
-- Frozen Halls: Pit of Saron
--
--

-- Forgemaster Garfrost
UPDATE `creature_spawns` SET `movetype` = 2, `slot1item` = 49346 WHERE `entry` = 36494;

--
--
-- Frozen Halls: Halls of Reflections
--
--

-- Falric and Marwyn ( work but its the right invi type? )
UPDATE `creature_proto` SET `invisibility_type` = 5 WHERE `entry` IN ( 38112, 38113 );
UPDATE `creature_spawns` SET `flags` = 832 WHERE `entry` IN ( 38112, 38113 );


-- Lich King speed fix
UPDATE `creature_proto` SET `walk_speed` = 5  WHERE `entry` = 37226;

-- Lets remove some pre-spawned
DELETE FROM `creature_spawns` WHERE `id` = 141917 and `entry` = 37225; -- Uther
DELETE FROM `creature_spawns` WHERE `id` = 133989 and `entry` = 37158; -- Queldalar

-- Archmage Koreln
/*
DELETE FROM `creature_spawns` WHERE `id` = 200632 and `entry` = 37582;
INSERT INTO `creature_spawns` (`id`, `entry`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `movetype`, `displayid`, `faction`, `flags`, `bytes0`, `bytes1`, `bytes2`, `emote_state`, `npc_respawn_link`, `channel_spell`, `channel_target_sqlid`, `channel_target_sqlid_creature`, `standstate`, `death_state`, `mountdisplayid`, `slot1item`, `slot2item`, `slot3item`, `CanFly`, `phase`) 
VALUES (200632, 37582, 668, 5232.68, 1931.46, 707.78, 0.84, 0, 30685, 1770, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 35781, 0, 0, 0, 64);
*/

-- Dark Ranger Loralen
DELETE FROM `creature_spawns` WHERE `id` = 200633 and `entry` = 37779;

INSERT INTO `creature_spawns` (`id`, `entry`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `movetype`, `displayid`, `faction`, `flags`, `bytes0`, `bytes1`, `bytes2`, `emote_state`, `npc_respawn_link`, `channel_spell`, `channel_target_sqlid`, `channel_target_sqlid_creature`, `standstate`, `death_state`, `mountdisplayid`, `slot1item`, `slot2item`, `slot3item`, `CanFly`, `phase`) 
VALUES (200633, 37779, 668, 5232.68, 1931.46, 707.78, 0.84, 0, 30687, 1770, 0, 0, 0, 1, 433, 0, 0, 0, 0, 0, 0, 0, 34284, 34284, 34269, 0, 128);

-- Fix Jaina spawn pos ( testing no pre-spawned )
/*
UPDATE `creature_spawns` SET `position_x` = 5236.659, `position_y` = 1929.894, `position_z` = 707.7781, `orientation` = 0.8726646 WHERE `entry` = 37221 and `id` = 134006;
UPDATE `creature_spawns` SET `position_x` = 5236.659, `position_y` = 1929.894, `position_z` = 707.7781, `orientation` = 0.8726646 WHERE `entry` = 37221 and `id` = 134007;
*/

-- Fix Sylvana spawn pos and display ( testing pre-spawned )
UPDATE `creature_spawns` SET `displayid` = 30776 WHERE `entry` = 37223;
UPDATE `creature_spawns` SET `position_x` = 5236.667, `position_y` = 1929.906, `position_z` = 707.7781, `orientation` = 0.8377581 WHERE `entry` = 37223 and `id` = 134009;
UPDATE `creature_spawns` SET `position_x` = 5236.667, `position_y` = 1929.906, `position_z` = 707.7781, `orientation` = 0.8377581 WHERE `entry` = 37223 and `id` = 134010;

-- Starting to phase shift people for Alliance set
/*
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134006 and `entry` = 37221; -- Jaina (enemy to horde, big one)
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134007 and `entry` = 37221; -- Jaina (friend to alliance, big one)
*/

UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134252 and `entry` = 38112; -- Falric
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134254 and `entry` = 38113; -- Marwyn

UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 133416 and `entry` = 36723; -- General Frostborn

UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134319 and `entry` = 38177; -- Right semicircle: Shadowy Mercenary
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134266 and `entry` = 38172; -- Phantom Mage
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134277 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134298 and `entry` = 38175; -- Ghostly Priest
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134389 and `entry` = 38567; -- Phantom Hallucination
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134278 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134303 and `entry` = 38176; -- Tortured Rifleman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134316 and `entry` = 38177; -- Shadowy Mercenary
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134309 and `entry` = 38176; -- Tortured Rifleman

UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134286 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134291 and `entry` = 38175; -- Ghostly Priest
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134282 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134320 and `entry` = 38177; -- Shadowy Mercenary
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134307 and `entry` = 38176; -- Tortured Rifleman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134388 and `entry` = 38567; -- Phantom Hallucination
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134265 and `entry` = 38172; -- Phantom Mage
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134290 and `entry` = 38175; -- Ghostly Priest
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134301 and `entry` = 38176; -- Tortured Rifleman

UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134311 and `entry` = 38177; -- Left semicircle: Shadowy Mercenary
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134268 and `entry` = 38172; -- Phantom Mage
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134279 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134312 and `entry` = 38177; -- Shadowy Mercenary start from right
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134305 and `entry` = 38176; -- Tortured Rifleman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134391 and `entry` = 38567; -- Phantom Hallucination
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134287 and `entry` = 38175; -- Ghostly Priest
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134272 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134385 and `entry` = 38567; -- Phantom Hallucination

UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134386 and `entry` = 38567; -- Phantom Hallucination
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134281 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134295 and `entry` = 38175; -- Ghostly Priest
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134390 and `entry` = 38567; -- Phantom Hallucination
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134267 and `entry` = 38172; -- Phantom Mage
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134285 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134306 and `entry` = 38176; -- Tortured Rifleman
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134313 and `entry` = 38177; -- Shadowy Mercenary start from right
UPDATE `creature_spawns` SET `phase` = 64 WHERE `id` = 134299 and `entry` = 38175; -- Ghostly Priest

-- Starting to phase shift people for Horde set
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134009 and `entry` = 37223; -- Sylvanas (enemy to horde)
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134010 and `entry` = 37223; -- Sylvanas
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134253 and `entry` = 38112; -- Falric
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134255 and `entry` = 38113; -- Marwyn

UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 133417 and `entry` = 36723; -- General Frostborn

UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134315 and `entry` = 38177; -- Right semicircle: Shadowy Mercenary
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134269 and `entry` = 38172; -- Phantom Mage
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134280 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134292 and `entry` = 38175; -- Ghostly Priest
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134394 and `entry` = 38567; -- Phantom Hallucination
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134283 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134308 and `entry` = 38176; -- Tortured Rifleman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134321 and `entry` = 38177; -- Shadowy Mercenary
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134304 and `entry` = 38176; -- Tortured Rifleman

UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134276 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134294 and `entry` = 38175; -- Ghostly Priest
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134275 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134314 and `entry` = 38177; -- Shadowy Mercenary
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134302 and `entry` = 38176; -- Tortured Rifleman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134395 and `entry` = 38567; -- Phantom Hallucination
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134270 and `entry` = 38172; -- Phantom Mage
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134293 and `entry` = 38175; -- Ghostly Priest
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134310 and `entry` = 38176; -- Tortured Rifleman

UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134318 and `entry` = 38177; -- Left semicircle: Shadowy Mercenary
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134263 and `entry` = 38172; -- Phantom Mage
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134271 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134317 and `entry` = 38177; -- Shadowy Mercenary
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134299 and `entry` = 38176; -- Tortured Rifleman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134384 and `entry` = 38567; -- Phantom Hallucination
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134297 and `entry` = 38175; -- Ghostly Priest
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134284 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134392 and `entry` = 38567; -- Phantom Hallucination

UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134393 and `entry` = 38567; -- Phantom Hallucination
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134273 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134288 and `entry` = 38175; -- Ghostly Priest
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134387 and `entry` = 38567; -- Phantom Hallucination
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134264 and `entry` = 38172; -- Phantom Mage
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134274 and `entry` = 38173; -- Spectral Footman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134300 and `entry` = 38176; -- Tortured Rifleman
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134322 and `entry` = 38177; -- Shadowy Mercenary
UPDATE `creature_spawns` SET `phase` = 128 WHERE `id` = 134289 and `entry` = 38175; -- Ghostly Priest

-- Captain Falric
REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (38112, 0, 100, 0, 14, 'Falric', 'Men, women, and children... None were spared the master\'s wrath. Your death will be no different.', NULL, NULL, NULL, NULL);

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (38112, 5, 100, 0, 14, 'Falric', 'Marwyn, finish them...', NULL, NULL, NULL, NULL);

-- Captain Marwyn
REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (38113, 0, 100, 0, 14, 'Marwyn', 'Death is all that you will find here', NULL, NULL, NULL, NULL);

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (38113, 5, 100, 0, 14, 'Marwyn', 'Yes... Run... Run to meet your destiny... Its bitter, cold embrace, awaits you.', NULL, NULL, NULL, NULL);

-- Frostworn General
UPDATE `creature_spawns` SET `flags` = 64 WHERE `entry` = 36723;

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (36723, 0, 100, 0, 14, 'Frostworn General', 'You are not worthy to face the Lich King!', NULL, NULL, NULL, NULL);

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (36723, 5, 100, 0, 14, 'Frostworn General', 'Master, I have failed...', NULL, NULL, NULL, NULL);

--
--
-- Icecrown Citadel:
--
--

-- Hack! Since arcemu cand handle gossip vehicles
UPDATE `creature_proto` SET `vehicleid` = 0 WHERE `entry` = 37120; -- Hightlord Darion Mograine


--
--
-- Chamber of Aspects: The Ruby Sanctum
--
--

-- Xerex
UPDATE `creature_spawns` SET `flags` = 32768 WHERE `entry` = 40429;

-- General Zarithrian:
UPDATE `creature_spawns` SET `flags` = 64 WHERE `entry` = 39746;

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (39746, 0, 100, 0, 14, 'General Zarithrian', 'Alexstrasza has chosen capable allies.... A pity that I must END YOU!', NULL, NULL, NULL, NULL);

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (39746, 5, 100, 0, 14, 'General Zarithrian', 'HALION! I....', NULL, NULL, NULL, NULL);

-- Onyx Flamecaller: cast "Blast Nova"
REPLACE INTO `ai_agents` (`entry`, `instance_mode`, `type`, `event`, `chance`, `maxcount`, `spell`, `spelltype`, `targettype_overwrite`, `cooldown_overwrite`, `floatMisc1`, `Misc2`) 
VALUES (39814, 4, 4, 0, 70, 0, 74392, 7, 4, 17000, 0, 0);

-- Make sure only cast "Lava Gout" from lua script
DELETE FROM `ai_agents` WHERE `entry` = 39814 and `spell` = 74394;

-- Saviana Ragefire
UPDATE `creature_spawns` SET `flags` = 64 WHERE `entry` = 39747;

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) VALUES (39747, 0, 100, 0, 14, 'Saviana Ragefire', 'You will sssuffer for this intrusion!', NULL, NULL, NULL, NULL);

UPDATE `creature_spawns` SET `movetype` = 3 WHERE `entry` = 39747;

DELETE FROM `creature_waypoints` WHERE `spawnid` = 134427;

INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (134427, 1, 3155.51, 683.844, 95.0, 0, 768, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (134427, 2, 3151.07, 636.443, 79.540, 0, 768, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (134427, 3, 3151.07, 636.443, 78.649, 0, 768, 0, 0, 0, 0, 0, 0);

-- Baltharus the Warborn
UPDATE `creature_spawns` SET `flags` = 64 WHERE `entry` = 39751;

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (39751, 0, 100, 0, 14, 'Baltharus the Warborn', 'Ah, the entertainment has arrived.', NULL, NULL, NULL, NULL);

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (39751, 5, 100, 0, 14, 'Baltharus the Warborn', 'I... didn\'t see that coming....', NULL, NULL, NULL, NULL);

-- Burning Trees
UPDATE `gameobject_spawns` SET `State` = 3 WHERE `Entry` IN ( 203034, 203035, 203036, 203037 );

/*
UPDATE `creature_spawns` SET `channel_spell` = 76221 AND `channel_target_sqlid_creature` = @ID6 WHERE `id` = @ID5;
*/

-- Crystal Target ( fix the channeling effect )
UPDATE `creature_proto` SET `invisibility_type` = 0 WHERE `entry` = 26712; 

-- Halion the Destroyer
REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (39863, 0, 100, 0, 14, 'Halion the Destroyer', 'Your world teeters on the brink of annihilation. You will ALL bear witness to the coming of a new age of DESTRUCTION!', NULL, NULL, NULL, NULL);

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) 
VALUES (39863, 5, 100, 0, 14, 'Halion the Destroyer', 'Relish this victory, mortals, for it will be your last. This world will burn with the master\'s return!', NULL, NULL, NULL, NULL);

-- Halion Controller
UPDATE `creature_proto` SET `invisibility_type` = 0 WHERE `entry` = 40146;

DELETE FROM `creature_spawns` WHERE `id` = @ID7 AND `entry` = 40146;

INSERT INTO `creature_spawns` (`id`, `entry`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `movetype`, `displayid`, `faction`, `flags`, `bytes0`, `bytes1`, `bytes2`, `emote_state`, `npc_respawn_link`, `channel_spell`, `channel_target_sqlid`, `channel_target_sqlid_creature`, `standstate`, `death_state`, `mountdisplayid`, `slot1item`, `slot2item`, `slot3item`, `CanFly`, `phase`) 
VALUES (@ID7, 40146, 724, 3156.04, 533.27, 72.97, 0.00, 0, 169, 14, 33554688, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33);

-- Orb Carrier
DELETE FROM `creature_spawns` WHERE `id` = @ID4 AND `entry` = 40081;

INSERT INTO `creature_spawns` (`id`, `entry`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `movetype`, `displayid`, `faction`, `flags`, `bytes0`, `bytes1`, `bytes2`, `emote_state`, `npc_respawn_link`, `channel_spell`, `channel_target_sqlid`, `channel_target_sqlid_creature`, `standstate`, `death_state`, `mountdisplayid`, `slot1item`, `slot2item`, `slot3item`, `CanFly`, `phase`) 
VALUES (@ID4, 40081, 724, 3153.75, 533.19, 72.97, 0.00, 0, 169, 14, 33554688, 50331648, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 32);

DELETE FROM `vehicle_accessories` WHERE `creature_entry` = 40081 AND `seat` = 0;
INSERT INTO `vehicle_accessories` (`creature_entry`, `accessory_entry`, `seat`) VALUES (40081, 40083, 0);

DELETE FROM `vehicle_accessories` WHERE `creature_entry` = 40081 AND `seat` = 1;
INSERT INTO `vehicle_accessories` (`creature_entry`, `accessory_entry`, `seat`) VALUES (40081, 40100, 1);

-- Meteor Strike Mark
UPDATE `creature_proto` SET `rooted` = 1 WHERE `entry` = 40029;

-- Meteor Strike Crap
UPDATE `creature_proto` SET `rooted` = 1 WHERE `entry` IN ( 40041, 40042, 40043, 40044 );

-- Meteor Strike Flame
UPDATE `creature_proto` SET `rooted` = 1 WHERE `entry` = 40055;

-- Set debug mode off :P
UPDATE `creature_names` SET `male_displayid` = 11686, `female_displayid` = 11686 WHERE `entry` IN ( 40029, 40041, 40042, 40043, 40044, 40055 );
UPDATE `creature_spawns` SET `displayid` = 11686 WHERE `entry` IN ( 40146, 40081 );

--
--
-- This one will be handled in lua:
--
--

DELETE FROM `creature_spawns` WHERE `id` = @ID1 AND `entry` = 3289; -- Durotar: Minshinas Spirit


--
--
-- This table store waypoints of creatures not spawned in world:
--
--

DROP TABLE IF EXISTS `waypoints_lua`;

CREATE TABLE `waypoints_lua` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `wid` int(10) unsigned NOT NULL DEFAULT '0',
  `p_x` float NOT NULL DEFAULT '0',
  `p_y` float NOT NULL DEFAULT '0',
  `p_z` float NOT NULL DEFAULT '0',
  `p_o` float NOT NULL,
  `wtime` int(10) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `modelid` int(10) unsigned NOT NULL DEFAULT '0',
  `point_comment` text,
  PRIMARY KEY (`entry`,`wid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Creature waypoints';

-- Terokkar Forest: Liutenant Gravelhammer
UPDATE `creature_spawns` SET `movetype` = 4, `bytes2` = 0 WHERE `entry` = 18713;

DELETE FROM `creature_waypoints` WHERE `spawnid` = @ID8;

INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID8, 1, -3012.45, 3983.70, 3.11, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID8, 2, -3011.60, 3991.66, 3.44, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID8, 3, -3011.15, 3993.25, 4.08, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID8, 4, -3010.12, 3994.75, 4.46, 35000, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID8, 5, -3010.28, 3994.08, 4.46, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID8, 6, -3012.07, 3984.19, 3.11, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID8, 7, -3007.90, 3978.22, 3.11, 0, 0, 0, 0, 0, 0, 0, 0);

-- Nagrand: Warden Moibff Jill
UPDATE `creature_spawns` SET `movetype` = 2 WHERE `entry` = 18408;

DELETE FROM `creature_waypoints` WHERE `spawnid` = @ID9;

INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID9, 1, -2568.98, 7271.64, 15.49, 120000, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID9, 2, -2565.83, 7274.23, 15.48, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID9, 3, -2565.83, 7274.23, 15.55, 23000, 0, 0, 0, 0, 0, 0, 0);

-- Azuremyst Isle: Zulduun
UPDATE `creature_spawns` SET `movetype` = 2 WHERE `entry` = 16502;

DELETE FROM `creature_waypoints` WHERE `spawnid` = @ID10;

INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 1, -4113.68, -13762, 73.5694, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 2, -4110.51, -13765.2, 73.6102, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 3, -4107.71, -13772.5, 74.6982, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 4, -4102.51, -13772.3, 74.7185, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 5, -4099.89, -13768, 74.7256, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 6, -4102.44, -13763.8, 74.5717, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 7, -4125.6, -13762, 74.1406, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 8, -4129.88, -13764.2, 74.5865, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 9, -4135.57, -13762.7, 74.657, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 10, -4137.16, -13760, 74.6108, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 11, -4135.66, -13756.6, 74.5907, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 12, -4131.3, -13754.6, 74.6109, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 13, -4127.9, -13756.6, 74.2825, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 14, -4127.08, -13760.8, 74.2562, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 15, -4121.58, -13761.4, 73.5881, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 16, -4113.68, -13762, 73.5694, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 17, -4110.51, -13765.2, 73.6102, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 18, -4107.71, -13772.5, 74.6982, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 19, -4102.51, -13772.3, 74.7185, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 20, -4099.89, -13768, 74.7256, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 21, -4102.44, -13763.8, 74.5717, 12000, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 22, -4125.6, -13762, 74.1406, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 23, -4129.88, -13764.2, 74.5865, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 24, -4135.57, -13762.7, 74.657, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 25, -4137.16, -13760, 74.6108, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 26, -4135.66, -13756.6, 74.5907, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 27, -4131.3, -13754.6, 74.6109, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 28, -4127.9, -13756.6, 74.2825, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 29, -4127.08, -13760.8, 74.2562, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 30, -4121.58, -13761.4, 73.5881, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 31, -4113.68, -13762, 73.5694, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 32, -4110.51, -13765.2, 73.6102, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 33, -4107.71, -13772.5, 74.6982, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 34, -4102.51, -13772.3, 74.7185, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 35, -4099.89, -13768, 74.7256, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 36, -4102.44, -13763.8, 74.5717, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 37, -4125.6, -13762, 74.1406, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 38, -4129.88, -13764.2, 74.5865, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 39, -4135.57, -13762.7, 74.657, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 40, -4137.16, -13760, 74.6108, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 41, -4135.66, -13756.6, 74.5907, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 42, -4131.3, -13754.6, 74.6109, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 43, -4127.9, -13756.6, 74.2825, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 44, -4127.08, -13760.8, 74.2562, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 45, -4121.58, -13761.4, 73.5881, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 46, -4113.68, -13762, 73.5694, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 47, -4110.51, -13765.2, 73.6102, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 48, -4107.71, -13772.5, 74.6982, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 49, -4102.51, -13772.3, 74.7185, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 50, -4099.89, -13768, 74.7256, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 51, -4102.44, -13763.8, 74.5717, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 52, -4125.6, -13762, 74.1406, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 53, -4129.88, -13764.2, 74.5865, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 54, -4135.57, -13762.7, 74.657, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 55, -4137.16, -13760, 74.6108, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 56, -4135.66, -13756.6, 74.5907, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 57, -4131.3, -13754.6, 74.6109, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 58, -4127.9, -13756.6, 74.2825, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 59, -4127.08, -13760.8, 74.2562, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 60, -4121.58, -13761.4, 73.5881, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 61, -4113.68, -13762, 73.5694, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 62, -4110.51, -13765.2, 73.6102, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 63, -4107.71, -13772.5, 74.6982, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 64, -4102.51, -13772.3, 74.7185, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 65, -4099.89, -13768, 74.7256, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 66, -4102.44, -13763.8, 74.5717, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 67, -4125.6, -13762, 74.1406, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 68, -4129.88, -13764.2, 74.5865, 12000, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 69, -4135.57, -13762.7, 74.657, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 70, -4137.16, -13760, 74.6108, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 71, -4135.66, -13756.6, 74.5907, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 72, -4131.3, -13754.6, 74.6109, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 73, -4127.9, -13756.6, 74.2825, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 74, -4127.08, -13760.8, 74.2562, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 75, -4121.58, -13761.4, 73.5881, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 76, -4113.68, -13762, 73.5694, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 77, -4110.51, -13765.2, 73.6102, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 78, -4107.71, -13772.5, 74.6982, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 79, -4102.51, -13772.3, 74.7185, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 80, -4099.89, -13768, 74.7256, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 81, -4102.44, -13763.8, 74.5717, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 82, -4125.6, -13762, 74.1406, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 83, -4129.88, -13764.2, 74.5865, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 84, -4135.57, -13762.7, 74.657, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 85, -4137.16, -13760, 74.6108, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 86, -4135.66, -13756.6, 74.5907, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 87, -4131.3, -13754.6, 74.6109, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 88, -4127.9, -13756.6, 74.2825, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 89, -4127.08, -13760.8, 74.2562, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 90, -4121.58, -13761.4, 73.5881, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 91, -4113.68, -13762, 73.5694, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 92, -4110.51, -13765.2, 73.6102, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 93, -4107.71, -13772.5, 74.6982, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 94, -4102.51, -13772.3, 74.7185, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 95, -4099.89, -13768, 74.7256, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 96, -4102.44, -13763.8, 74.5717, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 97, -4125.6, -13762, 74.1406, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 98, -4129.88, -13764.2, 74.5865, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 99, -4135.57, -13762.7, 74.657, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 100, -4137.16, -13760, 74.6108, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 101, -4135.66, -13756.6, 74.5907, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 102, -4131.3, -13754.6, 74.6109, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 103, -4127.9, -13756.6, 74.2825, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 104, -4127.08, -13760.8, 74.2562, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID10, 105, -4121.58, -13761.4, 73.5881, 0, 0, 0, 0, 0, 0, 0, 0);

-- Azuremyst Isle: Draenei Survivor
UPDATE `creature_proto` SET `auras` = 35046 WHERE `entry` = 16483;
UPDATE `creature_spawns` SET `flags` = 4608 WHERE `entry` = 16483;

-- Azuremyst Isle: Injured Draenei
UPDATE `creature_spawns` SET `displayid` = 0, `flags` = 33024, `bytes0` = 0 WHERE `entry` = 16971;

--
--
--
--
-- DONT ADD MORE STUFF FROM HERE
--
--
--
--

DROP TABLE IF EXISTS `arcluascripts`;

CREATE TABLE `arcluascripts` (
  `version` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `arcluascripts`(`version`) values 
('2021-10-26_15-00_FleeAgents');