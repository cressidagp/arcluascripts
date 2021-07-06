--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Eversong Woods: Sunstrider Guardian
	Engine: A.L.E

	Credits:

	*) Trinity for text and emotes.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

	enUS:

  [ 1 ] = "Move along, "..plr:GetPlayerClass().."!";
  [ 2 ] = "Off with you, "..plr:GetName().."!";
  [ 3 ] = "Do not push it citizen!";

	esMX:

  [ 1 ] = "¡Muévete, "..plr:GetPlayerClass().."!";
  [ 2 ] = "¡Fuera contigo, "..plr:GetName().."!";
  [ 3 ] = "¡No me presione ciudadano!";

--]]

SUNSTRIDER_GUARDIAN = {};

function SUNSTRIDER_GUARDIAN.OnEmote( unit, _, plr, emoteId )
	if( emoteId == 14 ) -- rude
	then
		unit:EventChat( 12, 0, "Do not push it citizen!", 1000 );
		unit:Emote( 1, 0 );

	elseif( emoteId == 66 ) -- salute
	then
		local chance = math.random( 1, 3 );
		if( chance == 1 )
		then
			local i = math.random( 1, 2 );
			if( i == 1 )
			then
				unit:EventChat( 12, 0, "Move along, "..plr:GetPlayerClass().."!", 1000 );
			else
				unit:EventChat( 12, 0, "Off with you, "..plr:GetName().."!", 1000 );
			end
			unit:Emote( 66, 0 );
		end
	end
end

RegisterUnitEvent( 15371, 22, SUNSTRIDER_GUARDIAN.OnEmote );