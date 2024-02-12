--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Dun Morogh 
	Creature: Tog Rustsprocket (6119)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale: "What message?"
	
	esMX locale: "¿Qué mensaje?"

--]]

--local NPC_TOG_RUSTSPROCKET = 6119;

TOG_RUSTSPROCKET = {}

function TOG_RUSTSPROCKET.OnHelloOnSelect( unit, event, plr, textId, id, _ )

	--
	-- on hello
	--

	if event == 1 then
	
		if plr:GetPlayerClass() == "Warlock" and plr:GetLevel() >= 10 then
		
			unit:GossipCreateMenu( 767, plr, 0 )
			unit:GossipMenuAddItem( 0, "¿Qué mensaje?", 1, 0 )
			unit:GossipSendMenu( plr )
			
		else
		
			unit:GossipCreateMenu( 766, plr, 0 )
			unit:GossipSendMenu( plr )
			
		end
	
	--
	-- on select
	--
	
	else
	
		if( id == 1 ) then
		
			unit:GossipCreateMenu( 768, plr, 0 )
			unit:GossipSendMenu( plr )
			
		end
	end
end

RegisterUnitGossipEvent( 6119, 1, TOG_RUSTSPROCKET.OnHelloOnSelect );
RegisterUnitGossipEvent( 6119, 2, TOG_RUSTSPROCKET.OnHelloOnSelect );