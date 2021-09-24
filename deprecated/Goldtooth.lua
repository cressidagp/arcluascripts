--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E	  

	Zone: Elwynn Forest
	Creature: Goldtooth (327)

 	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

--]]

--NPC_GOLDTOOTH	= 327;
--local SPELL_SELF_FEAR = 31365;
--local MOVE_FLAGS_WALK = 0;
--local FLEE_TIME = 10000;
--local CHAT_MSG_MONSTER_EMOTE = 16;

GOLDTOOTH = {};

--[[
function GOLDTOOTH.OnFlee( unit, event, fearer )
	unit:SendChatMessage( 12, 7, "DEBUG FLEE" );
end

function GOLDTOOTH.OnDamageTaken( unit )
	local hp = unit:GetHealthPct();
	if( hp <= 80 )
	then
		local sUnit = tostring( unit );
		local vars = GOLDTOOTH[ sUnit ];
		
		
		
		unit:SendChatMessage( 16, 0, "%s attempts to run away in fear!" );
		--unit:DisableCombat( 1 )
		--unit:SetRun();
		--unit:CastSpell( 31365 );
		--unit:SetAIState( 3 );
		--unit:FullCastSpell( 31365 );
		--unit:CastSpellOnTarget( 31365, unit );
		--unit:SetUInt64Value( 0x0006 + 0x000C, 0 );
	end
end
--]]

function GOLDTOOTH.OnCombat( unit, event )

	local sUnit = tostring( unit );

	-- on ai update
	if( event == 21 )
	then
		hp = unit:GetHealthPct();
		
		local vars = GOLDTOOTH[ sUnit ];
		
		if( hp <= 80 and vars.hasFleed == false )
		then
			unit:SetUInt32Value( 0x0006 + 0x0048, 0 )
			unit:DisableCombat( 1 );
			unit:SetMovementFlags( 1 );
			unit:SetUInt64Value( 0x0006 + 0x000C, 0 );
			unit:WipeCurrentTarget();
			--unit:SetAIState( 3 )
			unit:CastSpell( 31365 );
			--unit:AddAura( 31365, 0 )
			--unit:SendChatMessage( 16, 0, "%s attempts to run away in fear!" );
			
			vars.hasFleed = true;
		end
		
	-- on combat
	else
	
		GOLDTOOTH[ sUnit ] = {
		
		hasFleed = false,
		
		};

		unit:RegisterAIUpdateEvent( 1000 );
	end
end

--RegisterUnitEvent( 327, 16, GOLDTOOTH.OnFlee );
RegisterUnitEvent( 327, 18, GOLDTOOTH.OnCombat );
RegisterUnitEvent( 327, 21, GOLDTOOTH.OnCombat );
--RegisterUnitEvent( 327, 23, GOLDTOOTH.OnDamageTaken );