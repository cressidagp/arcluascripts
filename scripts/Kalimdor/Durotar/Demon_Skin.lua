--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Durotar
	Creature: Demon Skin casters

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPC_GAZZUZ = 3204;
--local NPC_FELWEAVER_SCORN = 5822;
--local NPC_FROSTMANE_SHADOWCASTER = 1124;

--local SPELL_DEMON_SKIN = 20798;

OOC_DEMON_SKIN = {};

function OOC_DEMON_SKIN.CastBuff( unit, event )

	-- on ai update
	if( event == 21 )
	then
		if( unit:IsInCombat() == false and unit:HasAura( 20798 ) == false )
		then
			unit:FullCastSpell( 20798 );
			unit:ModifyAIUpdateEvent( 1800000 );	
		end
	
	-- on spawn
	else
		local n = math.random( 3, 5 );
		unit:RegisterAIUpdateEvent( n * 1000 ); 	
	end	
end

RegisterUnitEvent( 3204, 18, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 3204, 21, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 5822, 18, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 5822, 21, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 1124, 18, OOC_DEMON_SKIN.CastBuff );
RegisterUnitEvent( 1124, 21, OOC_DEMON_SKIN.CastBuff );