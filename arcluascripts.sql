-- The follows ai_agents are bugged so lets port them to lua:
-- (This will just remove what should be the "out of combat stuff", so the lua script will coexist with the "on combat" ai agent)

DELETE FROM `ai_agents` WHERE `entry` = 474 and `spell` = 12544; -- Elwynn Forest: Defias Rogue Wizard cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 476 and `spell` = 12544; -- Elwynn Forest: Kobold Geomancer cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 881 and `spell` = 12544; -- Elwynn Forest: Surena Caledon cast "Frost Armor"
DELETE FROM `ai_agents` WHERE `entry` = 3204 and `spell` = 20798; -- Durotar: Gazzuz cast "Demon Skin"
DELETE FROM `ai_agents` WHERE `entry` = 3206 and `spell` = 324; -- Durotar: Voodoo Troll cast "Lighting Shield"
DELETE FROM `ai_agents` WHERE `entry` = 5822 and `spell` = 20798; -- Durotar: Feelweaver Scornn cast "Demon Skin"
DELETE FROM `ai_agents` WHERE `entry` = 5826 and `spell` = 324; -- Durotar: Geolord Mottle cast "Lighting Shield"