--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Global
	Creatures: Devotion Aura casters

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPCID_CAPTAIN_MALRACHE = 1665

--local SPELL_DEVOTION_AURA = 8258

OOC_DEVOTION_AURA = {}

function OOC_DEVOTION_AURA.CastBuff( unit, event )

	if unit:IsInCombat() == true then return; end

	--
	-- on ai update
	--

    if event == 21 then

        if unit:HasAura( 8258 ) == false then

            unit:FullCastSpell( 8258 )

            unit:ModifyAIUpdateEvent( 1000 )

        end

	--
	-- on spawn
	--

    else

		local n = math.random( 3, 5 )

		unit:RegisterAIUpdateEvent( n * 1000 )

    end

end

-- Captain Melrache:
RegisterUnitEvent( 1665, 18, OOC_DEVOTION_AURA.CastBuff );
RegisterUnitEvent( 1665, 21, OOC_DEVOTION_AURA.CastBuff );