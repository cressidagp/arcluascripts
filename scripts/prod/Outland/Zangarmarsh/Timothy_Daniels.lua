--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Zangarmarsh
	Creature: Timothy Daniels (18019)
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
  
	enUS:
  
	[ 1 ] = "Let me browse your reagents and poison supplies."
	[ 2 ] = "Specialist, eh? Just what kind of specialist are you, anyway?"
  
	esMX:
  
	[ 1 ] = "Déjame explorar tus reactivos y suministros de veneno."
	[ 2 ] = "Especialista, ¿eh? ¿Qué tipo de especialista eres?"

--]]

--local NPC_TIMOTHY_DANIELS = 18019;

TIMOTHY_DANIELS = {};

function TIMOTHY_DANIELS.OnHelloOnSelect( unit, event, plr, id, selection )

	if( event == 1 )
	then
		unit:GossipCreateMenu( 9238, plr, 0 );
		unit:GossipMenuAddItem( 1, "Let me browse your reagents and poison supplies.", 1, 0 );
		unit:GossipMenuAddItem( 0, "Specialist, eh? Just what kind of specialist are you, anyway?", 2, 0 );
		unit:GossipAddQuests( plr );
		unit:GossipSendMenu( plr );
	
	else
	
		if( selection == 1 )
		then
			plr:SendVendorWindow( unit );
		else
			unit:GossipCreateMenu( 9239, plr, 0 );
			unit:GossipSendMenu( plr );
		end
	end
end

RegisterUnitGossipEvent( 18019, 1, TIMOTHY_DANIELS.OnHelloOnSelect );
RegisterUnitGossipEvent( 18019, 2, TIMOTHY_DANIELS.OnHelloOnSelect );