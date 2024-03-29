--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Global
	Creature: 'Lightning Shield' casters

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPC_VILE_FIN_MINOR_ORACLE	= 1544
--local NPC_ELDER_TIMBERLING		= 2030
--local NPC_VOODOO_TROLL			= 3206
--local NPC_RAZORMANE_MYSTIC		= 3271
--local NPC_GEOLORD_MOTTLE			= 5826

--local SPELL_LIGHTNING_SHIELD = 324

OOC_LIGHTNING_SHIELD = {}

function OOC_LIGHTNING_SHIELD.CastBuff( unit, event )

	if unit:IsInCombat() == true then return; end

	--
	-- on ai update
	--

    if event == 21 then

		if unit:HasAura( 324 ) == false then

            unit:FullCastSpell( 324 )

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

-- Vile Fin Minor Oracle:
RegisterUnitEvent( 1544, 18, OOC_LIGHTNING_SHIELD.CastBuff );
RegisterUnitEvent( 1544, 21, OOC_LIGHTNING_SHIELD.CastBuff );

-- Elder Timberling:
RegisterUnitEvent( 2030, 18, OOC_LIGHTNING_SHIELD.CastBuff );
RegisterUnitEvent( 2030, 21, OOC_LIGHTNING_SHIELD.CastBuff );

-- Voodoo Troll:
RegisterUnitEvent( 3206, 18, OOC_LIGHTNING_SHIELD.CastBuff );
RegisterUnitEvent( 3206, 21, OOC_LIGHTNING_SHIELD.CastBuff );

-- Razormane Mystic:
RegisterUnitEvent( 3271, 18, OOC_LIGHTNING_SHIELD.CastBuff );
RegisterUnitEvent( 3271, 21, OOC_LIGHTNING_SHIELD.CastBuff );

-- Geolord Mottle:
RegisterUnitEvent( 5826, 18, OOC_LIGHTNING_SHIELD.CastBuff );
RegisterUnitEvent( 5826, 21, OOC_LIGHTNING_SHIELD.CastBuff );