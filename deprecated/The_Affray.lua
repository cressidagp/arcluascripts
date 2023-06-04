--[[

.npc portto 43359
.quest start 1718 (the islander)

--]]

-- QUESTID_THE_AFFRAY = 1719
-- CREATUREID_TWIGGY_FLATHEAD = 6248
-- CREATUREID_AFFRAY_CHALLENGER = 6240
-- CREATUREID_BIG_WILL = 6238
-- EMOTE_ONESHOT_ROAR = 15
-- EMOTE_STATE_READY_UNARMED = 27
-- FACTION_ENEMY = 14
-- FACTION_FRIENDLY = 35
-- OBJECT_END				= 0x0006
-- UNIT_FIELD_FLAGS			= 0x0006 + 0x0035
-- UNIT_FIELD_TARGET		= 0x0006 + 0x000C
-- UNIT_FLAG_NOT_ATTACKABLE_9	= 0x00000100;
-- UNIT_FLAG_NOT_SELECTABLE	= 0x02000000;

local AffrayLoc = {

    {-1683, -4326, 2.79, 0},
    {-1682, -4329, 2.79, 0},
    {-1683, -4330, 2.79, 0},
    {-1680, -4334, 2.79, 1.49},
    {-1674, -4326, 2.79, 3.49},
    {-1677, -4334, 2.79, 1.66}
};

local AffrayDisplay = { 4968, 4969, 4970, 4971 };

THE_AFFRAY = {}

function twiggyFlathead_onAIUpdate( unit, _ )

	local ref = THE_AFFRAY[tostring( unit )]
	
	-- the green bastard look for Warriors witch have started the quest
	local tbl_plrs = unit:GetInRangePlayers()
	if tbl_plrs and ref.eventInProgress == false then
		for _, v in ipairs ( tbl_plrs ) do
			if v:GetPlayerClass() == "Warrior" and v:GetQuestObjectiveCompletion( 1719, 0 ) == 0 then
				if unit:GetDistance( v ) <= 90 then
				   ref.eventInProgress = true
				   ref.plrTarget = v
				   ref.plrGuid = v:GetGUID()	
				end
			end
		end
	end
	
	-- check if event has started and then spawn challengers
	if( ref.eventSpawned == false and ref.eventInProgress == true ) then

		local p = unit:GetUnitByGUID( ref.plrGuid )
		if p:HasQuest( 1719 ) then
			local x = p:GetX()
			local y = p:GetY()
			
			-- there is an AT in the center of the circle (like
			-- in all quest about step in some place) but not sure 
			-- if we should have to much serverhook functions (maybe
			-- a big one with all quest like this???)
			if( (x >= -1684 and x <= -1674) and (y >= -4334 and y <= -4324) ) then
				unit:SendChatMessage( 12, 0, "The Affray has begun.  "..p:GetName()..", get ready to fight!" )
						
				for i = 1, 6, 1 do
	
					local mob = unit:SpawnCreature( 6240, AffrayLoc[ i ][ 1 ], AffrayLoc[ i ][ 2 ], AffrayLoc[ i ][ 3 ], AffrayLoc[ i ][ 4 ], 35, 600000, 1899, 1, 1, 1, 0 );
					mob:SetModel( AffrayDisplay[math.random(1, 4)] )
					mob:SetByteValue( 0x7A, 0, 1 )
					mob:SetFaction( 35 )
					mob:SetFlag( 0x0006 + 0x0035, 0x00000100 + 0x02000000 )
					mob:DisableCombat( 1 )
					mob:Emote( 15, 1000 )
					ref.affrayChallenger[ i ] = mob:GetGUID()	
				end
						
				ref.eventSpawned = true
				ref.waveTimer = 5
				ref.challengerChecker = 1		
			end
		end
		
	elseif( ref.eventInProgress == true ) then
	
		ref.waveTimer = ref.waveTimer - 1	
		
		-- check if a challenger is dead
		if( ref.challengerChecker <= 1 ) then 
		
			for i = 1, 6, 1 do
			
				if( ref.affrayChallenger[ i ] ) then
				
					local npc = unit:GetUnitByGUID( ref.affrayChallenger[ i ] )
					
					if( npc == nil or ( npc:IsAlive() == false and ref.challengerDown[ i ] == false ) ) then

						unit:SendChatMessage( 12, 0, "Challenger is down!" )
						ref.challengerDown[ i ] = true
					end
				end
			end
	
			ref.challengerChecker = 1;
		else
			ref.challengerChecker = ref.challengerChecker - 1
		end
		
		-- wait twenty seconds and then activate another Challenger
		if( ref.waveTimer <= 1 ) then
		
			if( ref.wave < 7 and ref.affrayChallenger[ ref.wave ] and ref.eventBigWill == false ) then
				unit:SendChatMessage( 12, 0, "You!  Enter the fray!" )
				local npc = unit:GetUnitByGUID( ref.affrayChallenger[ ref.wave ] )
				if( npc and npc:IsAlive() == true ) then
					npc:Emote( 15, 0 )
					npc:SetFaction( 14 )
					npc:SetUInt64Value( 0x0006 + 0x000C, ref.plrGuid );
					npc:RegisterAIUpdateEvent( 3000 )
					ref.wave = ref.wave + 1
					ref.waveTimer = 20
				end
			
			-- no more Challengers so spawn Big Will
			elseif( ref.wave >= 6 and ref.eventBigWill == false ) then
			
				local bw = unit:SpawnCreature( 6238, -1722, -4341, 6.12, 6.26, 35, 480000, 1, 1, 1, 1, 0 )
				if( bw ) then
					bw:SetFlag( 0x0006 + 0x0035, 0x00000100 + 0x02000000 )
					bw:DisableCombat( 1 )
					bw:Emote( 27, 0 )
					ref.bigWill = bw:GetGUID()
					ref.eventBigWill = true
					ref.waveTimer = 1
					--test
					bw:RegisterAIUpdateEvent( 20000 )
					bw:SetUInt64Value( 0x0006 + 0x000C, ref.plrGuid );
				end
						
			elseif( ref.wave >= 6 and ref.eventBigWill and ref.bigWill ) then
			
				local bw = unit:GetUnitByGUID( ref.bigWill )
				if( bw == nil or bw:IsAlive() == false ) then
					unit:SendChatMessage( 12, 0, "The Affray is over!" )
					ref.eventInProgress = false
					unit:Despawn( 1000, 0 ) -- reset variables
				end
			end 
		end
	end 
end

function twiggyFlathead_onLoad( unit, _ )

	local sUnit = tostring( unit )
	
	THE_AFFRAY[ sUnit ] = {
	
	eventInProgress = false,
	eventSpawned = false,
	affrayChallenger = { nil, nil, nil, nil, nil, nil },
	challengerDown = { false, false, false, false, false, false },
	waveTimer = 0,
	challengerChecker = 0,
	eventBigWill = false,
	wave = 1,
	bigWill = nil,
	plrTarget = nil,
	plrGuid = nil
	
	}
	unit:RegisterAIUpdateEvent( 1000 )
end

RegisterUnitEvent( 6248, 18, twiggyFlathead_onLoad )
RegisterUnitEvent( 6248, 21, twiggyFlathead_onAIUpdate )


function affrayChallenger_onAIUpdate( unit, _ )

	unit:RemoveFlag( 0x0006 + 0x0035, 0x00000100 + 0x02000000 )
	unit:DisableCombat( 0 )
	unit:SetFaction( 14 )
	local value = unit:GetUInt64Value( 0x0006 + 0x000C )
	local target = unit:GetUnitByGUID( value )
	-- dont crash please
	if target then
		unit:AttackReaction( target, 35, 0 )
	end
	unit:RemoveAIUpdateEvent()
end

RegisterUnitEvent( 6240, 21, affrayChallenger_onAIUpdate )

function bigWill_onSpawn( unit, _ )
	
	unit:SetMovementType( 11 ) -- foward then stop
	unit:CreateCustomWaypointMap()
	unit:CreateCustomWaypoint( 1, -1693, -4343, 4.32, 1, 0, 1, 0 )
	unit:CreateCustomWaypoint( 2, -1684, -4333, 2.78, 1, 0, 1, 0 )
	unit:CreateCustomWaypoint( 3, -1682, -4329, 2.79, 1, 0, 0, 0 )
end

function bigWill_onAIUpdate( unit, _ )

	unit:RemoveFlag( 0x0006 + 0x0035, 0x00000100 + 0x02000000 )
	unit:DisableCombat( 0 )
	unit:SendChatMessage( 12, 0, "Ready when you are, warrior." )
	local value = unit:GetUInt64Value( 0x0006 + 0x000C )
	local target = unit:GetUnitByGUID( value )
	-- dont crash please
	if target then
		unit:AttackReaction( target, 45, 0 )
	end
	unit:RemoveAIUpdateEvent()
end

function bigWill_onReachWaypoint( unit, _, waypointId, _ )

	if waypointId == 3 then
	
		unit:DestroyCustomWaypointMap()
		unit:Emote( 27, 0 )
	end
end

RegisterUnitEvent( 6238, 18, bigWill_onSpawn )
RegisterUnitEvent( 6238, 19, bigWill_onReachWaypoint )
RegisterUnitEvent( 6238, 21, bigWill_onAIUpdate )

--[[
function AFFRAYCommands( _, plr, message )
	if( message == "#ago1" )
	then
		plr:Teleport( 1, -1722, -4341, 6.12, 6.26 );
		
	elseif( message == "#ago2" )
	then
		plr:Teleport( 1, -1693, -4343, 4.32 );
	
	elseif( message == "#ago3" )
	then
		plr:Teleport( 1, -1684, -4333, 2.78 );
	
	elseif( message == "#ago4" )
	then
		plr:Teleport( 1, -1682, -4329, 2.79 );
	end
end

RegisterServerHook( 16, AFFRAYCommands );
--]]