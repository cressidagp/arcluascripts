--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Durotar
	GameObject: Benedict Chets (3239)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

-- local GO_CHEST = 3239;
-- local NPC_MARINE = 3129

BENEDICT_CHEST = {};

function BENEDICT_CHEST.OnActivate( go, event )

    local marine = go:SpawnCreature( 3129, go:GetX(), go:GetY(), go:GetZ(), 14, 0, 0, 0, 0, 1, 0 );

    marine:SendChatMessage( 12, 0, "Step away from the Lieutenants belongings!" );

end

RegisterGameObjectEvent( 3239, 4, BENEDICT_CHEST.OnActivate );