--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum
	Engine: A.L.E
	Credits: Trinity for sound ids, chats and worldstates.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local SOUND = {
[ 1 ] = 17491;
[ 2 ] = 17492;
[ 3 ] = 17493;
[ 4 ] = 17494;
[ 5 ] = 17495;
[ 6 ] = 17496;
[ 7 ] = 17497;
[ 8 ] = 17498;
[ 9 ] = 40598; -- Intro
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
};

local AREA_TRIGGER = 5867; -- Baltharus plateau

-- WorldStates:
local WORLDSTATE_CORPOREALITY_MATERIAL  = 5049;
local WORLDSTATE_CORPOREALITY_TWILIGHT  = 5050;
local WORLDSTATE_CORPOREALITY_TOGGLE    = 5051;

local FACTION_HOSTILE = 14;
local NO_DESPAWN = 0;

-- For 3.3.5a
local GAMEOBJECT_BYTES_1	= 0x0006 + 0x000B;

RUBY_SANCTUM = {}

function RUBY_SANCTUM.InstanceOnLoad( iid )

	--[[ Developer notes: i discover argument iid isnt safe. If a player enter the function triggers and variables
	are created. But then if player from opposite faction enter variables wont be created with the same idd number.
	so will have no more choice than spend resources getting instance id again. ]]

	RUBY_SANCTUM[ iid ] = {

    --RUBY_SANCTUM[ iid ].baltharus = false;  -- hypers bugged tutorials...
    --RUBY_SANCTUM[ iid ].saviana = false;    -- hypers bugged tutorials...
    --RUBY_SANCTUM[ iid ].zarithrian = false; -- hypers bugged tutorials...

    baltharus = false,
    saviana = false,
    zarithrian = false,
	intro = false;
    phase = 0

    };

    print("debug: ruby sanctum variables created")
end

function RUBY_SANCTUM.OnPlayerEnter( iid, plr )

    --[[ Developer notes: i discover argument iid isnt safe. If a player enter the function triggers and variables
    are created. But then if player from opposite faction enter variables wont be created with the same idd number.
    so will have no more choice than spend resources getting instance id again. ]]

    local iid = plr:GetInstanceID();

    if( RUBY_SANCTUM[ iid ] == nil )
    then
        print("debug: ruby sanctum is nil")

	    RUBY_SANCTUM[ iid ] = {

        baltharus = false,
        saviana = false,
        zarithrian = false,
		intro = false,
        phase = 0
		
        };

        print("debug: ruby sanctum variables created")
    end
end

function RUBY_SANCTUM.OnCreatureDeath( iid, victim, killer )

    local iid = killer:GetInstanceID(); -- fucking idd argument

	local entry = victim:GetEntry();

    if( entry == 39751 )
    then
        RUBY_SANCTUM[ iid ].baltharus = true;
        print("debug: baltharus is dead");
        if( RUBY_SANCTUM[ iid ].saviana == true )
        then
            print("debug: and saviana is dead");
            local flame = victim:GetGameObjectNearestCoords( 3050.36, 526.1, 88.41, 203006 );
            print("open door")
            flame:SetByte( GAMEOBJECT_BYTES_1, 0, 0 );
        end

    elseif( entry == 39747 )
    then
        RUBY_SANCTUM[ iid ].saviana = true;
        print("debug: saviana is dead");
        if( RUBY_SANCTUM[ iid ].baltharus == true )
        then
            print("debug: and baltharus is dead");
            local flame = victim:GetGameObjectNearestCoords( 3050.36, 526.1, 88.41, 203006 );
            print("open door")
            flame:SetByte( GAMEOBJECT_BYTES_1, 0, 0 );
        end

    elseif( entry == 39746 )
    then
        RUBY_SANCTUM[ iid ].zarithrian = true;
        print("debug: zarithrian is dead");
        local controller = victim:GetCreatureNearestCoords( 3156.04, 533.266, 72.9721, 40146 );

        -- All hail Halion!

        controller:SpawnCreature( 39863, 3156.67, 533.8108, 72.98822, 3.159046, FACTION_HOSTILE, NO_DESPAWN, 1, 1, 1, 1, 0 );
    end
end

function RUBY_SANCTUM.OnAreaTrigger( iid, plr, areaID )

    if( areaID == AREA_TRIGGER and RUBY_SANCTUM[ iid ].intro == false )
    then
        RUBY_SANCTUM[ iid ].intro = true;
    end
end

function RUBY_SANCTUM.XerexOnSpawn( unit, event )

    local iid = unit:GetInstanceID();

    if( RUBY_SANCTUM[ iid ].phase == 0 )
    then
        unit:PlaySoundToSet( SOUND[ 9 ] );
        unit:SendChatMessage( 14, 0, CHAT[ 9 ] );
    end
end

RegisterUnitEvent( 40429, 18, RUBY_SANCTUM.XerexOnSpawn );

RegisterInstanceEvent( 724, 9, RUBY_SANCTUM.InstanceOnLoad );
RegisterInstanceEvent( 724, 2, RUBY_SANCTUM.OnPlayerEnter );
RegisterInstanceEvent( 724, 5, RUBY_SANCTUM.OnCreatureDeath );
RegisterInstanceEvent( 724, 3, RUBY_SANCTUM.OnAreaTrigger );
