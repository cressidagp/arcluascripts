--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Terokkar Forest: Lieutenant Gravelhammer
	Engine: A.L.E

  Credits:

  *) Trinity for texts, timers and waypoints.
  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

local TEXT_GRAVEL = {
[ 1 ] = "Rifling through the stacks of books and scrolls on the table, %s begins to examine one in particular with interest.";

[ 2 ] = "What?  What's this?!";
[ 3 ] = "That is not even remotely imaginable!";
[ 4 ] = "Looks like I picked a bad day to stop drinking.";
[ 5 ] = "How did this get missed?!";

[ 6 ] = "Cap'n, sir, we have a slight problem."; -- emote 1 from here to end

[ 7 ] = "As you say, sir.  It would appear that someone failed to mention to me that the druids at the Cenarion Thicket have been wiped out!";
[ 8 ] = "Bad news.  We've been hit again.  They're gone, but the front sentry tower is on fire.";
[ 9 ] = "One of our merchants has gone missing!";
[ 10 ] = "That group that recently arrived from Honor Hold -- they're mercs!  They're starting to stir up trouble.  Maybe I should have a talk with them?";
[ 11 ] = "One of our scouts is reporting that a shadowy group has moved into the ruins of Grangol'var Village.  Oops, this report is over a week old.";
[ 12 ] = "We have reports from a scout in the field that one of the Cenarion druids has been taken captive up at Firewing Point.";

[ 13 ] = "Aye, aye, sir.  Right away!"; -- emote 66
};

local TEXT_AURIC = {
{ 1, "At ease, lieutenant.  Go on.", 66 },
{ 2, "What is it now, Gravel?", 6 },
{ 3, "What else could possibly go wrong?", 6 },
{ 4, "Yes, lieutenant?  Report.", 1 },
{ 5, "That's troubling news indeed.  See to it that it's taken care of immediately!", 1 },
{ 6, "I don't have time for this, lieutenant.  Make sure that you handle it.", 1 },
{ 7, "If we're to help with that in any way we'll need more people.  Call some of the scouts in to help with that.", 1 },
{ 8, "Lieutenant, I want you to make that your top priority.  Notify anyone that you think can help.", 1 }
};

GRAVELHAMMER = {}

function GRAVELHAMMER.OutOfCombat( unit )

  local args = GRAVELHAMMER[ tostring( unit ) ]
  args.time = args.time - 1;

  if( args.action == 0 and args.time <= 0 )
  then
    unit:SendChatMessage( 16, 0, TEXT_GRAVEL[ 1 ] );
    args.action = 1;
    args.time = 11;

  elseif( args.action == 1 and args.time <= 0 )
  then
    unit:SendChatMessage( 12, 7, TEXT_GRAVEL[ math.random( 2, 5 ) ] );
    unit:Emote( 5, 0 );
    args.action = 2;
    args.time = 5;

  elseif( args.action == 2 and args.time <= 0 )
  then
    unit:SetMovementType( 0 ); -- start
    args.action = 3;
    args.time = 0;

  elseif( args.waypoint == true )
  then
      if( args.time <= 0 and args.action == 3 )
      then
        unit:Emote( 66, 0 );
        args.time = 3;
        args.action = 4;
        args.captain = unit:GetCreatureNearestCoords( -3006.83, 3995.62, 4.55, 18745 );
        args.captain:SetFacing( 3.587530 );

      elseif( args.time <= 0 and args.action == 4 )
      then
        unit:SendChatMessage( 12, 7, TEXT_GRAVEL[ 6 ] );
        unit:Emote( 1, 0 );
        args.time = 5;
        args.action = 5;

      elseif( args.time <= 0 and args.action == 5 )
      then
        local i = math.random( 1, 4 );
        args.captain:SendChatMessage( 12, 7, TEXT_AURIC[ i ][ 2 ] );
        args.captain:Emote( TEXT_AURIC[ i ][ 3 ], 0 );
        args.time = 6;
        args.action = 6;

      elseif( args.time <= 0 and args.action == 6 )
      then
        unit:SendChatMessage( 12, 7, TEXT_GRAVEL[ math.random( 7, 12 ) ] );
        args.time = 8;
        args.action = 7;

      elseif( args.time <= 0 and args.action == 7 )
      then
          local i = math.random( 5, 8 );
          args.captain:SendChatMessage( 12, 7, TEXT_AURIC[ i ][ 2 ] );
          args.captain:Emote( TEXT_AURIC[ i ][ 3 ], 0 );
          args.time = 8;
          args.action = 8;

      elseif( args.time <= 0 and args.action == 8 )
      then
          unit:SendChatMessage( 12, 7, TEXT_GRAVEL[ 13 ] );
          unit:Emote( 66, 0 );
          unit:RemoveEvents();
          args.captain:SetFacing( 4.537860 );
      end
  end
end

function GRAVELHAMMER.OnSpawn( unit )
  --local sUnit = tostring( unit )
  --GRAVELHAMMER[ sUnit ] = {}
  --local ref = GRAVELHAMMER[ sUnit ]
  --ref.time = 0;
  --ref.action = 0;
  --ref.waypoint = false;
  unit:RegisterAIUpdateEvent( math.random( 5000, 15000 ) );
end

function GRAVELHAMMER.OnReachWP( unit, _, waypointId )

  if( waypointId == 4 )
  then
    local args = GRAVELHAMMER[ tostring( unit ) ]
    args.waypoint = true;
    --unit:StopMovement( 35000 );
    unit:SetFacing( 0.259758 );

  elseif( waypointId == 7 )
  then
    unit:SetMovementType( 4 ); -- stop
    unit:SetFacing( 4.15388 );
    unit:RegisterAIUpdateEvent( math.random( 300000, 900000 ) );
    GRAVELHAMMER[ tostring( unit ) ] = nil;
  end
end

function GRAVELHAMMER.OnAIUpdate( unit )

  if( unit:IsInCombat() == false )
  then
    local sUnit = tostring( unit )
    GRAVELHAMMER[ sUnit ] = {}
    local ref = GRAVELHAMMER[ sUnit ]
    ref.time = 0;
    ref.action = 0;
    ref.waypoint = false;

    unit:RegisterEvent( GRAVELHAMMER.OutOfCombat, 1000, 0 );
    unit:RemoveAIUpdateEvent();
  end
end

RegisterUnitEvent( 18713, 18, GRAVELHAMMER.OnSpawn );
RegisterUnitEvent( 18713, 19, GRAVELHAMMER.OnReachWP );
RegisterUnitEvent( 18713, 21, GRAVELHAMMER.OnAIUpdate );
