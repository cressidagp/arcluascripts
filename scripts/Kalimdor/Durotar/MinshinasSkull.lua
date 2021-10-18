--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Durotar
	Quest: Minshina's Skull
	
	Credits:

	*) TrinityCore for texts, sounds, timers, spells and some Inspiration.
	*) DarkAngel39 for his instance progression system.
	*) Marforius for ArcAddons who make my life much easier.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
						
--]]

--local FACTION_FRIENDLY = 35;
--local EMOTE_ONESHOT_BOW = 2;
--local UNIT_FIELD_TARGET = 0x0006 + 0x000C;

MINSHINAS_SKULL = {};

function MINSHINAS_SKULL.OnComplete( plr, questID )

	-- Developer notes:	i will leave quest id check here since in future this function will 
	-- expand to a zone quest function.
	
	if( questID == 808 )
	
	then
	
		local master = plr:GetCreatureNearestCoords( -825.636, -4920.76, 19.7409, 3188 );
		
		if( master ~= nil )
		
		then
		
			local spirit = plr:SpawnCreature( 3289, -822.91, -4923.33, 19.6365, 3.41642, 35, 11000, 1, 1, 1, 1, 0 );
			
			-- master and minshina face player
			
			local guid = plr:GetGUID();
			
			spirit:SetUInt64Value( 0x0006 + 0x000C, guid );
			
			master:SetUInt64Value( 0x0006 + 0x000C, guid );
			
			
			-- master chat and minshina emote
			
			master:EventChat( 12, 0, "I thank you, "..plr:GetName()..".  And my brother thanks you.", 3000 );
			
			spirit:RegisterEvent( MINSHINAS_SKULL.EventEmote, 2000, 1 );
			
			
			-- master dont look to plr anymore
			
			master:RegisterEvent( MINSHINAS_SKULL.ClearTarget, 9000, 1 );
			
		end
		
	end
	
end

function MINSHINAS_SKULL.ClearTarget( unit )

	unit:SetUInt64Value( 0x0006 + 0x000C, 0 );

end

function MINSHINAS_SKULL.EventEmote( unit )

	unit:Emote( 2, 0 );

end

RegisterQuestEvent( 808, 2, MINSHINAS_SKULL.OnComplete );