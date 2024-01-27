--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Azuremyst Isle: Vale Hunter
	Engine: A.L.E

	Credits:

	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.
	
	Developers note: since math.random( lowerValue, highgerValue) will always return the
	lowerValue in the first round, and there is only on Vale Hunter spawned in world
	we have to choose between doing this with hour pair, impar or go c++

--]]

VALE_HUNTER = {};

function VALE_HUNTER.OnSpawn( unit )

	--local chance = math.random( 1, 2 );

	local x = tonumber( os.date( "%H" ) );
	if( x % 2 == 0 ) -- x its par
	then
		unit:SetModel( 17022 ); -- male
	else
		unit:SetModel( 17023 ); -- female
	end
end

RegisterUnitEvent( 17425, 18, VALE_HUNTER.OnSpawn );
