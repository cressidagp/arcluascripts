--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Tirisfall Glades
	Creature: Meven Korgal
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	esMX local:
	
--]]

--local NPC_MEVEN_KORGAL = 1667;

local yell = {
[ 1 ] = "These undead atrocities will be destroyed!",
[ 2 ] = "We must be vigilant to eradicate this plague!",
[ 3 ] = "Keep up the good work.  This scourge will be cleansed!",
[ 4 ] = "The Scarlet Crusade will scour these lands!",
[ 5 ] = "Let none with the foul taint of plague live!"
};

MEVEN_KORGAL = {}

function MEVEN_KORGAL.RandomYell( unit )

	if( unit:IsInCombat() == false )
	then
		unit:SendChatMessage( 14, 0, yell[ math.random( 1, 5 ) ] );
		unit:RegisterEvent( MEVEN_KORGAL.RandomYell, math.random( 90000, 120000 ), 0 );
	end
end

function MEVEN_KORGAL.OnSpawn( unit )
	unit:RegisterEvent( MEVEN_KORGAL.RandomYell, math.random( 25000, 40000 ), 1 );
end

RegisterUnitEvent( 1667, 18, MEVEN_KORGAL.OnSpawn );