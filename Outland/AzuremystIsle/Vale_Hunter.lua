--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Azuremyst Isle: Vale Hunter
	Engine: A.L.E

	Credits:

	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

VALE_HUNTER = {}

function VALE_HUNTER.OnSpawn( unit )

  local chance = math.random( 1, 2 );

	if( chance == 1 )
	then
		unit:SetModel( 17022 ); -- male

	else
		unit:SetModel( 16493 ); -- female
	end
end

RegisterUnitEvent( 17425, 18, VALE_HUNTER.OnSpawn );
