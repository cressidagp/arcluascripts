--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Tirisfall Glades
	Creature: Meven Korgal (1667);
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	esMX local:
	
--]]

--local NPC_MEVEN_KORGAL = 1667;

local CHAT = {
{ "These undead atrocities will be destroyed!" },
{ "We must be vigilant to eradicate this plague!" },
{ "Keep up the good work.  This scourge will be cleansed!" },
{ "The Scarlet Crusade will scour these lands!" },
{ "Let none with the foul taint of plague live!" }
};

MEVEN_KORGAL = {}

function MEVEN_KORGAL.Yell( unit )
	if( unit:IsInCombat() == false )
	then
		local chance = math.random( 1, 5 );
		if( chance == 1 )
		then
			unit:SendChatMessage( 14, 0, CHAT[ chance ] );

		elseif( chance == 2 )
		then
			unit:SendChatMessage( 14, 0, CHAT[ chance ] );

		elseif( chance == 3 )
		then
			unit:SendChatMessage( 14, 0, CHAT[ chance ] );

		elseif( chance == 4 )
		then
			unit:SendChatMessage( 14, 0, CHAT[ chance ] );

		else
			unit:SendChatMessage( 14, 0, CHAT[ chance ] );
        end
		unit:RemoveEvents();
		unit:RegisterEvent( MEVEN_KORGAL.Yell, math.random( 90000, 120000 ), 0 );
	end
end

function MEVEN_KORGAL.OnSpawn( unit )
	unit:RegisterEvent( MEVEN_KORGAL.Yell, math.random( 25000, 40000 ), 0 );
end

RegisterUnitEvent( 1667, 18, MEVEN_KORGAL.OnSpawn );