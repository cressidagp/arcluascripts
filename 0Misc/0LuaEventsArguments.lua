--[[

//Creature Event Arguments:

OnEnterCombat( unit, event, attacker )
OnLeaveCombat( unit, event, target )
OnTargetDied( unit, event, victim )
OnDied( unit, event, killer )
OnTargetParried( unit, event, target )
OnTargetDodged( unit, event, target )
OnTargetBlocked( unit, event, target, ammount )
OnTargetCritHit( unit, event, target, ammount )
OnParry( unit, event, currentTarget )
OnDodged( unit, event, currentTarget )
OnBlocked( unit, event, currentTarget, ammount )
OnCritHit( unit, event, currentTarget, ammount )
OnHit( unit, event, currentTarget, ammount )
OnAssistTargetDied( unit, event, assistTarget )
OnFear( unit, event, targetFeared, spell_id )
OnFlee( unit, event, fearer )
OnCallForHelp( unit, event )
OnLoad( unit, event )
OnReachWaypoint( unit, event, waypointId, foward )
OnLookTaken( unit, event, player, item )
OnAIUpdate( unit, event )
OnEmote( unit, event, player, emoteId )
OnDamageTaken( unit, event, attacker, damage )
OnEnterVehicle( unit, event )
OnExitVehicle( unit, event )
OnFirstPassengerEntered( unit, event, passanger )
OnVehicleFull( unit, event )
OnLastPassengerLeft( unit, event, passanger )

//Gameobjects Events Arguments:

OnCreate( go, event )
OnSpawn( go, event )
OnLootTaken( go, event, player, item )
OnUse( go, event, player )
OnAIUpdate( go, event )
OnDespawn( go, event )
OnDamaged( go, event, damage )
OnDestroyed( go, event )

//Gossips Events Arguments:

OnTalk()
OnSelectOption()
OnEnd()

//Quest Events:

OnAccept()
OnComplete()
OnCancel()
OnGameObjectActivate()
OnCreatureKill()
OnExploreArea()
OnItemPickup()

--]]
