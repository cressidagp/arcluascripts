--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Redridge Mountains: Quest: Hillary Necklace
	Engine: A.L.E

	Credits:

	*) Trinity for texts.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

	Developer notes: apparently there are some conflicts beetwen quests texts and gossips texts.
	If i add a gossip then quests text wont be displayed. Cant be solved script side.

--]]

QUESTS_HOOK_EK = {}

function QUESTS_HOOK_EK.OnComplete( event, plr, questID, questEnder )

	if( questID == 3741 ) -- Hilary Necklace
	then
			questEnder:EventChat( 12, 0, "I know how to speak kitty, and Effsee said thank you.", 2000 );
			local effsee = plr:GetCreatureNearestCoords( -9351.24, -2204.45, 62.18, 8963 );
			effsee:SendChatMessage( 12, 0, "Meow!" );
	end
end

RegisterServerHook( 22, QUESTS_HOOK_EK.OnComplete );
