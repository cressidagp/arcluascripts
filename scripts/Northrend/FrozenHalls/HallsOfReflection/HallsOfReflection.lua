--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Frozen Halls: Halls of Reflection
	Engine: A.L.E
	
	Credits:

	*) Trinity for gossips, texts, sound ids, timers and spell ids.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

-- Worldstates:
local WORLD_STATE_HOR_WAVES_ENABLED = 4884;
local WORLD_STATE_HOR_WAVE_COUNT	= 4882;

local GOSSIPS = { 15339, 15215 }; -- TODO use this to save some methods

-- Spells:
local SPELL_A_PHASE   = 60027; -- Phase +64
local SPELL_H_PHASE   = 60028; -- Phase +128

HOR = {}

function HOR.InstanceOnLoad( iid )

    -- check if iid its safe here: Is not.

	HOR[ iid ] = {

	falric = false,
    marwyn = false,
    general = false,
	walkIntro = 0,
	eventStartIntro = false,
	eventSkipIntro = false,
	action = 0,
	waveCount = 0,
	timer = 3

    };

end

function HOR.OnPlayerEnter( iid, plr )

    --[[ Developer notes: i discover argument iid isnt safe. If a player enter the function triggers and variables
    are created. But then if player from opposite faction enter variables will be created with the same idd number.
    so will have no more choice than spend resources getting instance id again. ]]

    local iid = plr:GetInstanceID();

    if( HOR[ iid ] == nil )
    then

		HOR[ iid ] = {

        falric = false,
        marwyn = false,
        general = false,
		walkIntro = 0,
		eventStartIntro = false,
		eventSkipIntro = false,
		action = 0,
		waveCount = 0,
		timer = 3

        };

    end
	
	if( HOR[ iid ].team == nil )
	then
		HOR[ iid ].team = plr:GetTeam();
	end

    if( HOR[ iid ].team == 0 )
    then
        plr:CastSpell( SPELL_A_PHASE );
    else
        plr:CastSpell( SPELL_H_PHASE );
    end
end

function HOR.OnCreaturePush( iid, creature )
	local entry = creature:GetEntry();
	if( entry == 38113 )
	then
		local iid = creature:GetInstanceID();
		if( HOR[ iid ].marwyn ~= true )
		then
			creature:SetWorldStateForZone( WORLD_STATE_HOR_WAVES_ENABLED, 1 );
			creature:SetWorldStateForZone( WORLD_STATE_HOR_WAVE_COUNT, 0 );
		end
	end
end

function HOR.OnZoneOut( _, plr, _, OldZoneId )

    if( OldZoneId == 668 )
    then
        plr:SetPhase( 1, 1 );
    end
end


function HOR.OnHello( unit, event, plr )
	local iid = plr:GetInstanceID();
	if( HOR[ iid ].team == 0 )
	then
		unit:GossipCreateMenu( 15339, plr, 0 );
		unit:GossipMenuAddItem( 0, "Can you remove the sword?", 1, 0 );
		unit:GossipMenuAddItem( 0, "My lady, I think I hear Arthas coming. Whatever you're going to do, do it quickly.", 2, 0 );
	else
		unit:GossipCreateMenu( 15215, plr, 0 );
		unit:GossipMenuAddItem( 0, "Can you remove the sword?", 1, 0 );
		unit:GossipMenuAddItem( 0, "Dark Lady, I think I hear Arthas coming. Whatever you're going to do, do it quickly.", 2, 0 );
	end
	
	unit:GossipSendMenu( plr );
	
end

function HOR.OnSelect( unit, event, plr, id, selection, code )
	local iid = plr:GetInstanceID();
	if( selection == 1 )
	then
		HOR[ iid ].eventStartIntro = true;
	else
		HOR[ iid ].eventSkipIntro = true;
	end
	
	HOR[ iid ].timer = 1;
	plr:GossipComplete();
	unit:SetNPCFlags( 0 );
	
end

function HOR.teamcheck( unit )
	local iid = unit:GetInstanceID();
	if( unit:GetEntry() == 37221 )
	then
		if( HOR[ iid ].team == 0 )
		then
			unit:RegisterAIUpdateEvent( 1000 );
		end
	else
		if( HOR[ iid ].team == 1 )
		then
			unit:RegisterAIUpdateEvent( 1000 );
		end
	end
end

function HOR.OnSpawn( unit )
	print("somebady should start...")
	unit:SetNPCFlags( 0 );
	unit:SetMovementFlags( 1 ); -- run
	unit:RegisterEvent( HOR.teamcheck, 2000, 1 )
end

function HOR.KorelnLoralenOnSpawn( unit, event )
	unit:SetMovementFlags( 1 ) -- run
end

function HOR.OnAIUpdate( unit )
	print(unit)
	local iid = unit:GetInstanceID();
	HOR[ iid ].timer = HOR[ iid ].timer - 1;
	
	if( HOR[ iid ].walkIntro == 0 and HOR[ iid ].timer <= 0 )
	then
		if( HOR[ iid ].team == 0 )
		then
			unit:MoveTo( 5263.2,  1950.96, 707.6948, 0.8028514 ); -- move to door
			unit:PlaySoundToSet( 16631 );
			unit:SendChatMessage( 14, 0, "The chill of this place... I can feel my blood freezing." );
			HOR[ iid ].timer = 7;
			local koreln = unit:GetUnitBySqlId( 200632 );
			koreln:MoveTo( 5253.061, 1953.616, 707.6948, 0.8377581 );
		else
			unit:MoveTo( 5265.89, 1952.98, 707.6978, 0.0 ); -- move to door
			unit:PlaySoundToSet( 17049 );
			unit:SendChatMessage( 14, 0, "I... I don't believe it! Frostmourne stands before us - unguarded - just as the gnome claimed. Come, heroes!" );
			HOR[ iid ].timer = 9;
			local loralen = unit:GetUnitBySqlId( 200633 );
			loralen:MoveTo( 5253.061, 1953.616, 707.6948, 0.8377581 );
		end
		HOR[ iid ].walkIntro = 1;
	
	elseif( HOR[ iid ].walkIntro == 1 and HOR[ iid ].timer <= 0 )
	then
		if( HOR[ iid ].team == 0 )
		then
			unit:PlaySoundToSet( 16632 );
			unit:SendChatMessage( 14, 0, "What is that! Up ahead! Could it be? Heroes, at my side!" );
		else
			unit:PlaySoundToSet( 17050 );
			unit:SendChatMessage( 14, 0, "Standing this close to the blade that ended my life... The pain... It is renewed." );
		end 
		HOR[ iid ].walkIntro = 2;
		unit:SetNPCFlags( 3 );
		
	elseif( HOR[ iid ].eventStartIntro == true and HOR[ iid ].timer <= 0 )
	then
		if( HOR[ iid ].action == 0 )
		then
			if( HOR[ iid ].team == 0 )
			then
				local koreln = unit:GetUnitBySqlId( 200632 );
				koreln:MoveTo( 5283.226, 1992.300, 707.7445, 0.8377581 );
				unit:MoveTo( 5306.95, 1998.49, 709.3414, 1.277278 ); -- move to frostmourne
			else
				local loralen = unit:GetUnitBySqlId( 200633 );
				loralen:MoveTo( 5283.226, 1992.300, 707.7445, 0.8377581 );
				unit:MoveTo( 5306.82, 1998.17, 709.341,  1.239184 ); -- move to frostmourne
			end
			HOR[ iid ].action = 1
			HOR[ iid ].timer = 1;
			
		elseif( HOR[ iid ].action == 1 )
		then
			if( HOR[ iid ].team == 0 )
			then
				unit:PlaySoundToSet( 16633 );
				unit:SendChatMessage( 14, 0, "Frostmourne: the blade that destroyed our kingdom..." );
			else
				unit:PlaySoundToSet( 17051 );
				unit:SendChatMessage( 14, 0, "I dare not touch it. Stand back! Stand back as I attempt to commune with the blade! Perhaps our salvation lies within..." );
			end
			
		end
	end
end

RegisterInstanceEvent( 668, 9, HOR.InstanceOnLoad );
RegisterInstanceEvent( 668, 2, HOR.OnPlayerEnter );
RegisterInstanceEvent( 668, 6, HOR.OnCreaturePush );
RegisterInstanceEvent( 668, 4, HOR.OnZoneOut );

RegisterUnitGossipEvent( 37221, 1, HOR.OnHello );
RegisterUnitGossipEvent( 37223, 1, HOR.OnHello );
RegisterUnitGossipEvent( 37221, 2, HOR.OnSelect );
RegisterUnitGossipEvent( 37223, 2, HOR.OnSelect );

RegisterUnitEvent( 37221, 18, HOR.OnSpawn );
RegisterUnitEvent( 37223, 18, HOR.OnSpawn );

RegisterUnitEvent( 37582, 18, HOR.KorelnLoralenOnSpawn );
RegisterUnitEvent( 37779, 18, HOR.KorelnLoralenOnSpawn );

RegisterUnitEvent( 37221, 21, HOR.OnAIUpdate );
RegisterUnitEvent( 37223, 21, HOR.OnAIUpdate );
