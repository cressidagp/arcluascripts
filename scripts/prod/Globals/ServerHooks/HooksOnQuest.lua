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

--]]

HOOKS_QUEST = {}

function HOOKS_QUEST.OnComplete( event, plr, questId, questEnder )

	if questId == 823 then
		questEnder:SendChatMessage( 16, 0, ""..questEnder:GetName().." listens to "..plr:GetName().."'s report..." )
		questEnder:EventChat( 12, 1, What??  The Burning Blade is spreading!  We must investigate!, 2000 )
	end
	
	if questId == 806 then
		questEnder:SendChatMessage( 16, 0, "We will suffer no demon's servant in our lands!" )
		questEnder:EventChat( 12, 1, What??  The Burning Blade is spreading!  We must investigate!, 2000 )
	end
		
    if questId == 10254 then
		questEnder:SendChatMessage( 12, 0, "Welcome to Honor Hold, "..plr:GetName()..".  It's good to have you." )
		questEnder:CastSpellOnTarget( 6245, plr );
	end
end

RegisterServerHook( 22, HOOKS_QUEST.OnComplete );
