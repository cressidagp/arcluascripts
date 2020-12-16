--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Force Target Salute (6245)
	Engine: A.L.E

  Credits:

  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

function ForceTargetSaluteDummy( effectIndex, spellObject )

	local caster = spellObject:GetCaster();
	local target = spellObject:GetTarget();

	caster:Emote( 66, 0 );
	target:Emote( 66, 0 );
	
end

RegisterDummySpell( 6245, ForceTargetSaluteDummy );
