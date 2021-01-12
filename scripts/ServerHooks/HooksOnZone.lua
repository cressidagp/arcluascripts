--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Hooks Zone
	Engine: A.L.E

	Credits:

	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

local ZONE_EBON_BLADE	= 4298;
local SPELL_UNDYING_RESOLVE	= 51915;

--]]

HOOKS_ZONE = {}

function HOOKS_ZONE.OnEnterOrLeave( _, plr, _, OldZoneId )

	if( OldZoneId == 4298 ) -- Ebon Hold
	then
		plr:RemoveAura( 51915 ); -- Undying Resolve
	end
end

RegisterServerHook( 15, HOOKS_ZONE.OnEnterOrLeave );
