/* 
	ArcLuaScripts
	
	APPLY THIS FILE TO YOUR WORLD DATABASE IF YOU USE ARCLUASCRIPTS.
	
	For ArcEmu with A.L.E
	
	www.ArcEmu.org

*/

--
-- Settings:
--

SET @ID1 := 135619;	-- Durotar: Minshinas Spirit
SET @ID2 := 136215;	-- Stormwind: Corbett Schneider
SET @ID3 := 5443;	-- Elwynn Forest: Matt

-- 
-- This will just remove what should be the "out of combat stuff", so the lua script will coexist with the "on combat" ai agent:
--

DELETE FROM `ai_agents` WHERE `entry` = 474 and `spell` = 12544; -- Elwynn Forest: Defias Rogue Wizard cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 476 and `spell` = 12544; -- Elwynn Forest: Kobold Geomancer cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 881 and `spell` = 12544; -- Elwynn Forest: Surena Caledon cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 1507 and `spell` = 12544; -- Tirisfall Glades: Scarlet Initiate cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 1544 and `spell` = 324; -- Tirisfall Glades: Vile Fin Minor Oracle cast "Lighting Shield"
DELETE FROM `ai_agents` WHERE `entry` = 3204 and `spell` = 20798; -- Durotar: Gazzuz cast "Demon Skin"
DELETE FROM `ai_agents` WHERE `entry` = 3206 and `spell` = 324; -- Durotar: Voodoo Troll cast "Lighting Shield"
DELETE FROM `ai_agents` WHERE `entry` = 5822 and `spell` = 20798; -- Durotar: Feelweaver Scornn cast "Demon Skin"
DELETE FROM `ai_agents` WHERE `entry` = 5826 and `spell` = 324; -- Durotar: Geolord Mottle cast "Lighting Shield"

UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 474;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 476;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 881;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 1507;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 1544;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 3204;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 3206;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 5822;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 5826;

--
-- The follows ai_agents are not working so lets port them to lua:
--

DELETE FROM `ai_agents` WHERE `entry` = 473 and `spell` = 1776; -- Elwynn Forest: Morgan the Collector dont want to cast "Gouge"

--
-- The next npc_monstersay has been ported to lua since its pointless to be casted on enter combat:
--

DELETE FROM `npc_monstersay` WHERE `entry` = 295 and `event` = 0; -- Elwynn Forest: Innkeeper Farley
DELETE FROM `npc_monstersay` WHERE `entry` = 466 and `event` = 0; -- Stormwind City: General Marcus Jonathan
DELETE FROM `npc_monstersay` WHERE `entry` = 794 and `event` = 0; -- Elwynn Forest: Matt
DELETE FROM `npc_monstersay` WHERE `entry` = 3188 and `event` = 0; -- Durotar: Master Gadrin
DELETE FROM `npc_monstersay` WHERE `entry` = 1395 and `event` = 0; -- Stormwind City: Ol Beasley
DELETE FROM `npc_monstersay` WHERE `entry` = 1402 and `event` = 0; -- Stormwind City: Topper McNabb
DELETE FROM `npc_monstersay` WHERE `entry` = 1405 and `event` = 0; -- Stormwind City: Morris Lawry
DELETE FROM `npc_monstersay` WHERE `entry` = 7917 and `event` = 0; -- Stormwind City: Brother Sarno

--
-- The Ruby Sanctum: monstersay OnCombat, On Death
--

-- General Zarithrian:

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) VALUES (39746, 0, 100, 0, 14, 'General Zarithrian', 'Alexstrasza has chosen capable allies.... A pity that I must END YOU!', NULL, NULL, NULL, NULL);
REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) VALUES (39746, 5, 100, 0, 14, 'General Zarithrian', 'HALION! I....', NULL, NULL, NULL, NULL);

-- Saviana Ragefire:

REPLACE INTO `npc_monstersay` (`entry`, `event`, `chance`, `language`, `type`, `monstername`, `text0`, `text1`, `text2`, `text3`, `text4`) VALUES (39747, 0, 100, 0, 14, 'Saviana Ragefire', 'You will sssuffer for this intrusion!', NULL, NULL, NULL, NULL);

--
-- This one will be handled in lua:
--

DELETE FROM `creature_spawns` WHERE `id` = @ID1 and `entry` = 3289; -- Durotar: Minshinas Spirit

--
-- This table store waypoints of creatures not spawned in world:
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

-- Stormwind City: Quest 333

DELETE FROM `creature_spawns` WHERE `id` = @ID2 and `entry` = 1433; -- Nobody wants two Corbett

REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 1, -8766.46, 716.756, 99.534, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 2, -8756.15, 726.392, 98.168, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 3, -8737, 700.497, 98.6993, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 4, -8752.06, 687.863, 100.43, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 5, -8762.08, 680.536, 101.71, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 6, -8772.76, 671.891, 103.092, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 7, -8772.77, 667.782, 103.433, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 8, -8773.28, 664.173, 103.274, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 9, -8768.03, 657.934, 103.604, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 10, -8761.15, 647.219, 103.86, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 11, -8759.45, 638.889, 103.316, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 12, -8758.04, 628.078, 102.069, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 13, -8761.21, 620.611, 99.9526, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 14, -8767.15, 612.279, 97.4617, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 15, -8777.32, 603.801, 97.0948, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 16, -8793.53, 591.544, 97.6605, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 17, -8798.26, 589.996, 97.3603, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 18, -8803.46, 592.612, 97.2519, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 19, -8808.24, 598.1, 96.8584, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 20, -8813.24, 605.857, 96.078, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 21, -8819.14, 613.825, 95.1532, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 22, -8821.64, 620.827, 94.3306, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 23, -8820.78, 625.793, 93.8221, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 24, -8816.41, 628.672, 94.1105, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 25, -8809.8, 631.78, 94.2287, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 26, -8801.11, 634.475, 94.2287, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 27, -8793.91, 634.537, 94.32, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 28, -8788.46, 635.605, 94.8966, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 29, -8783.56, 636.822, 97.2466, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 30, -8781.6, 636.871, 97.2231, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 31, -8781.74, 638.838, 97.2231, 0, 16000, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 32, -8781.78, 636.776, 97.2231, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 33, -8795.15, 634.195, 94.281, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 34, -8801.71, 633.134, 94.2287, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 35, -8817.86, 626.851, 93.9821, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 36, -8828.89, 622.524, 93.8863, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 37, -8840.16, 612.721, 92.8798, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 38, -8847.14, 604.377, 92.361, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 39, -8852.64, 595.577, 92.3749, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 40, -8863.15, 582.969, 93.4624, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 41, -8852.88, 572.995, 94.6873, 0, 21000, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 42, -8859.68, 580.578, 94.4911, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 43, -8862.99, 584.525, 93.1463, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 44, -8840.95, 607.213, 93.1652, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 45, -8837.18, 617.142, 93.0215, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 46, -8839.63, 632.013, 94.4465, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 47, -8845.29, 644.365, 96.2437, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 48, -8849.15, 651.583, 96.5339, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 49, -8851.61, 661.083, 97.0519, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 50, -8845.61, 665.968, 97.6387, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 51, -8837.4, 671.144, 98.1935, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 52, -8825.11, 679.115, 97.5357, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 53, -8830.59, 690.738, 97.3624, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 54, -8841.9, 715.206, 97.5506, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 55, -8842.83, 723.278, 97.2991, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 56, -8834.74, 728.967, 97.857, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 57, -8819.05, 738.299, 97.9257, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 58, -8803.79, 745.308, 97.5748, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 59, -8787.08, 745.688, 98.5113, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 60, -8773.18, 740.572, 99.4566, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 61, -8764.43, 735.376, 98.8859, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 62, -8758.34, 726.047, 98.2192, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 63, -8762.7, 720.631, 99.5337, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 64, -8767.64, 715.358, 99.5339, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 65, -8773.21, 714.807, 99.5339, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 66, -8777.76, 715.541, 99.5277, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 67, -8780.02, 717.419, 99.5341, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 68, -8776.45, 719.81, 101.502, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 69, -8773.68, 722.051, 104.155, 0, 0, 0, 0, 'Corbett Schneider');
REPLACE INTO `waypoints_lua` (`entry`, `wid`, `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags`, `modelid`, `point_comment`) VALUES (1433, 70, -8771.13, 724.301, 105.913, 0, 0, 0, 0, 'Corbett Schneider');

--
-- Elwynn Forest: Matt
--

UPDATE `creature_spawns` SET `position_x` = '-9387.13' WHERE `id` = @ID3 and `entry` = '794';
UPDATE `creature_spawns` SET `position_y` = '-117.859' WHERE `id` = @ID3 and `entry` = '794';
UPDATE `creature_spawns` SET `position_z` = '58.862' WHERE `id` = @ID3 and `entry` = '794';
UPDATE `creature_spawns` SET `orientation` = '2.818' WHERE `id` = @ID3 and `entry` = '794';

UPDATE `creature_spawns` SET `movetype` = '2' WHERE `entry` = '794'; -- Circle

DELETE FROM `creature_waypoints` WHERE `spawnid` = @ID3;

INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 1, -9387.45, -117.388, 58.8643, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 2, -9383.96, -114.881, 59.0825, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 3, -9380.15, -108.276, 59.2565, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 4, -9380.85, -101.69, 61.6828, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 5, -9387.7, -91.8522, 63.2071, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 6, -9390.82, -90.6401, 64.3475, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 7, -9407.41, -88.2923, 61.986, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 8, -9413.96, -87.8295, 61.0449, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 9, -9417.16, -87.5003, 60.4935, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 10, -9421.6, -80.924, 60.6919, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 11, -9423.16, -52.4566, 63.7918, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 12, -9420.55, -36.4409, 63.2905, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 13, -9421.89, -23.8332, 62.4391, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 14, -9429.02, 0.194481, 60.9577, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 15, -9430.42, 6.69886, 59.9552, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 16, -9433.05, 28.1498, 58.2238, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 17, -9432.95, 36.5776, 57.2988, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 18, -9432.74, 48.0679, 56.8554, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 19, -9436.52, 61.4402, 56.6267, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 20, -9423.23, 92.4316, 57.6826, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 21, -9417.55, 104.966, 59.5319, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 22, -9413.81, 111.076, 60.5474, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 23, -9410.36, 126.821, 59.9, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 24, -9416.29, 137.058, 59.0975, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 25, -9421.65, 142.983, 58.2709, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 26, -9429.23, 148.94, 56.5713, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 27, -9424.64, 136.645, 59.142, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 28, -9416.94, 128.225, 59.8461, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 29, -9408.01, 117.305, 60.681, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 30, -9404.78, 110.431, 60.1431, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 31, -9404.2, 99.8839, 59.0632, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 32, -9415.88, 87.0247, 57.4108, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 33, -9420.47, 83.6341, 56.8615, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 34, -9436.52, 69.2511, 56.504, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 35, -9440.95, 60.8308, 56.3084, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 36, -9430.78, 43.4414, 57.0939, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 37, -9419.33, 27.6532, 58.0076, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 38, -9403.12, 7.48618, 60.3003, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 39, -9393.43, -3.42091, 61.2166, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 40, -9380.71, -17.9166, 62.4581, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 41, -9379.76, -19.2639, 62.6256, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 42, -9366.55, -30.9657, 63.637, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 43, -9358.82, -43.8235, 65.2763, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 44, -9356.56, -49.4913, 66.0701, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 45, -9358.14, -71.0817, 64.598, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 46, -9358.82, -73.2935, 65.1737, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 47, -9364.59, -80.7694, 64.8708, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 48, -9367.94, -84.8975, 64.5525, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 49, -9374.87, -96.7034, 63.2868, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 50, -9377.46, -102.744, 61.8101, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 51, -9379.59, -109.527, 59.2667, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 52, -9383.48, -114.425, 59.0793, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_waypoints` (`spawnid`, `waypointid`, `position_x`, `position_y`, `position_z`, `waittime`, `flags`, `forwardemoteoneshot`, `forwardemoteid`, `backwardemoteoneshot`, `backwardemoteid`, `forwardskinid`, `backwardskinid`) VALUES (@ID3, 53, -9385.67, -116.133, 59.0943, 0, 0, 0, 0, 0, 0, 0, 0);

--
--
-- DONT ADD MORE STUFF FROM HERE
--
--

DROP TABLE IF EXISTS `arcluascripts`;

CREATE TABLE `arcluascripts` (
  `version` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert  into `arcluascripts`(`version`) values 
('2020-11-27_10-59_saviana_ragefire');