--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Quest Hooks
	Engine: A.L.E

  Credits:

  *) Trinity for texts and spell ids.
  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.
  
  enUS: "Welcome to Honor Hold, "..plr:GetName()..".  It's good to have you."
  
  esMX: "Bienvenido a Honor Hold, "..plr:GetName()..". Es bueno tenerte."

--]]

HOOKS_QUEST = {};

function HOOKS_QUEST.OnComplete( event, plr, questID, questEnder )

    if( questID == 10254 ) -- Force Commander Danath
    then
      questEnder:SendChatMessage( 12, 0, "Welcome to Honor Hold, "..plr:GetName()..".  It's good to have you." );
      questEnder:CastSpellOnTarget( 6245, plr );
    end
end

RegisterServerHook( 22, HOOKS_QUEST.OnComplete );
