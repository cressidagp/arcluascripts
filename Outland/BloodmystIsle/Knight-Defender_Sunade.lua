--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Bloodmyst Isle: Knight-Defender Zunade (Bloodwatch)
	Engine: A.L.E

	Credits:

	*) Trinity for text.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

  enUS: "Tell me about the Defenders."

  esMX: "Cuentame sobre los Defensores."

--]]

ZUNADE = {}

function ZUNADE.OnHello( unit, _, plr )

	unit:GossipCreateMenu( 9172, plr, 0 );
	unit:GossipMenuAddItem( 0, "Tell me about the Defenders.", 1, 0 );
	unit:GossipSendMenu( plr );
end

function ZUNADE.OnSelect( unit, _, plr, id, selection )
	if( selection == 1 )
	then
		unit:GossipCreateMenu( 9206, plr, 0 );
		unit:GossipSendMenu( plr );
	end
end

RegisterUnitGossipEvent( 18030, 1, ZUNADE.OnHello );
RegisterUnitGossipEvent( 18030, 2, ZUNADE.OnSelect );
