DROP TABLE IF EXISTS `ai_ooc`;

CREATE TABLE `ai_ooc` (
  `casterId` int(10) unsigned NOT NULL DEFAULT '0',
  `spellId` int(10) unsigned NOT NULL DEFAULT '0',
  `cooldown` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`casterId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='ai ooc system';

/*Data for the table `ai_summons` */

insert  into `ai_ooc`(`casterId`,`spellId`,`cooldown`,`comment`) values 
(474,12544, 1800,'Defias Rogue Wizard - Cast \'Frost Armor\''),
(476,12544, 1800,'Kobold Geomancer - Cast \'Frost Armor\'');