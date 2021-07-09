--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Quest: Collecting Kelp
	Zone: Elwynn Forest
	
	Credits:
	
	*) Trinity for texts and spell ids.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.
	
	enUS locale:
	
	"This shouldn't take long..."
	"The invisibility liquor is read for you, "..plr:GetName().."."
	
	esMX locale:

--]]

--local EMOTE_STATE_USESTANDING = 69

COLLECTING_KELP = {};

function COLLECTING_KELP.OnAIUpdate( unit )

	--unit:SendChatMessage( 12, 0, "The invisibility liquor is read for you, "..plr:GetName().."." );
	unit:SetFacing( 2.98 );
	unit:SetNPCFlags( 2 );
	unit:RemoveAIUpdateEvent();
	
end

function COLLECTING_KELP.OnComplete( plr, questID )

	if( questID == 112 )
	then
		local william = plr:GetCreatureNearestCoords( -9460.30, 31.94, 57.05, 253 );

		if( william ~= nil )
		then
			william:SendChatMessage( 12, 0, "This shouldn't take long..." );
			william:SetFacing( 1,45219 );
			william:Emote( 69, 4000 );
			william:SetNPCFlags( 0 );
			william:RegisterAIUpdateEvent( 6000 );
			william:EventChat( 12, 0, "The invisibility liquor is read for you, "..plr:GetName()..".", 6000 );
		end
	end
end

RegisterUnitEvent( 253, 21, COLLECTING_KELP.OnAIUpdate );
RegisterQuestEvent( 112, 2, COLLECTING_KELP.OnComplete );
