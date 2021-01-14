--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum
	Engine: A.L.E

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	yt
	
	ToDo:

	*) More clean up
	*) 75416: need spellscript?
	
	enUS locale:

[ 1 ] = "Thank you! I could not have held out for much longer.... A terrible thing has happened here.";
[ 2 ] = "We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault.";
[ 3 ] = "The Black dragonkin materialized from thin air, and set upon us before we could react.";
[ 4 ] = "We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.";
[ 5 ] = "They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum.";
[ 6 ] = "The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work.";
[ 7 ] = "In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon.";
[ 8 ] = "I know not the extent of their plans, heroes, but I know this:  They cannot be allowed to succeed!";
[ 9 ] = "Help! I am trapped within this tree!  I require aid!";
[ 10 ] = "Your power wanes, ancient one.... Soon you will join your friends.";

	esMX locale:

[ 1 ] = "Thank you! I could not have held out for much longer.... A terrible thing has happened here.";
[ 2 ] = "We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault.";
[ 3 ] = "The Black dragonkin materialized from thin air, and set upon us before we could react.";
[ 4 ] = "We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.";
[ 5 ] = "They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum.";
[ 6 ] = "The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work.";
[ 7 ] = "In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon.";
[ 8 ] = "I know not the extent of their plans, heroes, but I know this:  They cannot be allowed to succeed!";
[ 9 ] = "Help! I am trapped within this tree!  I require aid!";
[ 10 ] = "Your power wanes, ancient one.... Soon you will join your friends.";
	
local MAP_RUBY_SANCTUM	= 724;

local NPC_XERESTRASZA	= 40429;
local NPC_BALTHARUS		= 39751;

local FACTION_HOSTILE = 14;

local AREA_TRIGGER = 5867; -- Baltharus plateau

-- For 3.3.5a
local GAMEOBJECT_BYTES_1	= 0x0006 + 0x000B;
local GAMEOBJECT_DYNAMIC =  0x0006 + 0x0008;
local UNIT_FIELD_FLAGS_2		= 0x0006 + 0x0036;
local UNIT_FLAG2_ENABLE_POWER_REGEN	= 0x0000800;

--]]

local SOUND = {
[ 1 ] = 17491;	-- Xerex event 1
[ 2 ] = 17492;	-- Xerex event 2
[ 3 ] = 17493;	-- Xerex event 3
[ 4 ] = 17494;	-- Xerex event 4
[ 5 ] = 17495;	-- Xerex event 5
[ 6 ] = 17496;	-- Xerex event 6
[ 7 ] = 17497;	-- Xerex event 7
[ 8 ] = 17498;	-- Xerex event 8
[ 9 ] = 17490;	-- Xerex Intro
[ 10 ] = 17525;	-- Baltharus Intro
};

local CHAT = {
[ 1 ] = "Thank you! I could not have held out for much longer.... A terrible thing has happened here.";
[ 2 ] = "We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault.";
[ 3 ] = "The Black dragonkin materialized from thin air, and set upon us before we could react.";
[ 4 ] = "We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.";
[ 5 ] = "They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum.";
[ 6 ] = "The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work.";
[ 7 ] = "In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon.";
[ 8 ] = "I know not the extent of their plans, heroes, but I know this:  They cannot be allowed to succeed!";
[ 9 ] = "Help! I am trapped within this tree!  I require aid!";
[ 10 ] = "Your power wanes, ancient one.... Soon you will join your friends.";
};

-- WorldStates:
--local WORLDSTATE_CORPOREALITY_MATERIAL  = 5049;
--local WORLDSTATE_CORPOREALITY_TWILIGHT  = 5050;
--local WORLDSTATE_CORPOREALITY_TOGGLE    = 5051;

-- Spells:
--local SPELL_RALLY = 75416;

RUBY_SANCTUM = {}

--[[
function RUBY_SANCTUM.InstanceOnLoad( iid )

	--[[ Developer notes: i discover argument iid isnt safe. If a player enter the function triggers and variables
	are created. But then if player from opposite faction enter variables wont be created with the same idd number.
	so will have no more choice than spend resources getting instance id again. ]]

	RUBY_SANCTUM[ iid ] = {

    --RUBY_SANCTUM[ iid ].baltharus = false;  -- hypers bugged tutorials...
    --RUBY_SANCTUM[ iid ].saviana = false;    -- hypers bugged tutorials...
    --RUBY_SANCTUM[ iid ].zarithrian = false; -- hypers bugged tutorials...

	isIntro = true,
	isDone = false,
	baltharus = false,
	saviana = false,
	zarithrian = false,
	action = 0

    };

    print("debug: ruby sanctum variables created")
end
--]]

function RUBY_SANCTUM.OnPlayerEnter( iid, plr )

    --[[ Developer notes: i discover argument iid isnt safe. If a player enter the function triggers and variables
    are created. But then if player from opposite faction enter variables wont be created with the same idd number.
    so will have no more choice than spend resources getting instance id again. ]]

    local iid = plr:GetInstanceID();

	-- create protected variables
    if( RUBY_SANCTUM[ iid ] == nil )
    then
	    RUBY_SANCTUM[ iid ] = {

		isIntro = true,
		isDone = false,
        baltharusIsDead = false,
        savianaIsDead = false,
        zarithrianIsDead = false,
		action = 0
		
        };
    end
end

function RUBY_SANCTUM.OnCreatureDeath( iid, victim, killer )

    local iid = killer:GetInstanceID();

	local entry = victim:GetEntry();
	
	-- baltharus
    if( entry == 39751 )
    then
        RUBY_SANCTUM[ iid ].baltharusIsDead = true;
		
        if( RUBY_SANCTUM[ iid ].savianaIsDead == true )
        then
            local flame = victim:GetGameObjectNearestCoords( 3050.36, 526.1, 88.41, 203006 );
			
			if( flame )
			then
				-- open door
				flame:SetByte( 0x0006 + 0x000B, 0, 0 );
			end
        end

	-- saviana
    elseif( entry == 39747 )
    then
        RUBY_SANCTUM[ iid ].savianaIsDead = true;

        if( RUBY_SANCTUM[ iid ].baltharusIsDead == true )
        then

            local flame = victim:GetGameObjectNearestCoords( 3050.36, 526.1, 88.41, 203006 );
			
			if( flame )
			then
				-- open door
				flame:SetByte( 0x0006 + 0x000B, 0, 0 );
			end
        end

	-- zarithrian
    elseif( entry == 39746 )
    then
        RUBY_SANCTUM[ iid ].zarithrianIsDead = true;
		
        local controller = victim:GetCreatureNearestCoords( 3156.04, 533.266, 72.9721, 40146 );
		
		if( controller )
		then
			-- All hail Halion!
			--controller:CastSpell( 76006 );
			controller:SpawnCreature( 39863, 3156.67, 533.8108, 72.98822, 3.159046, 14, 0, 1, 1, 1, 1, 0 );
		end
    end
end

function RUBY_SANCTUM.XerexOnSpawn( unit )

	unit:SetFlag( 0x0006 + 0x0036, 0x0000800 );
end

function RUBY_SANCTUM.XerexDoAction( unit )

	local iid = unit:GetInstanceID();
	
	RUBY_SANCTUM[ iid ].action = RUBY_SANCTUM[ iid ].action + 1;
	
	-- intro xerex
	if( RUBY_SANCTUM[ iid ].action == 1 )
	then
		RUBY_SANCTUM[ iid ].introDone = true;
		unit:PlaySoundToSet( SOUND[ 9 ] );
        unit:SendChatMessage( 14, 0, CHAT[ 9 ] );
		unit:Emote( 5, 0 );
		
	-- baltharus death
	elseif( RUBY_SANCTUM[ iid ].action == 2 )
	then
		unit:PlaySoundToSet( SOUND[ 1 ] );
        unit:SendChatMessage( 14, 0, CHAT[ 1 ] );
		unit:Emote( 5, 0 );
		
		RUBY_SANCTUM[ iid ].isIntro = false;
		
		-- add protected variables
		RUBY_SANCTUM[ iid ].event1 = 16;
		RUBY_SANCTUM[ iid ].event2 = 25;
		RUBY_SANCTUM[ iid ].event3 = 32;
		RUBY_SANCTUM[ iid ].event4 = 42;
		RUBY_SANCTUM[ iid ].event5 = 51;
		RUBY_SANCTUM[ iid ].event6 = 61;
		RUBY_SANCTUM[ iid ].event7 = 69;
	end
end

function RUBY_SANCTUM.BaltharusDoAction( unit )

	local iid = unit:GetInstanceID();
	
	-- intro baltharus
	if( RUBY_SANCTUM[ iid ].action == 1 )
	then
		unit:PlaySoundToSet( SOUND[ 10 ] );
        unit:SendChatMessage( 14, 0, CHAT[ 10 ] );
	end	
end

function RUBY_SANCTUM.XerexOnAIUpdate( unit )
	
	local iid = unit:GetInstanceID();
	
	if( RUBY_SANCTUM[ iid ].isIntro == true )
	then return; end
	
	RUBY_SANCTUM[ iid ].event1 = RUBY_SANCTUM[ iid ].event1 - 1;
	RUBY_SANCTUM[ iid ].event2 = RUBY_SANCTUM[ iid ].event2 - 1;
	RUBY_SANCTUM[ iid ].event3 = RUBY_SANCTUM[ iid ].event3 - 1;
	RUBY_SANCTUM[ iid ].event4 = RUBY_SANCTUM[ iid ].event4 - 1;
	RUBY_SANCTUM[ iid ].event5 = RUBY_SANCTUM[ iid ].event5 - 1;
	RUBY_SANCTUM[ iid ].event6 = RUBY_SANCTUM[ iid ].event6 - 1;
	RUBY_SANCTUM[ iid ].event7 = RUBY_SANCTUM[ iid ].event7 - 1;
	
	if( RUBY_SANCTUM[ iid ].event1 <= 0 )
	then
		unit:PlaySoundToSet( SOUND[ 2 ] );
        unit:SendChatMessage( 12, 0, CHAT[ 2 ] );
	
	elseif( RUBY_SANCTUM[ iid ].event2 <= 0 )
	then
		unit:PlaySoundToSet( SOUND[ 3 ] );
        unit:SendChatMessage( 12, 0, CHAT[ 3 ] );
	
	elseif( RUBY_SANCTUM[ iid ].event3 <= 0 )
	then
		unit:PlaySoundToSet( SOUND[ 4 ] );
        unit:SendChatMessage( 12, 0, CHAT[ 4 ] );

	elseif( RUBY_SANCTUM[ iid ].event4 <= 0 )
	then
		unit:PlaySoundToSet( SOUND[ 5 ] );
        unit:SendChatMessage( 12, 0, CHAT[ 5 ] );

	elseif( RUBY_SANCTUM[ iid ].event5 <= 0 )
	then
		unit:PlaySoundToSet( SOUND[ 6 ] );
        unit:SendChatMessage( 12, 0, CHAT[ 6 ] );
		
	elseif( RUBY_SANCTUM[ iid ].event6 <= 0 )
	then
		unit:PlaySoundToSet( SOUND[ 7 ] );
        unit:SendChatMessage( 12, 0, CHAT[ 7 ] );
		
	elseif( RUBY_SANCTUM[ iid ].event7 <= 0 )
	then
		unit:PlaySoundToSet( SOUND[ 8 ] );
        unit:SendChatMessage( 12, 0, CHAT[ 8 ] );
		unit:Emote( 5, 0 );
		unit:RemoveAIUpdateEvent();
		unit:SetNPCFlags( 3 );
	end
end

function RUBY_SANCTUM.OnAreaTrigger( iid, plr, areaTriggerID )

	local iid = plr:GetInstanceID();

    if( areaTriggerID == 5867 )
    then
		local xerex = GetInstanceCreature( 724, iid, 134456 );
		if( xerex )
		then
			xerex:RegisterEvent( RUBY_SANCTUM.XerexDoAction, 1000, 1 );
		end
		
		local baltharus = GetInstanceCreature( 724, iid, 134428 );
		if( baltharus )
		then
			baltharus:RegisterEvent( RUBY_SANCTUM.BaltharusDoAction, 7000, 1 );
		end
    end
end

function RUBY_SANCTUM.GoOnSpawn( go )

	-- 3: green, 2: flames to burned, 1: flames to green, 0: burned
	go:SetByte( 0x0006 + 0x000B, 0, 3 );
	go:SetUInt32Value( 0x0006 + 0x0008, 1 );
end

RegisterUnitEvent( 40429, 18, RUBY_SANCTUM.XerexOnSpawn );
RegisterUnitEvent( 40429, 21, RUBY_SANCTUM.XerexOnAIUpdate );

--RegisterInstanceEvent( 724, 9, RUBY_SANCTUM.InstanceOnLoad );
RegisterInstanceEvent( 724, 2, RUBY_SANCTUM.OnPlayerEnter );
RegisterInstanceEvent( 724, 5, RUBY_SANCTUM.OnCreatureDeath );
RegisterInstanceEvent( 724, 3, RUBY_SANCTUM.OnAreaTrigger );

RegisterGameObjectEvent( 203034, 2, RUBY_SANCTUM.GoOnSpawn );
RegisterGameObjectEvent( 203035, 2, RUBY_SANCTUM.GoOnSpawn );
RegisterGameObjectEvent( 203036, 2, RUBY_SANCTUM.GoOnSpawn );
RegisterGameObjectEvent( 203037, 2, RUBY_SANCTUM.GoOnSpawn );

--[[ 
		Debug commands disabled by default 


local COMMANDS = { "ruby", "port", "exit", "xerex", "open", "close" };

function RubyCommands( _, plr, message )

	if( plr:IsGm() == true )
	then
		if( message == "#ruby" )
		then
			for i = 1, #COMMANDS
			do
				plr:SendBroadcastMessage( ""..COMMANDS[ i ].."" );
			end

		elseif( message == "#port" )
		then
			plr:Teleport( 724, 3190.85, 637.78, 78.93, 3.11 );
			
		elseif( message == "#exit" )
		then
			plr:Teleport( 571, 3597.61, 200.96, -113.74, 5.30 );
		
		elseif( message == "#xerex" )
		then
			local iid = plr:GetInstanceID();
			local xerex = GetInstanceCreature( 724, iid, 134456 );
			xerex:SendChatMessage( 12, 0, CHAT[ 6 ] );
			
		elseif( message == "#open" )
		then
			local firefield = plr:GetGameObjectNearestCoords( 3153.27, 380.47, 86.36, 203005 );
			firefield:SetByte( 0x0006 + 0x000B, 0, 0 );
		
		elseif( message == "#close" )
		then
			local firefield = plr:GetGameObjectNearestCoords( 3153.27, 380.47, 86.36, 203005 );
			firefield:SetByte( 0x0006 + 0x000B, 0, 1 );
			
		else
		
			local selection = plr:GetSelection();
			if( selection == nil)
			then
				plr:SendBroadcastMessage( "You need to select something first." );
				
			else		

				if( message == "#n" )
				then
					
				elseif( message == "#m" )
				then

				end
			end
		end
    end
end

RegisterServerHook( 16, RubyCommands );

--]]
