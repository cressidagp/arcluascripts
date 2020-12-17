--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Zangarmarsh: Timothy Daniels (Orebor Harborage)
	Engine: A.L.E

  Credits:

  *) Trinity for texts.
  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

TIMOTHY_DANIELS = {}

function TIMOTHY_DANIELS.OnHello( unit, _, plr )

		unit:GossipCreateMenu( 9238, plr, 0 );
		unit:GossipMenuAddItem( 1, "Let me browse your reagents and poison supplies.", 1, 0 );
    unit:GossipMenuAddItem( 0, "Specialist, eh? Just what kind of specialist are you, anyway?", 2, 0 );
    unit:GossipAddQuests( plr );
		unit:GossipSendMenu( plr );
end

function TIMOTHY_DANIELS.OnSelect( unit, _, plr, id, selection )
  if( selection == 1 )
  then
    plr:SendVendorWindow( unit );
  else
    unit:GossipCreateMenu( 9239, plr, 0 );
    unit:GossipSendMenu( plr );
  end
end

RegisterUnitGossipEvent( 18019, 1, TIMOTHY_DANIELS.OnHello );
RegisterUnitGossipEvent( 18019, 2, TIMOTHY_DANIELS.OnSelect );
