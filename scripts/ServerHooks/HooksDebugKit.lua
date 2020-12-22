--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Debug Kit
	Engine: A.L.E
	
	Credits:

	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

	Developer notes: this one save me a lot of time in debuggin quest and spells.
	
	WARNING: disabled by default.

--]]

HOOKS_DEBUG = {}

function HOOKS_DEBUG.Consolidated( event, plr, argC, argD )

	if( plr:IsGm() == true )
	then
		if( event == 8 ) -- OnEmote
		then
			plr:SendBroadcastMessage( "Emote ID: "..argD.." " );
		
		elseif( event == 10 ) -- OnCastSpell
		then
			plr:SendBroadcastMessage( "Spell ID: "..argC.." " );

		elseif( event == 14 or event == 22 ) -- QuestAccept or QuestComplete
		then
			plr:SendBroadcastMessage( "QuestId: "..argC.." " );
			if( argD ~= nil )
			then
				plr:SendBroadcastMessage( "QuestGiver: "..argD:GetEntry().. " " );
			end

		elseif( event == 26) -- OnAreaTrigger
		then
			plr:SendBroadcastMessage("AT: "..argC.. " " );
		end
	end
end

--RegisterServerHook( 8, HOOKS_DEBUG.Consolidated );
--RegisterServerHook( 10, HOOKS_DEBUG.Consolidated );
--RegisterServerHook( 14, HOOKS_DEBUG.Consolidated );
--RegisterServerHook( 22, HOOKS_DEBUG.Consolidated );
--RegisterServerHook( 26, HOOKS_DEBUG.Consolidated );
