--[[
      ArcLuaScripts for ArcEmu
      www.ArcEmu.org
      Silvermoon City: Keyanomir and Minion
      Engine: A.L.E
      Credits: nil

      Developer notes: since summons spells are bugged or unimplemented in arcemu
                       (if unit is creature) we dont have more choice than spawn them
                       manually... at least for now.
--]]

--local UNIT_FIELD_SUMMONEDBY = 0x0006 + 0x0008;
--local UNIT_FIELD_CREATEDBY  = 0x0006 + 0x000A;

KEYANOMIR = {};

function KEYANOMIR.OnSpawnAndDeath( unit, event )

    if( event == 4 )

    then

        local minion = unit:GetCreatureNearestCoords( 9715.04, -7311.68, 24.84, 18232 );

        if( minion ~= nil )

        then

            minion:Despawn( 1000, 0 );

        end

    elseif( event == 18 )

    then

        local minion = unit:SpawnCreature( 18232, 9715.04, -7311.68, 24.84, 4.8, 1604, 0, 0, 0, 0, 1, 0 );

        local guid = unit:GetGUID();

        minion:SetUInt64Value( 0x0006 + 0x0008, guid );

        minion:SetUInt64Value( 0x0006 + 0x000A, guid );

    end

end

RegisterUnitEvent( 18231, 4, KEYANOMIR.OnSpawnAndDeath );
RegisterUnitEvent( 18231, 18, KEYANOMIR.OnSpawnAndDeath );
