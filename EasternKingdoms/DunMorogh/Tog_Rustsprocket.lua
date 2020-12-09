--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Dun Morogh: Tog Rustsprocket
	Engine: A.L.E

	Credits:

	*) Trinity for texts.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

TOG_RUSTSPROCKET = {}

function TOG_RUSTSPROCKET.OnHelloOnSelect( unit, event, plr, id, selection, code )

	if( event == 1 )
	then
		if( plr:GetPlayerClass() == "Warlock" and plr:GetLevel() >= 10 )
		then
			unit:GossipCreateMenu( 767, plr, 0 );
			unit:GossipMenuAddItem( 0, "What message?", 1, 0 );
			unit:GossipSendMenu( plr );
		else
			unit:GossipCreateMenu( 766, plr, 0 );
			unit:GossipSendMenu( plr );
		end

	else
		if( selection == 1 )
		then
			unit:GossipCreateMenu( 768, plr, 0 );
			unit:GossipSendMenu( plr );
		end
	end
end

RegisterUnitGossipEvent( 6119, 1, TOG_RUSTSPROCKET.OnHelloOnSelect );
RegisterUnitGossipEvent( 6119, 2, TOG_RUSTSPROCKET.OnHelloOnSelect );
