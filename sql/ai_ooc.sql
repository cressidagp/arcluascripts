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
(203,12544, 1800,'Skeletal Mage - Cast \'Frost Armor\''),
(474,12544, 1800,'Defias Rogue Wizard - Cast \'Frost Armor\''),
(476,12544, 1800,'Kobold Geomancer - Cast \'Frost Armor\''),
(507,12544, 1800,'Fenros - Cast \'Frost Armor\''),
(589,12544, 1800,'Defias Pillager - Cast \'Frost Armor\''),
(619,12544, 1800,'Defias Conjurer - Cast \'Frost Armor\''),
(881,12544, 1800,'Defias Surena Caledon - Cast \'Frost Armor\''),
(910,12544, 1800,'Defias Enchanter - Cast \'Frost Armor\''),
(1009,12544, 1800,'Mosshide Mistweaver - Cast \'Frost Armor\''),
(1539,12544, 1800,'Scarlet Neophyte - Cast \'Frost Armor\''),
(1867,12544, 1800,'Dalaran Apprentice - Cast \'Frost Armor\''),
(1889,12544, 1800,'Dalaran Wizard - Cast \'Frost Armor\''),
(1920,12544, 1800,'Dalaran Spellscribe - Cast \'Frost Armor\''),
(2018,12544, 1800,'Bloodfeather Sorceress - Cast \'Frost Armor\''),
(2076,12544, 1800,'Magistrate Henry Maleb - Cast \'Frost Armor\''),
(2319,12544, 1800,'Syndicate Wizard - Cast \'Frost Armor\''),
(2387,12544, 1800,'Hillsbrad Councilman - Cast \'Frost Armor\''),
(2567,12544, 1800,'Boulderfist Magus - Cast \'Frost Armor\''),
(2573,12544, 1800,'Drywhisker Surveyor - Cast \'Frost Armor\''),
(2591,12544, 1800,'Syndicate Magus - Cast \'Frost Armor\''),
(2761,12544, 1800,'Cresting Exile - Cast \'Frost Armor\''),
(3269,12544, 1800,'Razormane Geomancer - Cast \'Frost Armor\''),
(3851,12544, 1800,'Shadowfang Whitescalp - Cast \'Frost Armor\''),
(4712,12544, 1800,'Slitherblade Sorceress - Cast \'Frost Armor\''),
(4719,12544, 1800,'Slitherblade Sea Witch - Cast \'Frost Armor\''),
(4805,12544, 1800,'Blackfathom Sea Witch - Cast \'Frost Armor\''),
(6117,12544, 1800,'Highborne Lichling - Cast \'Frost Armor\''),
(6228,12544, 1800,'Dark Iron Ambassador - Cast \'Frost Armor\''),
(7437,12544, 1800,'Cobalt Mageweaver - Cast \'Frost Armor\''),
(7666,12544, 1800,'Archmage Allistarj - Cast \'Frost Armor\''),
(7667,12544, 1800,'Lady Sevine - Cast \'Frost Armor\''),
(11562,12544, 1800,'Drysnap Crawler - Cast \'Frost Armor\''),
(13096,12544, 1800,'Coldmine Explorer - Cast \'Frost Armor\''),
(13099,12544, 1800,'Irondeep Explorer - Cast \'Frost Armor\''),
(13540,12544, 1800,'Seasoned Irondeep Explorer - Cast \'Frost Armor\''),
(13541,12544, 1800,'Veteran Irondeep Explorer - Cast \'Frost Armor\''),
(13542,12544, 1800,'Champion Irondeep Explorer - Cast \'Frost Armor\''),
(13546,12544, 1800,'Seasoned Coldmine Explorer - Cast \'Frost Armor\''),
(13547,12544, 1800,'Veteran Coldmine Explorer - Cast \'Frost Armor\''),
(13548,12544, 1800,'Champion Coldmine Explorer - Cast \'Frost Armor\''),
(18664,12544, 1800,'Aged Dalaran Wizard - Cast \'Frost Armor\''),
(18934,12544, 1800,'Durnholde Mage - Cast \'Frost Armor\''),
(19947,12544, 1800,'Darkcrest Sorceress - Cast \'Frost Armor\''),
--(19952,12544, 1800,'Bloodmaul Geomancer - Cast \'Frost Armor\''),
(25073,12544, 1800,'Darkspine Siren - Cast \'Frost Armor\''),
(32373,12544, 1800,'Gatekeeper Melindra - Cast \'Frost Armor\''),
(32375,12544, 1800,'Warmage Yurias - Cast \'Frost Armor\''),
(32722,12544, 1800,'Warmage Lukems - Cast \'Frost Armor\''),
(32724,12544, 1800,'Warmage Mumplina - Cast \'Frost Armor\'');
