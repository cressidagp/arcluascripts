--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Dummy: Force Target Salute (6245)
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	Precondition(s):

	*) Need a target.

	Effect(s):

	*) Makes unit salute the target.
	*) The target salutes back unit.

--]]

function ForceTargetSalute_DummyHandler( _, spellObject )

	local target = spellObject:GetTarget();

	if( target ~= nil ) then
	
		local caster = spellObject:GetCaster();

		caster:Emote( 66, 0 );
		target:Emote( 66, 0 );
	end
end

RegisterDummySpell( 6245, ForceTargetSalute_DummyHandler );