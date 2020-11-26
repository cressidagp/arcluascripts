--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Elwynn Forest and Tirisfall Glades: Elders
	Engine: A.L.E
	Credits: nil
	
	enUS:
	
	CHAT[ 1 ] = "I would like to whisper my secret code to you to receive Tyrael's Hilt.";
	CHAT[ 2 ] = "You're secret code is not a valid one...";
	
	esMX:
	
	CHAT[ 1 ] = "Me gustaría susurrarte mi código secreto para que reciba Empuñadura de Tyrael.";
	CHAT[ 2 ] = "Tu código secreto no es válido...";
	
--]]

local SECRET = 666;

local CHAT = {}
CHAT[ 1 ] = "I would like to whisper my secret code to you to receive Tyrael's Hilt.";
CHAT[ 2 ] = "You're secret code is not a valid one...";

ELDERS = {}

function ELDERS.OnHelloOnSelect( unit, event, plr, id, intid, code )

		if( event == 1 )
		
		then
				unit:GossipCreateMenu( 13441, plr, 0 );
				
				unit:GossipMenuAddItem( 0, CHAT[ 1 ], 2, 1, "", 0 );
				
				unit:GossipSendMenu( plr );

		elseif( event == 2 )
		
		then
				if( intid == 2 )
				
				then
						if( code == ""..SECRET.."" )
						
						then
								plr:AddItem( 39656, 1 );
						else
								unit:SendChatMessage( 12, 0, CHAT[ 2 ] );
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
