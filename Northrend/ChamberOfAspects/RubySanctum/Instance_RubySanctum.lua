--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	The Ruby Sanctum
	Engine: A.L.E
	Credits: Trinity for sound ids, chats and worldstates.

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

local SOUND = {
[ 1 ] = ;
};

local CHAT = {
[ 1 ] = "";
};

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

    -- check if iid its safe here

    print(iid)
	  RUBY_SANCTUM[ iid ] = {
    --RUBY_SANCTUM[ iid ].baltharus = false;  -- hypers bugged tutorials...
    --RUBY_SANCTUM[ iid ].saviana = false;    -- hypers bugged tutorials...
    --RUBY_SANCTUM[ iid ].zarithrian = false; -- hypers bugged tutorials...
    baltharus = false,
    saviana = false,
    zarithrian = false,
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
        --RUBY_SANCTUM[ iid ].baltharus = false;  -- hypers bugged tutorials...
        --RUBY_SANCTUM[ iid ].saviana = false;    -- hypers bugged tutorials...
        --RUBY_SANCTUM[ iid ].zarithrian = false; -- hypers bugged tutorials...
        baltharus = false,
        saviana = false,
        zarithrian = false,
        phase = 0
        };
        print("debug: ruby sanctum variables created")
    end
end

function RUBY_SANCTUM.OnCreatureDeath( iid, victim, killer )

    local iid = killer:GetInstanceID(); -- fucking idd argument

    if( victim:GetEntry() == 39751 )
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

    elseif( victim:GetEntry() == 39747 )
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

    elseif( victim:GetEntry() == 39746 )
    then
        RUBY_SANCTUM[ iid ].zarithrian = true;
        print("debug: zarithrian is dead");
        local controller = victim:GetCreatureNearestCoords( 3156.04, 533.266, 72.9721, 40146 );

        -- All hail Halion!

        controller:SpawnCreature( 39863, 3156.67, 533.8108, 72.98822, 3.159046, FACTION_HOSTILE, NO_DESPAWN, 1, 1, 1, 1, 0 );
    end
end

function RUBY_SANCTUM.XerexOnSpawn( unit, event )
    local iid = unit:GetInstanceID();
    if( RUBY_SANCTUM[ iid ].phase = 0 )
    then
        unit:PlaySoundToSet( 40598 );
        unit:SendChatMessage( 14, 0, "Help! I am trapped within this tree!  I require aid!" );
    end
end

RegisterUnitEvent( 40429, 18, RUBY_SANCTUM.XerexOnSpawn)

RegisterInstanceEvent( 724, 9, RUBY_SANCTUM.InstanceOnLoad );
RegisterInstanceEvent( 724, 2, RUBY_SANCTUM.OnPlayerEnter );
RegisterInstanceEvent( 724, 5, RUBY_SANCTUM.OnCreatureDeath );
