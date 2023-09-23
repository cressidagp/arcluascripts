--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Global
	Creatures: Power Word Fortitude casters

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPCID_SCARLET_FRIAR = 1538

--local SPELL_POWER_WORD_FORTITUDE = 1243

OOC_POWER_WORD_FORTITUDE = {}

function OOC_POWER_WORD_FORTITUDE.CastBuff( unit, event )

	--
	-- on ai update
	--
	
    if event == 21 then
	
        if unit:IsInCombat() == false and unit:HasAura( 1243 ) == false then
		
            unit:FullCastSpell( 1243 )
            unit:ModifyAIUpdateEvent( 3000000 )
			
        end
	
	--
	-- on spawn
	--
	
    else
		local n = math.random( 3, 5 )
		unit:RegisterAIUpdateEvent( n * 1000 )
    end
end

-- Scarlet Friar:
RegisterUnitEvent( 1538, 18, OOC_POWER_WORD_FORTITUDE.CastBuff );
RegisterUnitEvent( 1538, 21, OOC_POWER_WORD_FORTITUDE.CastBuff );