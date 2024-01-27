--[[  

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Global
	Creature: Razormane Quillboar

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
--]]

--local NPC_RAZORMANE_QUILBOAR = 3111

--local SPELL_RAZOR_MANE = 5280

RAZORMANE_QUILBOAR = {}

function RAZORMANE_QUILBOAR.OoCCastBuff( unit, event )

	--
	-- on ai update
	--
	
    if event == 21 then
        if unit:IsInCombat() == false and unit:HasAura( 5280 ) == false then
     
            unit:FullCastSpell( 5280 )
            unit:ModifyAIUpdateEvent( 45000 )
		end
	
	--
	-- on spawn
	--
		
	else
		local n = math.random( 3, 5 )
        unit:RegisterAIUpdateEvent( n * 1000 )
    end	
end


RegisterUnitEvent( 3111, 18, RAZORMANE_QUILBOAR.OoCCastBuff );
RegisterUnitEvent( 3111, 21, RAZORMANE_QUILBOAR.OoCCastBuff );