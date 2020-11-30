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
    --RUBY_SANCTUM[ iid ].baltharus = false;	-- hypers bugged tutorials...
    --RUBY_SANCTUM[ iid ].saviana = false;		-- hypers bugged tutorials...	
    --RUBY_SANCTUM[ iid ].zarithrian = false;	-- hypers bugged tutorials...
    baltharus = false,
    saviana = false,
    zarithrian = false
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
        --RUBY_SANCTUM[ iid ].baltharus = false;	-- hypers bugged tutorials...
        --RUBY_SANCTUM[ iid ].saviana = false;		-- hypers bugged tutorials...
        --RUBY_SANCTUM[ iid ].zarithrian = false;	-- hypers bugged tutorials...
        baltharus = false,
        saviana = false,
        zarithrian = false
        };
        print("debug: ruby sanctum variables created")
    end
end


RegisterInstanceEvent( 724, 9, RUBY_SANCTUM.InstanceOnLoad );
RegisterInstanceEvent( 724, 2, RUBY_SANCTUM.OnPlayerEnter );