--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Azuremyst Isle: Ammen Vale Guardian
	Engine: A.L.E

	Credits:

	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

	Developers note: since math.random( lowerValue, highgerValue) will always return the
	lowerValue in the first round, and there is only on Vale Hunter spawned in world
	we have to choose between doing this with hour pair, impar or go c++

--]]

VALE_GUARDIAN = {}

function VALE_GUARDIAN.OnSpawn( unit )
	local x = tonumber( os.date( "%H" ) ); -- hour its par
	if( x % 2 == 0 )
	then
		local y = tonumber( os.date( "%M" ) );
		if( y % 2 == 0 ) -- minutes its par
		then
			unit:SetModel( 16789 ); -- male 1
		else
			unit:SetModel( 16791 ); -- female 1
		end

	else
		local y = tonumber( os.date( "%M" ) );
		if( y % 2 == 0 ) -- minutes its par
		then
			unit:SetModel( 16790 ); -- male 2
		else
			unit:SetModel( 16792 ); -- female 2
		end
	end
end

RegisterUnitEvent( 16921, 18, VALE_GUARDIAN.OnSpawn );