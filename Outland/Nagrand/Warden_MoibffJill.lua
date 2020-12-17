--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Negrand: Warden Moibff Jill (Telaar)
	Engine: A.L.E

  Credits:

  *) Trinity for texts, timers and waypoints.
  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

  enUS:

  [ 1 ] = "New posting going up! Adventurers and heroes, gather round the bulletin board!";
  [ 2 ] = "That should get Telaar the assistance it needs!";

  esMX:

  [ 1 ] = "¡Nueva publicación! ¡Aventureros y héroes, reuníos alrededor del tablero de anuncios!";
  [ 2 ] = "¡Eso debería brindarle a Telaar la ayuda que necesita!";

--]]

local TEXT = {
[ 1 ] = "New posting going up! Adventurers and heroes, gather round the bulletin board!";
[ 2 ] = "That should get Telaar the assistance it needs!";
};

MOIBFFJILL = {}

function MOIBFFJILL.DoStuff( unit )

	local args = MOIBFFJILL[ tostring( unit ) ]
	args.time = args.time - 1;

	if( args.action == 0 and args.time <= 0 )
	then
		unit:SendChatMessage( 12, 7, TEXT[ 1 ] );
		args.action = 1;
		args.time = 0;

	elseif( args.action == 1 and args.time <= 0 )
	then
		unit:SetUInt32Value( 0x0006 + 0x004D, 234 );
		args.action = 2;
		args.time = 15;

	elseif( args.action == 2 and args.time <= 0 )
	then
		unit:SetUInt32Value( 0x0006 + 0x004D, 0 );
		args.action = 3;
		args.time = 1;

	elseif( args.action == 3 and args.time <= 0 )
	then
		unit:SendChatMessage( 12, 7, TEXT[ 2 ] );
		unit:Emote( 5, 0 );
		args.action = 4;
	end
end

function MOIBFFJILL.OnReachWP( unit, _, waypointId )
	if( waypointId == 1 )
	then
		unit:SetFacing( 4.69494 );
		unit:RemoveEvents();

		-- destroy table with variables to recycle resources

		MOIBFFJILL[ tostring( unit ) ] = nil;

	elseif( waypointId == 2 )
	then
		local sUnit = tostring( unit )
		MOIBFFJILL[ sUnit ] = {}
		local ref = MOIBFFJILL[ sUnit ]
		ref.time = 2;
		ref.action = 0;
		unit:RegisterEvent( MOIBFFJILL.DoStuff, 1000, 0 );
	end
end

RegisterUnitEvent( 18408, 19, MOIBFFJILL.OnReachWP );