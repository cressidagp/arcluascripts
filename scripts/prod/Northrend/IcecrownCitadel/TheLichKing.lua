--local NPC_THE_LICH_KING = 36597
--local NPC_TIRION_FORDRING = 38995
--local NPC_TERENAS_MENETHIL = 36823

--local SPELLID_PLAY_MOVIE = 73159

local self = getfenv( 1 )

--
-- The Lich King
--
--
function TheLichKing_onSpawn( unit, event )

	unit:RegisterAIUpdateEvent( 1000 )

end

function TheLichKing_onEnterCombat( unit, event, attacker )

end

function TheLichKing_onTargetDied( unit, event, victim )

	if victim:IsPlayer() == true then
	
		if math.random( 0, 1 ) == 0 then
		
			unit:PlaySoundToSet( 17363 )
			
			unit:SendChatMessage( 14, 0, "Hope wanes..." )
			
		else
		
			unit:PlaySoundToSet( 17364 )
			
			unit:SendChatMessage( 14, 0, "The end has come!" )
		
		end
		
	end

end

function TheLichKing_onDied( unit, event, killer )

	-- cast: Play Movie
	unit:CastSpell( 73159 )

end

function TheLichKing_onAIUpdate( unit, event )

end

function TheLichKing_onDamageTaken( unit, event, attacker, damage )

end

--
-- Highlord Tirion Fordring (at Frozen Throne)
--
--
function Tirion_FT_onSpawn( unit, event )

end

function Tirion_FT_onAIUpdate( unit, event )

end

function Tirion_FT_onHello( unit, event, plr )
	
	unit:GossipCreateMenu( 15290, plr, 0 )
	
	unit:GossipMenuAddItem( 0, "We are prepared, Highlord. Let us battle for the fate of Azeroth! For the light of dawn!", 1, 0 )
	
	unit:GossipSendMenu( plr )
	
end

function Tirion_FT_onSelect( unit, event, plr, id, selection, code )
	
	if selection == 1 then
	
		unit:RegisterAIUpdateEvent( 1000 )
		--remove npc flag
		
	end

	plr:GossipComplete()

end

--
-- King Terenas Menethil
--
--
function Terenas_FT_onSpawn( unit, event )

	unit:RegisterAIUpdateEvent( 1000 )

end

function Terenas_FT_onAIUpdate( unit, event )

end

--
-- Function(s) register
--
--
RegisterUnitEvent( 36597, 18, TheLichKing_onSpawn )
RegisterUnitEvent( 36597, 1, TheLichKing_onEnterCombat )
RegisterUnitEvent( 36597, 3, TheLichKing_onTargetDied )
RegisterUnitEvent( 36597, 4, TheLichKing_onDied )
RegisterUnitEvent( 36597, 21, TheLichKing_onSpawn_onAIUpdate )
RegisterUnitEvent( 36597, 23, TheLichKing_onDamageTaken )

RegisterUnitEvent( 38995, 18, Tirion_FT_onSpawn )
RegisterUnitEvent( 38995, 21, Tirion_FT_onAIUpdate )
RegisterUnitGossipEvent( 38995, 1, Tirion_FT_onHello )
RegisterUnitGossipEvent( 38995, 2, Tirion_FT_onSelect )

RegisterUnitEvent( 36823, 18, Terenas_FT_onSpawn )
RegisterUnitEvent( 36823, 21, Terenas_FT_onAIUpdate )