--[[  
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Durotar: Minshina's Skull
	Engine: A.L.E
	Credits: nil
	
	Developer notes:	if someday we can implement something like EventResetTarget, EventEmote 
					this script will wil use 2 less functions. I should try to implement them
					but if i fail then will have no more choice to open a ticket and cross fingers.
						
--]]

local FACTION_FRIENDLY = 35;
local EMOTE_ONESHOT_BOW = 2;
local UNIT_FIELD_TARGET = 0x0006 + 0x000C;

MINSHINAS_SKULL = {}

function MINSHINAS_SKULL.ResetTarget( unit )

    unit:SetUInt64Value( UNIT_FIELD_TARGET, 0 );

end

function MINSHINAS_SKULL.EventEmote( unit )

	unit:Emote( EMOTE_ONESHOT_BOW, 0 );

end

function MINSHINAS_SKULL.OnComplete( plr, questID )

	--[[ Developer notes:	i will leave quest id check here since in future this function will 
							expand to a zone quest function --]]

	if( questID == 808 )
	
	then
	
		local master = plr:GetCreatureNearestCoords( -825.636, -4920.76, 19.7409, 3188 );
		
		if( master ~= nil )
		
		then
		
			local spirit = plr:SpawnCreature( 3289, -822.91, -4923.33, 19.6365, 3.41642, FACTION_FRIENDLY, 11000, 1, 1, 1, 1, 0 );
			
			-- master and minshina face player
			
			local guid = plr:GetGUID();
			
			spirit:SetUInt64Value( UNIT_FIELD_TARGET, guid );
			
			master:SetUInt64Value( UNIT_FIELD_TARGET, guid );
			
			
			-- master chat and minshina emote
			
			master:EventChat( 12, 0, "I thank you, "..plr:GetName()..".  And my brother thanks you.", 3000 );
			
			spirit:RegisterEvent( MINSHINAS_SKULL.EventEmote, 2000, 1 );
			
			
			-- master dont look to plr anymore
			
			master:RegisterEvent( MINSHINAS_SKULL.ResetTarget, 9000, 1 );
			
		end
		
	end
	
end

RegisterQuestEvent( 808, 2, MINSHINAS_SKULL.OnComplete );
