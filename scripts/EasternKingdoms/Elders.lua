--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest and Tirisfall Glades
	Creature: Elders
	
	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	"I would like to whisper my secret code to you to receive Tyrael's Hilt.",
	"You're secret code is not a valid one..."
	
	esMX locale:
	
	"Me gustaría susurrarte mi código secreto para que reciba Empuñadura de Tyrael.",
	"Tu código secreto no es válido..."
	
--]]

local SECRET = 69; -- The happiest number

local chat = {
"I would like to whisper my secret code to you to receive Tyrael's Hilt.",
"You're secret code is not a valid one..."
};

ELDERS = {};

function ELDERS.OnHelloOnSelect( unit, event, plr, id, selection, code )

	if( event == 1 )
	then
		unit:GossipCreateMenu( 13441, plr, 0 );
		unit:GossipMenuAddItem( 0, chat[ event ], 2, 1, "", 0 );
		unit:GossipSendMenu( plr );
		
	else
	
		if( selection == 2 )
		then
			if( code == ""..SECRET.."" )
			then
				plr:AddItem( 39656, 1 );
			else
				unit:SendChatMessage( 12, 0, chat[ event ] );
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
