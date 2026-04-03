DROP TABLE IF EXISTS lua_ai, lua_creature_ai, lua_gameobject_ai, lua_quest_ai;

CREATE TABLE IF NOT EXISTS `lua_ai` (
  `entry` int(10) unsigned NOT NULL,
  `type` int(10) unsigned NOT NULL,
  `comment` varchar(255) DEFAULT '',
  PRIMARY KEY (`entry`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `lua_ai` (`entry`, `type`, `comment`) VALUES (474,1, 'Defias Renegade');
INSERT INTO `lua_ai` (`entry`, `type`, `comment`) VALUES (240,1, 'Marshal Dhugan');
INSERT INTO `lua_ai` (`entry`, `type`, `comment`) VALUES (1796,2, 'Anvil');

CREATE TABLE IF NOT EXISTS `lua_creature_ai` (
  `entry` int(10) unsigned NOT NULL,
  `idx` int(10) unsigned NOT NULL,
  `event_type` int(10) unsigned NOT NULL,
  `event_param1` int(10) unsigned NOT NULL,
  `event_param2` int(10) unsigned NOT NULL,
  `action_type` int(10) unsigned NOT NULL,
  `action_param1` int(10) unsigned NOT NULL,
  `comment` varchar(255) DEFAULT '',
  PRIMARY KEY (`entry`,`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Ejemplo: El NPC 12345 lanzará el hechizo 133 cada 8 segundos (8000ms)
INSERT INTO `lua_creature_ai` (`entry`, `idx`, `event_type`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `comment`) VALUES (474, 0, 0, 25000, 35000, 1, 12544, 'DefiasRenegade OOC Buff');
INSERT INTO `lua_creature_ai` (`entry`, `idx`, `event_type`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `comment`) VALUES (474, 1, 0, 10000, 15000, 2, 43, 'DefiasRenegade OOC Guardian');
INSERT INTO `lua_creature_ai` (`entry`, `idx`, `event_type`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `comment`) VALUES (240, 1, 0, 10000, 15000, 2, 2046, 'MarshalDhugan OOC Guardian');

CREATE TABLE IF NOT EXISTS `lua_gameobject_ai` (
  `entry` int(10) unsigned NOT NULL,
  `idx` int(10) unsigned NOT NULL,
  `event_type` int(10) unsigned NOT NULL,
  `event_param1` int(10) unsigned NOT NULL,
  `event_param2` int(10) unsigned NOT NULL,
  `action_type` int(10) unsigned NOT NULL,
  `action_param1` int(10) unsigned NOT NULL,
  `comment` varchar(255) DEFAULT '',
  PRIMARY KEY (`entry`,`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `lua_gameobject_ai` (`entry`, `idx`, `event_type`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `comment`) VALUES (1796, 0, 2, 25000, 35000, 1, 12544, `GO on spawn`);

CREATE TABLE IF NOT EXISTS `lua_quest_ai` (
  `entry` int(10) unsigned NOT NULL,
  `idx` int(10) unsigned NOT NULL,
  `event_type` int(10) unsigned NOT NULL,
  `event_param1` int(10) unsigned NOT NULL,
  `event_param2` int(10) unsigned NOT NULL,
  `action_type` int(10) unsigned NOT NULL,
  `action_param1` int(10) unsigned NOT NULL,
  `comment` varchar(255) DEFAULT '',
  PRIMARY KEY (`entry`,`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;