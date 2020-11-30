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
    --RUBY_SANCTUM[ iid ].baltharus = false;
    --RUBY_SANCTUM[ iid ].saviana = false;
    --RUBY_SANCTUM[ iid ].zarithrian = false;
    baltharus = false,
    saviana = false,
    zarithrian = false
    };
    print("debug: ruby sanctum variables created")
end


RegisterInstanceEvent( 724, 9, RUBY_SANCTUM.InstanceOnLoad );