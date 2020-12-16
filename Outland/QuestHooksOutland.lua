--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Outland Quest Hooks
	Engine: A.L.E

  Credits:

  *) Trinity for texts and spell ids.
  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.
  
  enus: "Welcome to Honor Hold, "..plr:GetName()..".  It's good to have you."
  
  esmx: "Bienvenido a Honor Hold, gonzalo. Es bueno tenerte."

--]]

QUESTS_HOOK_OUTLAND = {}

function QUESTS_HOOK_OUTLAND.OnComplete( event, plr, questID, questEnder )

    if( plr:GetMapId() ~= 530 ) then return; end

    if( questID == 10254 ) -- Force Commander Danath
    then
      questEnder:SendChatMessage( 12, 0, "Welcome to Honor Hold, "..plr:GetName()..".  It's good to have you." );
      questEnder:CastSpellOnTarget( 6245, plr );
    end
end

RegisterServerHook( 22, QUESTS_HOOK_OUTLAND.OnComplete );
