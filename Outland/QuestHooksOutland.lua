--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Outland Quest Hooks
	Engine: A.L.E

  Credits:

  *) Trinity for gossips, texts, sound ids, timers, spell ids, move coords and some inspiration.
  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

	Developer notes: if this grows to big i will split on zones.

--]]

QUESTS_HOOK_OUTLAND = {}

function QUESTS_HOOK_OUTLAND.OnComplete( event, plr, questID, questEnder )

    if( plr:GetMapId() ~= 530 ) then return; end

    if( questID == 10254 )
    then
      questEnder:SendChatMessage( 12, 0, "Welcome to Honor Hold, "..plr:GetName()..".  It's good to have you." );
      --questEnder:CastSpellOnTarget( 6245, plr );
      questEnder:Emote( 66, 0 );
    end
end

RegisterServerHook( 22, QUESTS_HOOK_OUTLAND.OnComplete );
