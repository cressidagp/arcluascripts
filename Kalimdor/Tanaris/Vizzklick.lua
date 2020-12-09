--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Tanaris: Vizzklick
	Engine: A.L.E

	Credits:

	*) Trinity for texts.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

VIZZKLICK = {}

function VIZZKLICK.OnHelloOnSelect( unit, event, plr, id, selection, code )

	if( event == 1 )
	then
		unit:GossipCreateMenu( 1933, plr, 0 );
		unit:GossipMenuAddItem( 0, "I wish to browse your wares.", 1, 0 );
		unit:GossipSendMenu( plr );
	else
		if( selection == 1 )
		then
			plr:SendVendorWindow( unit );
		end
	end
end

RegisterUnitGossipEvent( 6568, 1, VIZZKLICK.OnHelloOnSelect );
RegisterUnitGossipEvent( 6568, 2, VIZZKLICK.OnHelloOnSelect );
