DARION_LH = {}

function DARION_LH.OnHello( unit, event, plr )
	unit:GossipCreateMenu( 15158, plr, 0 );
	unit:GossipMenuAddItem( 0, "What is the Ashen Verdict?", 1, 0 );
	unit:GossipSendMenu( plr );
end

function DARION_LH.OnSelect( unit, event, plr, id, selection, code )

    if( selection == 1 )
    then
        unit:GossipCreateMenu( 15159, plr, 0 );
        unit:GossipMenuAddItem( 0, "How can I learn to work Primordial Saronite?", 2, 0 );
        unit:GossipSendMenu( plr );

	elseif( selection == 2 )
	then
		unit:GossipCreateMenu( 15160, plr, 0 );
		unit:GossipSendMenu( plr );
	end
end

RegisterUnitGossipEvent( 37120, 1, DARION_LH.OnHello );
RegisterUnitGossipEvent( 37120, 2, DARION_LH.OnSelect );
