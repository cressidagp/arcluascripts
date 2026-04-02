--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Netherstorm: Netherstorm Agent (Area 52)
	Engine: A.L.E

  Credits:

  *) Trinity for texts and timers.
  *) Hypersniper for his lua guides and some job in the lua engine.
  *) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
  *) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

  enUS:

  "Good thing that we're surrounded by neighbors with excess machine parts.";
  "Maybe I should gather up some other agents and head out there after this shift?";
  "Hmm, arcane annihilators are pretty tough.  I wonder if Papa Wheeler knows what he's asking for?";
  "Last time someone went out to try to collect the bounty on Netherock, all we got back was a compressed layer of foolhardy adventurer!";
  "Netherock?!  That thing'll squish you flat with one step of its massive foot!  No thanks!";

  esMX:

  "Menos mal que estamos rodeados de vecinos con exceso de piezas de máquina.";
  "¿Quizás debería reunir a otros agentes y salir después de este turno?";
  "Hmm, los aniquiladores arcanos son bastante duros. Me pregunto si Papa Wheeler sabe lo que pide.";
  "La última vez que alguien salió para intentar cobrar la recompensa por Netherock, ¡todo lo que obtuvimos fue una capa comprimida de aventurero temerario!";
  "¡¿Netherock ?! ¡Esa cosa te aplastará con un paso de su enorme pie! ¡No, gracias!";

--]]

local TEXT = {
"Good thing that we're surrounded by neighbors with excess machine parts.";
"Maybe I should gather up some other agents and head out there after this shift?";
"Hmm, arcane annihilators are pretty tough.  I wonder if Papa Wheeler knows what he's asking for?";
"Last time someone went out to try to collect the bounty on Netherock, all we got back was a compressed layer of foolhardy adventurer!";
"Netherock?!  That thing'll squish you flat with one step of its massive foot!  No thanks!";
};

NETHERSTORM_AGENT = {};

function NETHERSTORM_AGENT.Chat( unit )
  if( unit:IsInCombat() == false )
  then
    local chance = math.random( 1, 5 );
    if( chance == 1 )
    then
      local i = math.random( 1, 5 )
      unit:SendChatMessage( 12, 0, TEXT[ i ] );
      unit:Emote( 1, 0 );
      unit:RemoveEvents();
      unit:RegisterEvent( NETHERSTORM_AGENT.Chat, math.random( 200000, 230000 ), 0 );
    end
  end
end

function NETHERSTORM_AGENT.OnSpawn( unit )
  unit:RegisterEvent( NETHERSTORM_AGENT.Chat, 60000, 0 );
end

RegisterUnitEvent( 19541, 18, NETHERSTORM_AGENT.OnSpawn );