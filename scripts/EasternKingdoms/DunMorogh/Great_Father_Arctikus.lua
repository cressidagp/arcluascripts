--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Dun Morogh
	Creature: Great Father Arctikus (1260)

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--GREAT_FATHER_ARCTIKUS = 1260;
--SPELL_RENEW = 139;
--SPELL_LESSER_HEAL = 2053;

GREAT_FATHER_ARCTIKUS = {};

function GREAT_FATHER_ARCTIKUS.OnDamageTaken( unit, _, _, damage )

	local hp = unit:GetHealthPct();
	
	if( hp < 75 )
	then
		unit:CastSpell( 139 );
	
	elseif( hp < 20 )
	then
		unit:FullCastSpell( 2053 );
	end
end

RegisterUnitEvent( 1260, 23, GREAT_FATHER_ARCTIKUS.OnDamageTaken );