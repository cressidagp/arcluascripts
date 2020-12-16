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

--]]

NECKLACE = {}

function NECKLACE.OnComplete( plr, questID )

	if( questID == 3741 )
	then
		local hillary = plr:GetCreatureNearestCoords( -9351.52, -2205.56, 62.19, 8962 );
		if( hillary ~= nil )
		then
			hillary:EventChat( 12, 0, "I know how to speak kitty, and Effsee said thank you.", 2000 );
			
			
			local effsee = plr:GetCreatureNearestCoords( -9351.24, -2204.45, 62.18, 8963 );
			effsee:SendChatMessage( 12, 0, "Meow!" );
		end
	end
end

RegisterQuestEvent( 3741, 2, NECKLACE.OnComplete );
