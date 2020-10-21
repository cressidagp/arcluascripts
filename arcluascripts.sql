/* 
	APPLY THIS FILE TO YOUR WORLD DATABASE IF YOU USE ARCLUASCRIPTS.
	
	For ArcEmu with A.L.E
	
	www.ArcEmu.org

*/

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

DELETE FROM `npc_monstersay` WHERE `entry` = 466 and `event` = 0; -- Stormwind City: General Marcus Jonathan
DELETE FROM `npc_monstersay` WHERE `entry` = 3188 and `event` = 0; -- Durotar: Master Gadrin

--
-- This one will be handled in lua:
--

DELETE FROM `creature_spawns` WHERE `id` = 135619 and `entry` = 3289; -- Durotar: Minshinas Spirit

--
-- I will use this table to store waypoints of creatures not spawned in world:
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

