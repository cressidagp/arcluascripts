--[[	
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E	
	
	Zone: Stormwind City
	Creature: Brother Sarno
	
	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale: "Greetings, "..BROTHER_SARNO.target:GetPlayerClass().."! Welcome to the Cathedral of Light!"
	
	esMX local: "¡Saludos, "..BROTHER_SARNO.target:GetPlayerClass().."! ¡Bienvenido a la Catedral de la Luz!"
	
--]]

--local NPC_BROTHER_SARNO = 7917;
--local EMOTE_ONESHOT_WAVE = 3;
--local UNIT_FIELD_TARGET = 0x0006 + 0x000C;

BROTHER_SARNO = {}

function BROTHER_SARNO.OnSpawnOrAIUpdate( unit, event )

	local sUnit = tostring( unit );
	
	-- on ai update
	if( event == 21 )
	then
		if( unit:IsInCombat() == true ) then return; end
		
		local vars = BROTHER_SARNO[ sUnit ];
		
		vars.talkTime = vars.talkTime - 1;
		vars.reset = vars.reset - 1;
		vars.cooldown = vars.cooldown  - 1;
			
		if( vars.action == 0 and vars.time <= 0 )
		then
			unit:SendChatMessage( 12, 0, "Greetings, "..vars.visitor:GetPlayerClass().."! Welcome to the Cathedral of Light!" );
			unit:Emote( 3, 0 );
			vars.time = 6;
			vars.event = 1;
		
		elseif( vars.action == 1 and vars.time <= 0 )
		then
			unit:SetUInt64Value( 0x0006 + 0x000C, 0 );
			vars.time = 60;
			vars.event = 2;
			
		elseif( vars.event == 2 and vars.time <= 0 )
		then
			unit:RemoveAIUpdateEvent();
			vars.canWelcome = true;
			vars.time = nil;
			vars.visitor = nil;
			vars.event = nil;
		end
		
	-- on spawn
	else
	
	    BROTHER_SARNO[ sUnit ] = {

		canWelcome = true,
			
		};
		
    end
end

function BROTHER_SARNO.OnAreaTrigger( _, plr, areaTriggerId )

    if( areaTriggerId == 1125 )	
    then
        local unit = plr:GetCreatureNearestCoords( -8556.00, 835.86, 106.60, 7917 );
        if( unit ~= nil )	
        then
			local vars = BROTHER_SARNO[ tostring( unit ) ];
			if( unit:IsHostile( plr ) == false and vars.canWelcome == true )
			then
				vars.visitor = plr;	
				vars.canWelcome = false;
				vars.time = 3;
				vars.action = 0;
				unit:SetUInt64Value( 0x0006 + 0x000C, vars.visitor:GetGUID() );
				unit:RegisterAIUpdateEvent( 1000 );
			end
        end	
    end	
end

RegisterUnitEvent( 7917, 18, BROTHER_SARNO.OnSpawnOrAIUpdate );
RegisterUnitEvent( 7917, 21, BROTHER_SARNO.OnSpawnOrAIUpdate );
RegisterServerHook( 26, BROTHER_SARNO.OnAreaTrigger );