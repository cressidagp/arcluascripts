--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Icecrown Citadel: Lord Marrowgar
	Engine: A.L.E
	Credits: Trinity for sound ids, chats and text.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local SOUND = {
[ 1 ] = 16950; -- OnEnterZone
[ 2 ] = 16941; -- OnEnterCombat
[ 3 ] = 16946; -- OnCast: "Bonestorm"
[ 4 ] = 16947; -- OnCast: "Bonespike" 1
[ 5 ] = 16948; -- OnCast: "Bonespike" 2
[ 6 ] = 16949; -- OnCast: "Bonespike" 3
[ 7 ] = 16942; -- OnTargetDied 1
[ 8 ] = 16943; -- OnTargetDied 2
[ 9 ] = 16944; -- OnDeath
[ 10 ] = 16945; -- OnCast: "Berserk"

};

local CHAT = {
[ 1 ] = "This is the beginning AND the end, mortals. None may enter the master's sanctum!"
[ 2 ] = "The Scourge will wash over this world as a swarm of death and destruction!";
[ 3 ] = "BONE STORM!";
[ 4 ] = "Bound by bone!";
[ 5 ] = "Stick around!";
[ 6 ] = "The only escape is death!";
[ 7 ] = "More bones for the offering!";
[ 8 ] = "Languish in damnation!";
[ 9 ] = "I see... Only darkness.";
[ 10 ] = "THE MASTER'S RAGE COURSES THROUGH ME!";
};

local TEXT = {
[ 1 ] = "%s creates a whirling storm of bone!"; -- Bonestorm emote
};

-- Spells:
