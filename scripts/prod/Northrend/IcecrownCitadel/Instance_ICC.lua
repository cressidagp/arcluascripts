--
-- WARNING!
-- onPlayerEnter trigger when plr enter instance using the Entrance
-- wont trigger if plr enters world inside the instance
--

local ICC = {}

--local OBJECT_END = 0x0006
--local GAMEOBJECT_LEVEL = 0x0006 + 0x000A
--local GAMEOBJECT_BYTES_1 = 0x0006 + 0x000B
--local EMOTE_ONESHOT_TALK = 1
--local EMOTE_ONESHOT_EXCLAMATION = 5
--local EMOTE_ONESHOT_SHOUT = 22
--local EMOTE_ONESHOT_POINT_NOSHEATHE = 397

local object_link = {

{ 36612, 201910 }, -- Marrowgar, Icewall R
{ 36612, 201911 }, -- Marrowgar, Icewall L
{ 36612, 201563 }, -- Marrowgar, Oratory of the Damned Entrance
{ 36612, 202245 }, -- Marrowgar, Transporter
{ 36855, 202243 }, -- Lady Deathwhisper, Transporter at "Rampart of Skull"
{ 36855, 202244 }, -- Lady Deathwhisper, Transporter at "Deatbringer Rise"
{ 37813, 201825 }, -- Saurfang: Door
{ 37813, 202235 }, -- Saurfang: Transporter at "Upper Reaches"
{ 36626, 201613 }, -- Festergut
{ 36627, 201614 }  -- Rotface

}

-- GameObject entry for Scourge Transporters:
local scourge_ports = { 202246, 202245, 202244, 202243, 202242, 202235, 202223 }

-- GameObject entry for Spirit Alarms:
local spirit_alarms = { 201814, 201815, 201816, 201817 }

local tele_coords = {

{ 1, 70781, -17.1928, 2211.44, 30.1158, 0 },
{ 2, 70856, -503.62, 2211.47, 62.8235, 0 },
{ 3, 70857, -615.145, 2211.47, 199.972, 0 },
{ 4, 70858, -549.131, 2211.29, 539.291, 0 },
{ 5, 70859, 4198.42, 2769.22, 351.065, 0 },
{ 6, 70861, 4356.58, 2565.75, 220.4, 0 },
{ 7, 70860, 528.39, -2124.84, 1040.86, 0 }

}

local npc_entry = { 

{ 37903, 37904 },
{ 37935, 37936 }

}

local spawn_npc = { 

{ -529.35, 2226.35, 539.29, 5.88 },
{ -521.22, 2233.37, 539.29, 5.42 }

}

local go_entry = { 

{ 201868, 201868 },
{ 201886, 201887 }

}

local spawn_go = { 

{ -532.78, 2228.43, 539.29, 2.49 },
{ -524.57, 2236.97, 539.29, 2.23 }

}

-- disabled due currently cant spawn so far away
--local sindragosaSpawn = { 4818.700, 2483.710, 287.0650, 3.089233 }

function ICC.onPlayerEnter( iid, plr )

	-- Developer notes: i discover argument iid isnt safe. If a player enter the function triggers and variables
	-- are created. But then if player from opposite faction enter variables will be created with the same iid number.
	-- So will have no more choice than spend resources getting instance id again.
	local iid = plr:GetInstanceID()

	-- create protected variables
	if ICC[ iid ] == nil
	then
		ICC[ iid ] = {

			marrowgarIsDone = false,
			marrowgarHasTalked = false,
			deathwhisperIsDone = false,
			saurfangIsDone = false,
			putricideIsDone = false,
			princeCouncilIsDone = false,
			bloodQueenIsDone = false,
			dreamwalkerIsDone = false,
			rimefangIsDone = false,
			spinestalkerIsDone = false,
			sindragosaIsDone = false

		}

		--
		-- @DarkAngel39 instance progression system
		--
		local string_data = {}

		-- this table stores entry(s) and spawnid(s)
		local result = CharDBQuery( "SELECT killed_npc_guids FROM instances WHERE id = "..iid.."; " )

		if result ~= nil
		then
			local colcount = result:GetColumnCount()

			repeat

				for col = 0, colcount - 1, 1 do

					string_data[ col ] = result:GetColumn( col ):GetString()

					local b1 = string.find( string_data[ col ], "36612" )
					local b2 = string.find( string_data[ col ], "36855" )
					local b3 = string.find( string_data[ col ], "37813" )
					local b4 = string.find( string_data[ col ], "36678" )
					local b5 = string.find( string_data[ col ], "37970" )
					local b6 = string.find( string_data[ col ], "37955" )
					local b7 = string.find( string_data[ col ], "36789" )
					local b8 = string.find( string_data[ col ], "37533" )
					local b9 = string.find( string_data[ col ], "37534" )
					local b10 = string.find( string_data[ col ], "36853" )

					if b1 ~= nil then 

						ICC[ iid ].marrowgarIsDone = true
						ICC[ iid ].marrowgarHasTalked = true

					end

					if b2 ~= nil then ICC[ iid ].deathwhisperIsDone = true end
					if b3 ~= nil then ICC[ iid ].saurfangIsDone = true end
					if b4 ~= nil then ICC[ iid ].putricideIsDone = true end
					if b5 ~= nil then ICC[ iid ].princeCouncilIsDone = true end
					if b6 ~= nil then ICC[ iid ].bloodQueenIsDone = true end
					if b7 ~= nil then ICC[ iid ].dreamwalkerIsDone = true end
					if b8 ~= nil then ICC[ iid ].rimefangIsDone = true end
					if b9 ~= nil then ICC[ iid ].spinestalkerIsDone = true end
					if b10 ~= nil then ICC[ iid ].sindragosaIsDone = true end

				end

			until result:NextRow() ~= true

			--print( ICC[ iid ].marrowgarIsDone )
			--print( ICC[ iid ].deathwhisperIsDone )
			--print( ICC[ iid ].saurfangIsDone )
			--print( ICC[ iid ].putricideIsDone )
			--print( ICC[ iid ].princeCouncilIsDone )
			--print( ICC[ iid ].bloodQueenIsDone )
			--print( ICC[ iid ].dreamwalkerIsDone )
			--print( ICC[ iid ].rimefangIsDone )
			--print( ICC[ iid ].spinestalkerIsDone )
			--print( ICC[ iid ].sindragosaIsDone )

		end

	end

	-- add debuff: Chill of the Throne
	if plr:HasAura( 69127 ) == false then

		--SetDBCSpellVar( 69127, "c_is_flags", 0x01000 )
	
		plr:CastSpell( 69127 )

	end
	
	local plrTeam = plr:GetTeam()

	-- Alliance plr:
	if plrTeam == 0 and not plr:HasAura( 73828 ) then 

		-- add buff: Strenght of the Wrynn
		plr:CastSpell( 73828 )

		-- set Alliance Phase
		plr:CastSpell( 55774 )

	-- Horde plr:
	elseif plrTeam == 1 and not plr:HasAura( 73822 ) then

		-- add buff: Hellscreams Warsong
		plr:CastSpell( 73822 )

		-- set Horde Phase
		plr:CastSpell( 55773 )

	end
	
	-- store for further use
	ICC[ iid ].teamInInstance = plrTeam

end

-- dont move this function to bottom (creates a nil variable error)
function ICC.onGameObjectPush( iid, go )

	local entry = go:GetEntry()

	-- Fixed some nil errors ( go(s) spawned before variables created )
	if entry == 202315 or entry == 202316 or entry == 202317 or entry == 202318 then return end

	-- Teleporter at Lights Hammer
	if entry == 202242 and go:GetByte( 0x0006 + 0x000B, 0 ) ~= 0 then

		go:Activate()

	end
	
	local iid = go:GetInstanceID()
	
	-- Lady Deathwhisper Elevator
	if entry == 202220 then
	
		if ICC[ iid ].deathwhisperIsDone == false then
		
			-- disable
			go:SetUInt32Value( 0x0006 + 0x000A, 1 )
			
		else
		
			-- enable
			go:SetUInt32Value( 0x0006 + 0x000A, 0 )
			
		end
	
	end
	
	for b = 1, #object_link do

		if ICC[ iid ].marrowgarIsDone == true then

			if entry == object_link[ b ][ 2 ] and object_link[ b ][ 1 ] == 36612 and go:GetByte( 0x0006 + 0x000B, 0 ) ~= 0 then

				go:Activate()

			end

		elseif ICC[ iid ].deathwhisperIsDone == true then

			if entry == object_link[ b ][ 2 ] and object_link[ b ][ 1 ] == 36855 and go:GetByte( 0x0006 + 0x000B, 0 ) ~= 0 then

				go:Activate()

			end
			
		elseif ICC[ iid ].saurfangIsDone == true then
		
			if entry == object_link[ b ][ 2 ] and object_link[ b ][ 1 ] == 37813 and go:GetByte( 0x0006 + 0x000B, 0 ) ~= 0 then
			
				go:Activate()
				
			end

		end

	end

end

function ICC.onCreatureLoad( iid, creature )

	local entry = creature:GetEntry()

	local iid = creature:GetInstanceID()

	if entry == 36612 then

		ICC[ iid ].marrowgarHasTalked = false

	elseif entry == 36855 then
	
		ICC[ iid ].deathwhisperIsDone = false
	
	elseif entry == 37813 then
	
		ICC[ iid ].saurfangIsDone = false
	
	elseif entry == 37187 or entry == 37200 then
	
		if ICC[ iid ].saurfangIsDone == true then
		
			local t = 0
			
			local f = 0
			
			local p = creature:GetPhase()
			
			if p == 128 then
			
				t = 1
				
				f = 1732
			
			else
			
				t = 2
				
				f = 1735
				
			end
		
			-- Spawn vendors and tents at Deathbringer Rise
			for i = 1, 2, 1 do
		
				creature:SpawnCreature( npc_entry[ t ][ i ], spawn_npc[ i ][ 1 ], spawn_npc[ i ][ 2 ], spawn_npc[ i ][ 3 ], spawn_npc[ i ][ 4 ], f, 0, 1, 2, 3, p )
		
				creature:SpawnGameObject( go_entry[ t ][ i ], spawn_go[ i ][ 1 ], spawn_go[ i ][ 2 ], spawn_go[ i ][ 3 ], spawn_go[ i ][ 4 ], 0, 100, p )
			
			end
		
		end
	
	elseif entry == 36853 then
	
		ICC[ iid ].sindragosaHasSpawned = true
	
	end

end

function ICC.onCreatureDeath( iid, victim, killer )
	
	local entry = victim:GetEntry()

	local iid = killer:GetInstanceID()

	-- Damned
	if entry == 37011 then
	
		local damnedSpawnId = victim:GetSpawnId()
		
		if damnedSpawnId == 113434 or damnedSpawnId == 113440 then
		
			ICC_SetData( victim, 1, 1 )
		
		end

	-- Lord Marrowgar
	elseif entry == 36612 then

		ICC[ iid ].marrowgarIsDone = true

	-- Lady Deathwhisper
	elseif entry == 36855 then

		ICC[ iid ].deathwhisperIsDone = true
		
		local elevator = victim:GetGameObjectNearestCoords( -644.4, 2211.56, 51.9, 202220 )
		
		if elevator ~= nil then 
		
			-- enable
			elevator:SetUInt32Value( 0x0006 + 0x000A, 0 )
			
		end
		
	-- Deathbringer Saurfang
	elseif entry == 37813 then
	
		ICC[ iid ].saurfangIsDone = true
		
		-- Spawn vendors and tents at Deathbringer Rise
		local team = killer:GetTeam() + 1
		
		local faction = 0
		
		if team == 1 then
		
			faction = 1732
			
		else
		
			faction = 1735
			
		end
		
		local phase = killer:GetPhase()

		for i = 1, 2, 1 do
		
			killer:SpawnCreature( npc_entry[ team ][ i ], spawn_npc[ i ][ 1 ], spawn_npc[ i ][ 2 ], spawn_npc[ i ][ 3 ], spawn_npc[ i ][ 4 ], faction, 0, 1, 2, 3, phase )
			
			killer:SpawnGameObject( go_entry[ team ][ i ], spawn_go[ i ][ 1 ], spawn_go[ i ][ 2 ], spawn_go[ i ][ 3 ], spawn_go[ i ][ 4 ], 0, 100, phase )
		
		end
		
	-- Professor Putricide
	elseif entry == 36678 then
	
		ICC[ iid ].putricideIsDone = true
	
	-- Rimefang
	elseif entry == 37533 then
	
		ICC[ iid ].rimefangIsDone = true
	
	-- Spinestalker
	elseif entry == 37534 then
	
		ICC[ iid ].spinestalkerIsDone = true
	
	end

end

function ICC.onAreaTrigger( iid, plr, areaTriggerId )
	
	local iid = plr:GetInstanceID()

	if areaTriggerId == 5732 and ICC[ iid ].marrowgarHasTalked == false then

		local marrowgar = GetInstanceCreature( 631, iid, 134338 )

		if marrowgar ~= nil then

			marrowgar:PlaySoundToSet( 16950 )

			marrowgar:SendChatMessage( 14, 0, "This is the beginning AND the end, mortals. None may enter the master's sanctum!" )

			ICC[ iid ].marrowgarHasTalked = true

		end

    elseif areaTriggerId == 5709 then

		local deathwhisper = GetInstanceCreature( 631, iid, 134201 )

		if deathwhisper ~= nil then

			LadyDeathwhisper_doAction( deathwhisper )

		end
		
	elseif areaTriggerId == 5604 then
	
		if ICC[ iid ].sindragosaIsDone == true or ICC[ iid ].sindragosaHasSpawned == true then 
			
			return
			
		end
		
		if ICC[ iid ].rimefangIsDone == true and ICC[ iid ].spinestalkerIsDone == true then
		
			local sindragosa = plr:SpawnCreature( 36853, 4550.690, 2483.710, 287.0650, 3.089233, 2068, 0, 1, 2, 3, plr:GetPhase() )
		
			-- set fly animation kit
			sindragosa:SetByteValue( 0x0006 + 0x0044, 3, 3 ) 
		
			SindragosaDoAction( 0, sindragosa )
		
			--plr:SendBroadcastMessage( "Sindragosa has spawned." )
			
		end
	
	elseif areaTriggerId == 5718 then
		
		if ICC[ iid ].putricideIsDone == false and ICC[ iid ].bloodQueenIsDone == false and ICC[ iid ].sindragosaIsDone == false then

			plr:CastSpell( 70860 )

		end
	
	end
	
end

-- disabled due iid bug
function ICC.onInstanceDestroy( iid )
    
	ICC[ iid ] = nil
	
end

--
-- Highlord Tirion Fordring (at Light's Hammer)
--
function HighlordTirionFordring_onSpawn( unit, event )
	
	local vars = ICC[ unit:GetInstanceID() ]
	
	vars.damnedKills = 0 --ICC_SetData( unit, 1, 0 ) -201066 -200966
	vars.lichKing = nil
	vars.bolvar = nil
	vars.factionNPC = nil
	
	vars.event = 1
	
	unit:RegisterAIUpdateEvent( 1000 )

end

function ICC_SetData( unit, Type, Data )

	local vars = ICC[ unit:GetInstanceID() ]
	
	if Type == 1 and Data == 1 then
	
		vars.damnedKills = vars.damnedKills + 1
		
		if vars.damnedKills == 2 then
	
			vars.lichKing = unit:GetCreatureNearestCoords( -123.96, 2211.56, 82.68, 37181 )
			
			vars.bolvar = unit:GetCreatureNearestCoords( -126.29, 2211.68, 82.23, 37183 )
			
			if vars.teamInInstance == 0 then
			
				-- get Muradin
				vars.factionNPC = unit:GetCreatureNearestCoords( -48.81, 2211.06, 27.99, 37200 )
				
			else
			
				-- get Saurfang
				vars.factionNPC = unit:GetCreatureNearestCoords( -45.56, 2210.00, 27.90, 37187 )
			
			end
			
			vars.timer = 2
			
		end
	
	end

end

function HighlordTirionFordring_onAIUpdate( unit, event )

	local vars = ICC[ unit:GetInstanceID() ]
	
	if vars.damnedKills ~= 2 then
		return
	end
	
	vars.timer = vars.timer - 1
	
	if vars.timer <= 0 then

		if vars.event == 1 then
	
			unit:PlaySoundToSet( 16653 )
			
			unit:SendChatMessage( 14, 0, "This is our final stand. What happens here will echo through the ages. Regardless of outcome, they will know that we fought with honor. That we fought for the freedom and safety of our people!" )
			
			unit:Emote( 22, 0 )
			
			vars.timer = 8
	
		elseif vars.event == 2 then
			
			unit:Emote( 5, 0 )
			
			vars.timer = 6
		
		elseif vars.event == 3 then
	
			unit:PlaySoundToSet( 16654 )
			
			unit:SendChatMessage( 14, 0, "Remember, heroes, fear is your greatest enemy in these befouled halls. Steel your heart and your soul will shine brighter than a thousand suns. The enemy will falter at the sight of you. They will fall as the light of righteousness envelops them!" )
			
			unit:Emote( 397, 0 )
			
			vars.timer = 10
		
		elseif vars.event == 4 then
			
			unit:Emote( 5, 0 )
			
			vars.timer = 10
			
		elseif vars.event == 5 then
		
			unit:PlaySoundToSet( 16655 )
			
			unit:SendChatMessage( 14, 0, "Our march upon Icecrown Citadel begins now!" )
			
			unit:Emote( 22, 0 )
			
			vars.timer = 6
		
		elseif vars.event == 6 then
		
			vars.lichKing:PlaySoundToSet( 17230 )
			
			vars.lichKing:SendChatMessage( 14, 0, "You now stand upon the hallowed ground of the Scourge. The Light won't protect you here, paladin. Nothing will protect you..." )
			
			vars.timer = 14
			
		elseif vars.event == 7 then
		
			unit:PlaySoundToSet( 16656 )
			
			unit:SendChatMessage( 14, 0, "ARTHAS! I swore that I would see you dead and the Scourge dismantled! I'm going to finish what I started at Light's Hope!" )
			
			unit:Emote( 22, 0 )
			
			vars.timer = 16
			
		elseif vars.event == 8 then
		
			vars.lichKing:PlaySoundToSet( 17231 )
			
			vars.lichKing:SendChatMessage( 14, 0, "You could have been my greatest champion, Fordring: A force of darkness that would wash over this world and deliver it into a new age of strife." )
			
			vars.timer = 12
		
		elseif vars.event == 9 then
		
			vars.lichKing:PlaySoundToSet( 17232 )
			
			vars.lichKing:SendChatMessage( 14, 0, "But that honor is no longer yours. Soon, I will have a new champion." )
			
			vars.timer = 12
			
		elseif vars.event == 10 then
		
			vars.lichKing:PlaySoundToSet( 17233 )
			
			vars.lichKing:SendChatMessage( 14, 0, "The breaking of this one has been taxing. The atrocities I have committed upon his soul. He has resisted for so long, but he will bow down before his king soon." )
			
			vars.timer = 20
			
		elseif vars.event == 11 then
		
			vars.bolvar:PlaySoundToSet( 17078 )
			
			vars.bolvar:SendChatMessage( 14, 0, "NEVER! I... I will never... serve... you..." )
			
			vars.timer = 8
		
		elseif vars.event == 12 then
		
			vars.lichKing:PlaySoundToSet( 17234 )
			
			vars.lichKing:SendChatMessage( 14, 0, "In the end, you will all serve me." )
			
			vars.timer = 12
			
			-- alliance/horde stuff (TODO)
		
		elseif vars.event == 13 then
		
			if vars.teamInInstance == 0 then
			
				vars.factionNPC:PlaySoundToSet( 16980 )
			
				vars.factionNPC:SendChatMessage( 12, 0, "Could it be, Lord Fordring? If Bolvar lives, mayhap there is hope fer peace between the Alliance and the Horde. We must reach the top o' this cursed place and free the paladin!" )
				
				vars.factionNPC:Emote( 6, 0 )
				
				vars.timer = 9999
				
			else
			
				vars.factionNPC:PlaySoundToSet( 17107 )
				
				vars.factionNPC:SendChatMessage( 12, 0, "The paladin still lives? Is it possible, Highlord? Could he have survived?" )
				
				vars.factionNPC:Emote( 6, 0 )
				
				vars.timer = 9999
				
			end
			
		elseif vars.event == 14 then
		
			if vars.teamInInstance == 0 then
			
				factionNPC:Emote( 1, 0 )
			
			else
			
				unit:PlaySoundToSet()
				
				unit:SendChatMessage( 14, 0, "" )
			
			end
		
		elseif vars.event == 15 then
		
		end
		
		vars.event = vars.event + 1
		
	end

end

function ICC.TeleportOnHello( go, event, plr )

    go:GossipCreateMenu( 15221, plr, 0 )
	
	go:GossipMenuAddItem( 0, "Teleport to the Light's Hammer.", 1, 0 )
	
	local iid = plr:GetInstanceID()
	
    if ICC[ iid ].marrowgarIsDone == true then

	    go:GossipMenuAddItem( 0, "Teleport to the Oratory of the Damned.", 2, 0 )
	
    end

    if ICC[ iid ].deathwhisperIsDone == true then

	    go:GossipMenuAddItem( 0, "Teleport to the Rampart of Skulls.", 3, 0 )
		
	    go:GossipMenuAddItem( 0, "Teleport to the Deathbringer's Rise.", 4, 0 )
	
    end

    if ICC[ iid ].saurfangIsDone == true then

	    go:GossipMenuAddItem( 0, "Teleport to the The Upper Spire.", 5, 0 )
		
    end
	
    if ICC[ iid ].sindragosaIsDone == true then

	    go:GossipMenuAddItem( 0, "Teleport to the The Frost Queen's Lair.", 6, 0 )
		
    end
	
    go:GossipSendMenu( plr )
	
end

function ICC.TeleporterOnSelect( go, event, plr, id, selection, code )

	for i = 1, #tele_coords do

		if selection == tele_coords[ i ][ 1 ] and not plr:IsInCombat() then
		
			plr:CastSpell( tele_coords[ i ][ 2 ] )
			
			plr:Teleport( 631, tele_coords[ i ][ 3 ], tele_coords[ i ][ 4 ], tele_coords[ i ][ 5 ], tele_coords[ i ][ 6 ] )

		elseif selection == tele_coords[ i ][ 1 ] and plr:IsInCombat() then
		
			plr:SendAreaTriggerMessage( "You are in combat!" )
				
		end
		
		plr:GossipComplete()
		
	end
	
end

function ICC.DarionMograine_onHello( unit, event, plr )
	
	unit:GossipCreateMenu( 15158, plr, 0 )
	
	unit:GossipAddQuests( plr )
	
	unit:GossipMenuAddItem( 0, "What is the Ashen Verdict?", 1, 0 )
	
	unit:GossipSendMenu( plr )
	
end

-- bugged: need core fix
function ICC.DarionMograine_onSelect( unit, event, plr, id, selection, code )
	
	if selection == 1 then
	
		unit:GossipCreateMenu( 15159, plr, 0 )
		
		unit:GossipMenuAddItem( 0, "How can I learn to work Primordial Saronite?", 2, 0 )
	
	else
	
		unit:GossipCreateMenu( 15160, plr, 0 )
		
	end

	plr:GossipComplete()

end

RegisterInstanceEvent( 631, 2, ICC.onPlayerEnter )
RegisterInstanceEvent( 631, 6, ICC.onCreatureLoad )
RegisterInstanceEvent( 631, 5, ICC.onCreatureDeath )
RegisterInstanceEvent( 631, 3, ICC.onAreaTrigger )
RegisterInstanceEvent( 631, 8, ICC.onGameObjectPush )
--RegisterInstanceEvent( 631, 10, ICC.onInstanceDestroy )

RegisterUnitEvent( 37119, 18, HighlordTirionFordring_onSpawn )
RegisterUnitEvent( 37119, 21, HighlordTirionFordring_onAIUpdate )


for i = 1, #scourge_ports do

    RegisterGameObjectEvent( scourge_ports[ i ], 4, ICC.TeleportOnHello )
	RegisterGOGossipEvent( scourge_ports[ i ], 2, ICC.TeleporterOnSelect )
	
end

RegisterUnitGossipEvent( 37120, 1, ICC.DarionMograine_onHello )
--RegisterUnitGossipEvent( 37120, 2, ICC.DarionMograine_onSelect )