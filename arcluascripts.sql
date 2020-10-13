--
-- The follows ai_agents are bugged so lets port them to lua:
-- (This will just remove what should be the "out of combat stuff", so the lua script will coexist with the "on combat" ai agent)
--

DELETE FROM `ai_agents` WHERE `entry` = 473 and `spell` = 1776; -- Elwynn Forest: Morgan the Collector cast "Gouge"
DELETE FROM `ai_agents` WHERE `entry` = 474 and `spell` = 12544; -- Elwynn Forest: Defias Rogue Wizard cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 476 and `spell` = 12544; -- Elwynn Forest: Kobold Geomancer cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 881 and `spell` = 12544; -- Elwynn Forest: Surena Caledon cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 1507 and `spell` = 12544; -- Tirisfall Glades: Scarlet Initiate cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 3204 and `spell` = 20798; -- Durotar: Gazzuz cast "Demon Skin"
DELETE FROM `ai_agents` WHERE `entry` = 3206 and `spell` = 324; -- Durotar: Voodoo Troll cast "Lighting Shield"
DELETE FROM `ai_agents` WHERE `entry` = 5822 and `spell` = 20798; -- Durotar: Feelweaver Scornn cast "Demon Skin"
DELETE FROM `ai_agents` WHERE `entry` = 5826 and `spell` = 324; -- Durotar: Geolord Mottle cast "Lighting Shield"

UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 474;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 476;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 881;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 1507;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 3204;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 3206;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 5822;
UPDATE `creature_proto` SET `auras` = '' WHERE `entry` = 5826;

--
-- The next npc_monstersay has been ported to lua:
--

DELETE FROM `npc_monstersay` WHERE `entry` = 466 and `event` = 0; -- Stormwind City: General Marcus Jonathan
DELETE FROM `npc_monstersay` WHERE `entry` = 3188 and `event` = 0; -- Durotar: Master Gadrin

--
-- This one will be handled in lua:
--

DELETE FROM `creature_spawns` WHERE `id` = 135619 and `entry` = 3289; -- Durotar: Minshinas Spirit

