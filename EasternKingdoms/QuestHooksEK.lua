--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Eastern Kingdoms Quest Hooks
	Engine: A.L.E

	Credits:

	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

	Developer notes: apparently there are some conflicts beetwen quests texts and gossips texts.
	If i add a gossip then quests text wont be displayed. Cant be solved script side.

--]]

QUESTS_HOOK_EK = {}

function QUESTS_HOOK_EK.OnComplete( event, plr, questID, questEnder )

end

--RegisterServerHook( 22, QUESTS_HOOK_EK.OnComplete );
