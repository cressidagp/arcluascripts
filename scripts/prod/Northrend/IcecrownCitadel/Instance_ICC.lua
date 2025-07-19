local ICC = {}

local object_link = {

{ 36612, 201910 }, -- Marrowgar, Icewall R
{ 36612, 201911 }, -- Marrowgar, Icewall L
{ 36612, 201563 }, -- Marrowgar, Oratory of the Damned Entrance
{ 36612, 202245 }, -- Marrowgar, Transporter
{ 36855, 202243 }, -- Lady Deathwhisper, Transporter at (rampart of skull)
{ 36855, 202244 }, -- Lady Deathwhisper, Transporter at (deatbringer rise)

}

function ICC.onPlayerEnter( iid, plr )

	local iid = plr:GetInstanceID()

	-- create protected variables
	if ICC[ iid ] == nil
	then
		ICC[ iid ] = {
		
			marrowgarIsDead = false,
			deathwhisperIsDead = false,
			marrowgarHasTalked = false,
			saurfangIsDead = false
		
		}

		--
		-- @DarkAngel39 instance progression system
		--
		local string_data = {}

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

					if( b1 ~= nil ) then 
					
						ICC[ iid ].marrowgarIsDead = true
						ICC[ iid ].marrowgarHasTalked = true
						
					end
						
					if( b2 ~= nil ) then ICC[ iid ].deathwhisperIsDead = true end
					if( b3 ~= nil ) then ICC[ iid ].saurfangIsDead = true end

				end

			until result:NextRow() ~= true
			
			--print(ICC[ iid ].marrowgarIsDead)
			--print(ICC[ iid ].deathwhisperIsDead)
			--print(ICC[ iid ].saurfangIsDead)

		end

	end
	
	-- add debuff: Chill of the Throne
	if plr:HasAura( 69127 ) == false then
	
		--SetDBCSpellVar( 69127, "c_is_flags", 0x01000 )
		
		plr:CastSpell( 69127 )
	
	end
	
	-- Alliance plr:
	if plr:GetTeam() == 0 and not plr:HasAura( 73828 ) then 
	
		-- add buff: Strenght of the Wrynn
		plr:CastSpell( 73828 )
		
		-- set Alliance Phase
		plr:CastSpell( 55774 )
		
	-- Horde plr:
	elseif plr:GetTeam() == 1 and not plr:HasAura( 73822 ) then
	
		-- add buff: Hellscreams Warsong
		plr:CastSpell( 73822 )
		
		-- set Horde Phase
		plr:CastSpell( 55773 )
	
	end
	
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
	
	for b = 1, #object_link do
	
		if ICC[ iid ].marrowgarIsDead == true then
		
			if entry == object_link[ b ][ 2 ] and object_link[ b ][ 1 ] == 36612 and go:GetByte( 0x0006 + 0x000B, 0 ) ~= 0 then
			
				go:Activate()
			
			end
	
		elseif ICC[ iid ].deathwhisperIsDead == true then
		
			if entry == object_link[ b ][ 2 ] and object_link[ b ][ 1 ] == 36855 and go:GetByte( 0x0006 + 0x000B, 0 ) ~= 0 then
			
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

	end

end

function ICC.OnCreatureDeath( iid, victim, killer )

	local entry = victim:GetEntry()
	
	local iid = killer:GetInstanceID()
	
	-- Lord Marrowgar
	if entry == 36612 then
	
		ICC[ iid ].marrowgarIsDead = true
		
	-- Lady Deathwhisper
	elseif entry == 36855 then
	
		ICC[ iid ].deathwhisperIsDead = true
	
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
	
	end
	
end

RegisterInstanceEvent( 631, 2, ICC.onPlayerEnter )
RegisterInstanceEvent( 631, 6, ICC.onCreatureLoad )
RegisterInstanceEvent( 631, 5, ICC.onCreatureDeath )
RegisterInstanceEvent( 631, 3, ICC.onAreaTrigger )
RegisterInstanceEvent( 631, 8, ICC.onGameObjectPush )