--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Halls of Reflection
	Engine: A.L.E
	Credits: nil

	Developer notes: in time i will change this to paroxysm modular way to save some resources.

--]]

-- Spells:
local SPELL_A_PHASE   = 60027; -- Phase +64
local SPELL_H_PHASE   = 60028; -- Phase +128

HOR = {}

function HOR.InstanceOnLoad( iid )

    -- check if iid its safe here

    print(iid)

	  HOR[ iid ] = {

    --HOR[ iid ].falric = false;
    --HOR[ iid ].marwyn = false;
    --HOR[ iid ].general = false;
    falric = false,
    marwyn = false,
    general = false

    };

    print("debug: halls of reflection variables created")
end

function HOR.OnPlayerEnter( iid, plr )

    --[[ Developer notes: i discover argument iid isnt safe. If a player enter the function triggers and variables
    are created. But then if player from opposite faction enter variables wont be created with the same idd number.
    so will have no more choice than spend resources getting instance id again. ]]

    local iid = plr:GetInstanceID();

    if( HOR[ iid ] == nil )
    then
        print("debug: halls of reflection is nil")

	      HOR[ iid ] = {

        --HOR[ iid ].falric = false;
        --HOR[ iid ].marwyn = false;
        --HOR[ iid ].general = false;
        --team = plr:GetTeam(),
        falric = false,
        marwyn = false,
        general = false

        };

        print("debug: halls of reflection variables created")

    end

    if( plr:GetTeam() == 0 )
    then
        plr:CastSpell( SPELL_A_PHASE );
        print("debug: halls of reflection set alliance phase")
    else
        plr:CastSpell( SPELL_H_PHASE );
        print("debug: halls of reflection set horde phase")
    end
end

function HOR.OnZoneOut( event, plr, NewZoneId, OldZoneId )

    if( OldZoneId == 668 )
    then
        plr:SetPhase( 1, 1 );
    end
end

RegisterInstanceEvent( 668, 9, HOR.InstanceOnLoad );
RegisterInstanceEvent( 668, 2, HOR.OnPlayerEnter );
RegisterInstanceEvent( 668, 4, HOR.OnZoneOut );
