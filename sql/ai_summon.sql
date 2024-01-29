DROP TABLE IF EXISTS `ai_summons`;

CREATE TABLE `ai_summons` (
  `summonerId` int(10) unsigned NOT NULL DEFAULT '0',
  `summonedId` int(10) unsigned NOT NULL DEFAULT '0',
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `orientation` float NOT NULL,
  `comment` text,
  PRIMARY KEY (`summonerId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='ai summon system';

/*Data for the table `ai_summons` */

insert  into `ai_summons`(`summonerId`,`summonedId`,`pos_x`,`pos_y`,`pos_z`,`orientation`,`comment`) values 
(6374,12922,-9466,-6.72,49.79,4.5,'Cylina Darkheart summon \'Imp Minion\''),
(18231,18232,9715.04,-7311.68,24.84,4.8,'Keyanomir summon \"Nimrida\"');