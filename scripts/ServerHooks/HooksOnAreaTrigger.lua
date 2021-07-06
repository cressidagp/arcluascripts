--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Hooks AreaTrigger

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.
	
	enUs locale: "Welcome to the Lion's Pride In.  Make yourself at home!"
	enUS locale: "Greetings, "..plr:GetPlayerClass().."! Welcome to the Cathedral of Light!"
	
	esMX locale: "¡Bienvenido a la Posada Orgullo del León.  Siéntete como en casa!"
	esMX locale: "¡Saludos, "..plr:GetPlayerClass().."! ¡Bienvenido a la Catedral de la Luz!"
	
--]]

--local NPC_INKEEPER_FARLEY = 295;
--local NPC_BROTHER_SARNO = 7917;
--local EMOTE_ONESHOT_WAVE = 3;
--local UNIT_FIELD_TARGET = 0x0006 + 0x000C;

HOOKS_AT = {};

function HOOKS_AT.OnAreaTrigger( _, plr, areaTriggerId )
	
	--
	-- Lion's Pride Inn
	--
	
	if( areaTriggerId == 562 )
	then
		local farley = plr:GetCreatureNearestCoords( -9462.66, 16.19, 57.04, 295 );
		if( farley ~= nil )
		then
			if( farley:IsHostile( plr ) == false )
			then
				farley:SetUInt64Value( 0x0006 + 0x000C, plr:GetGUID() );
				farley:EventChat( 12, 0, "Welcome to the Lion's Pride In.  Make yourself at home!", 2000 );
				farley:RegisterEvent( HOOKS_AT.Wave, 2000, 1 );
				farley:RegisterEvent( HOOKS_AT.ClearTarget, 9000, 1 );
			end
		end
	
	--
	-- Cathedral of Light
	--
	
	elseif( areaTriggerId == 1125 )
	then
		local brother = plr:GetCreatureNearestCoords( -8556.00, 835.86, 106.60, 7917 );
		if( brother ~= nil )
		then
			if( brother:IsHostile( plr ) == false )
			then
				brother:SetUInt64Value( 0x0006 + 0x000C, plr:GetGUID() );
				brother:EventChat( 12, 0, "¡Saludos, "..plr:GetPlayerClass().."! ¡Bienvenido a la Catedral de la Luz!", 2000 );
				brother:RegisterEvent( HOOKS_AT.Wave, 2000, 1 );
				brother:RegisterEvent( HOOKS_AT.ClearTarget, 9000, 1 );
			end
        end
    end
end

-- keep it at botton or it will not work
function HOOKS_AT.Wave( unit )

	unit:Emote( 3, 0 );
	
end

-- keep it at botton or it will not work
function HOOKS_AT.ClearTarget( unit )

	unit:SetUInt64Value( 0x0006 + 0x000C, 0 );
	
end

RegisterServerHook( 26, HOOKS_AT.OnAreaTrigger );