--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Azuremyst Isle: Zalduun
	Engine: A.L.E

	Credits:

	*) Trinity for spell id and timers.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

	enUS: "Oh no!  I'm losing this one!"

	esMX: "¡Oh no! ¡Estoy perdiendo a este!"

--]]

ZALDUUN = {};

function ZALDUUN.DoStuff( unit )

	local args = ZALDUUN[ tostring( unit ) ]
	args.time = args.time - 1;

	if( args.action == 0 and args.time <= 0 )
	then
		unit:SendChatMessage( 12, 7, "Oh no!  I'm losing this one!" );
		args.action = 1;
		args.time = 2;

	elseif( args.action == 1 and args.time <= 0 )
	then
		if( args.wp == 21 )
		then
			unit:SetFacing( 4.31173 );
		else
			unit:SetFacing( 0.157151 );
		end
		
		args.action = 2;
		args.time = 2;

	elseif( args.action == 2 and args.time <= 0 )
	then
		if( args.wp == 21 )
		then
			local target = unit:GetCreatureNearestCoords( -4103.75, -13766.79, 74.73, 16971 );
			unit:FullCastSpellOnTarget( 29170, target );
		else
			local target = unit:GetCreatureNearestCoords( -4126.75, -13765.20, 74.69, 16971 );
			unit:FullCastSpellOnTarget( 29170, target );
		end
		
		args.action = 3;
	end
end

function ZALDUUN.OnReachWP( unit, _, waypointId )

	if( waypointId == 21 or waypointId == 68 )
	then
		local sUnit = tostring( unit );
		ZALDUUN[ sUnit ] = {}
		local ref = ZALDUUN[ sUnit ]
		ref.time = 0;
		ref.action = 0;
		if( waypointId == 21 )
		then
			ref.wp = 21;
		else
			ref.wp = 68;
		end
		
		unit:RegisterEvent( ZALDUUN.DoStuff, 1000, 0 );

	elseif( waypointId == 22 or waypointId == 69 )
	then
		unit:RemoveEvents();
		
		-- destroy table with variables to recycle resources
	
		ZALDUUN[ tostring( unit ) ] = nil;

	end
end

RegisterUnitEvent( 16502, 19, ZALDUUN.OnReachWP );