--[[  www.ArcEmu.org
      Elwynn Forest and Tirisfall Glades: Elders
      Engine: A.L.E
      Credits: nil  
--]]

local SECRET = 666;

ELDERS = {}

function ELDERS.OnHelloOnSelect( unit, event, plr, id, intid, code )
		if( event == 1 )
		then
				unit:GossipCreateMenu( 13441, plr, 0 );
				unit:GossipMenuAddItem( 0, "I would like to whisper my secret code to you to receive Tyrael's Hilt.", 2, 1, "", 0 );
				unit:GossipSendMenu( plr );

		elseif( event == 2 )
		then
				if( intid == 2 )
				then
						if( code == ""..SECRET.."" )
						then
								plr:AddItem( 39656, 1 );
						else
								unit:SendChatMessage( 12, 0, "You're secret code is not a valid one..." );
						end
						
						plr:GossipComplete();
				end
		end
end

-- Stormwind: Ian Drake:
RegisterUnitGossipEvent( 29093, 1, ELDERS.OnHelloOnSelect );
RegisterUnitGossipEvent( 29093, 2, ELDERS.OnHelloOnSelect );

-- Undercity: Edward Cairn:
RegisterUnitGossipEvent( 29095, 1, ELDERS.OnHelloOnSelect );
RegisterUnitGossipEvent( 29095, 2, ELDERS.OnHelloOnSelect );
