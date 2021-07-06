--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Quest: "Strange Brew"
	Engine: A.L.E

	Credits:

	*) Trinity for text, emote and timer.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

	enUS: "ACK!  That's the worst thing I've ever tasted!  I wouldn't let my ram drink that!"

	esMX: "¡PUAJ! ¡Eso es lo peor que he probado en mi vida! ¡No dejaría ni que mi carnero bebiera eso!"

--]]

STRANGE_BREW = {};

function STRANGE_BREW.OnComplete( plr, questID )

	if( questID == 10511 )
	then
		local borgrim = plr:GetCreatureNearestCoords( 2069.85, 6816.89, 175.68, 21151 );
		if( borgrim ~= nil )
		then
			borgrim:EventChat( 12, 0, "ACK!  That's the worst thing I've ever tasted!  I wouldn't let my ram drink that!", 5000 );
			borgrim:Emote( 1, 0 );
		end
	end
end

RegisterQuestEvent( 10511, 2, STRANGE_BREW.OnComplete );
