QUESTS_HOOK_OUTLAND = {}

function QUESTS_HOOK_OUTLAND.OnComplete( event, plr, questID, questEnder )

    if( plr:GetMapId() ~= 530 ) then return; end

    if( questID == 10254 )
    then
      questEnder:SendChatMessage( 12, 0, "Welcome to Honor Hold, "..plr:GetName()..".  It's good to have you." );
      -- questEnder:CastSpellOnTarget( 6245 );
      questEnder:Emote( 66, 0 );
    end
end

RegisterServerHook( 22, QUESTS_HOOK_OUTLAND.OnComplete );
