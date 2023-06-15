--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Quest: The Escape
	Zone: Elwynn Forest
	
	Credits:
	
	*) Trinity for texts and spell ids.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.
	
	enUS locale: "Here goes nothing..."
	esMX locale:

--]]

--local EMOTE_ONESHOT_EAT = 7

THE_ESCAPE = {};

function THE_ESCAPE.OnComplete( plr, questID )

	if( questID == 114 )
	then
		local maybell = plr:GetCreatureNearestCoords( -10014.00, 37.60, 35.25, 251 );

		if( maybell ~= nil )
		then
			maybell:SetFacing( 5.39307 );
			maybell:SendChatMessage( 12, 0, "Here goes nothing..." );
			maybell:Emote( 7, 0 );
			maybell:Despawn( 5000, 30000 );	
		end
	end
end

RegisterQuestEvent( 114, 2, THE_ESCAPE.OnComplete );
