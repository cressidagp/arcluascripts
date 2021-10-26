-- Can remeber what are theese
DELETE FROM `smart_scripts` WHERE `entryorguid` < 0;

-- Delete all except creatures scipts
DELETE FROM `smart_scripts` WHERE `source_type` != 0;

-- Delete all except SMART_EVENT_HEALTH_PCT
DELETE FROM `smart_scripts` WHERE `event_type` != 2;

-- Delete all except SMART_ACTION_FLEE_FOR_ASSIST
DELETE FROM `smart_scripts` WHERE `action_type` != 25;

-- Drop not needed columns
ALTER TABLE `smart_scripts`

	DROP PRIMARY KEY,

	/* #2 */
	DROP COLUMN `source_type`,
	
	/* #3 */
	DROP COLUMN `id`,
	
	/* #4 */
	DROP COLUMN `link`,

	/* #6 */
	DROP COLUMN `event_phase_mask`,

	/* #9 */
	DROP COLUMN `event_param1`,
	
	/* #11 */
	DROP COLUMN `event_param3`,
	
	/* #12 */
	DROP COLUMN `event_param4`,

	/* #13 */
	DROP COLUMN `event_param5`,
	
	/* #14 */
	DROP COLUMN `action_type`,

	/* #15 */
	DROP COLUMN `action_param1`,

	/* #16 */
	DROP COLUMN `action_param2`,

	/* #17 */
	DROP COLUMN `action_param3`,

	/* #18 */
	DROP COLUMN `action_param4`,

	/* #19 */
	DROP COLUMN `action_param5`,

	/* #20 */
	DROP COLUMN `action_param6`,

	/* #22 */
	DROP COLUMN `target_param1`,

	/* #23 */
	DROP COLUMN `target_param2`,

	/* #24 */
	DROP COLUMN `target_param3`,

	/* #25 */
	DROP COLUMN `target_param4`,

	/* #26 */
	DROP COLUMN `target_x`,

	/* #27 */
	DROP COLUMN `target_y`,

	/* #28 */
	DROP COLUMN `target_z`,

	/* #29 */
	DROP COLUMN `target_o`,
	
	/* #30 */
	DROP COLUMN `comment`;
	
	
--
-- Here we go...
--

ALTER TABLE `smart_scripts`

	CHANGE COLUMN `entryorguid` `entry` int(11) unsigned NOT NULL DEFAULT '0',
	
	CHANGE COLUMN `event_flags` `instance_mode` int(10) unsigned NOT NULL DEFAULT '4' AFTER `entry`, 
	
	ADD COLUMN `type` smallint(5) unsigned NOT NULL DEFAULT '3' AFTER `instance_mode`,
	
	CHANGE COLUMN `event_type` `event` int(11) unsigned NOT NULL DEFAULT '0',
	
	CHANGE COLUMN `event_chance` `chance` int(11) unsigned NOT NULL DEFAULT '0',
	
	ADD COLUMN `maxcount` int(11) unsigned NOT NULL DEFAULT '0' AFTER `chance`,
	
	ADD COLUMN `spell` int(11) unsigned NOT NULL DEFAULT '31365' AFTER `maxcount`,
	
	ADD COLUMN `spelltype` int(11) unsigned NOT NULL DEFAULT '10' AFTER `spell`,
	
	CHANGE COLUMN `event_param2` `floatMisc1` float NOT NULL DEFAULT '0',
	
	CHANGE COLUMN `target_type` `targettype_overwrite` int(11) NOT NULL DEFAULT '-1' AFTER `spelltype`,
	
	ADD COLUMN `cooldown_overwrite` int(11) NOT NULL DEFAULT '-1' AFTER `targettype_overwrite`,
	
	ADD COLUMN `Misc2` int(11) unsigned NOT NULL DEFAULT '0';


-- All modes
UPDATE `smart_scripts` SET `instance_mode` = 4 WHERE `instance_mode` = 1;

-- Just in case we already have done this
DROP TABLE IF EXISTS `ai_agents`;

RENAME TABLE `smart_scripts` TO `ai_agents`;