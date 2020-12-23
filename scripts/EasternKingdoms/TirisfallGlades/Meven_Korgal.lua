--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Tirisfall Glades: Meven Korgal
	Engine: A.L.E

	Credits:
	
	*) Trinity for texts and timers.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.
	
--]]

MEVEN_KORGAL = {}

function MEVEN_KORGAL.Yell( unit )
	if( unit:IsInCombat() == false )
	then
		local chance = math.random( 1, 5 );
		if( chance == 1 )
		then
			unit:SendChatMessage( 14, 0, "These undead atrocities will be destroyed!" );

		elseif( chance == 2 )
		then
			unit:SendChatMessage( 14, 0, "We must be vigilant to eradicate this plague!" );

		elseif( chance == 3 )
		then
			unit:SendChatMessage( 14, 0, "Keep up the good work.  This scourge will be cleansed!" );

		elseif( chance == 4 )
		then
			unit:SendChatMessage( 14, 0, "The Scarlet Crusade will scour these lands!" );

		else
			unit:SendChatMessage( 14, 0, "Let none with the foul taint of plague live!" );
        end
		unit:RemoveEvents();
		unit:RegisterEvent( MEVEN_KORGAL.Yell, math.random( 90000, 120000 ), 0 );
	end
end

function MEVEN_KORGAL.OnSpawn( unit )
	unit:RegisterEvent( MEVEN_KORGAL.Yell, math.random( 25000, 40000 ), 0 );
end

RegisterUnitEvent( 1667, 18, MEVEN_KORGAL.OnSpawn );