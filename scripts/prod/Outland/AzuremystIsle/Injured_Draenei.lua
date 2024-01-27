--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Azuremyst Isle: Injured Draenei
	Engine: A.L.E

	Credits:

	*) Trinity for standstates.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

--UNIT_FIELD_FLAGS              = 0x0006 + 0x0035;
--UNIT_FLAG_IN_COMBAT           = 0x00080000;
--local UNIT_STAND_STATE_SIT    = 1;
--local UNIT_STAND_STATE_SLEEP  = 3;

INJURED_DRAENEI = {};

function INJURED_DRAENEI.OnSpawn( unit )

	unit:SetFlag( 0x0006 + 0x0035, 0x00080000 ); -- in combat

	unit:SetHealthPct( 15 ); -- Need to disable health regen here

	local chance = math.random( 1, 2 );
	local rand = math.random( 1, 4 );

	if( chance == 1 )
	then
    --unit:SetUInt32Value( 0x0006 + 0x004D, 1 ); -- sit
		unit:SetStandState( 1 );
	else
    --unit:SetUInt32Value( 0x0006 + 0x004D, 3 ); -- sleep
		unit:SetStandState( 3 );
	end

	if( rand == 1 )
	then
		unit:SetModel( 16490 );

	elseif( rand == 2 )
	then
		unit:SetModel( 16491  );

	elseif( rand == 3 )
	then
		unit:SetModel( 16492 );
		
	else
		unit:SetModel( 16493 );
	end
end

RegisterUnitEvent( 16971, 18, INJURED_DRAENEI.OnSpawn );
