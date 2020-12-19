--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Azuremyst Isle: Draenei Mourner
	Engine: A.L.E

	Credits:

	*) Trinity for texts, timers and emotes.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

  enUS:

  { 1, 12, 0, "<Sobbing> I hate graveyards.  So many dead.  And my sweet Luhanaa....", 1 },
  { 2, 12, 7, "It should have been me!", 6 },
  { 3, 12, 7, "Be at peace, my sweet, sweet, Luhanaa.", 6 },
  { 4, 12, 7, "I'll never forget you, my love.", 1 },
  { 5, 12, 7, "If I ever find the ones responsible for the crash...!", 1 },
  { 6, 12, 7, "We should never have come along.", 1 },
  { 7, 12, 7, "Why, Luhanaa?  Why?!", 6 },
  { 8, 12, 7, "I miss you so much!", 1 },
  { 9, 12, 7, "You'll always be here, with me.", 1 },
  { 10, 16, 0, "%s weeps softly.", 18 },
  { 11, 16, 0, "%s bows his head and sighs, clearly exhausted.", 2 },
  { 12, 16, 0, "%s breaks down into huge, wracking sobs.", 18 },
  { 13, 16, 0, "%s stares in silence at the grave marker before him.", 0 }

  esMX:

  { 1, 12, 0, "<Sobbing> I hate graveyards.  So many dead.  And my sweet Luhanaa....", 1 },
  { 2, 12, 7, "It should have been me!", 6 },
  { 3, 12, 7, "Be at peace, my sweet, sweet, Luhanaa.", 6 },
  { 4, 12, 7, "I'll never forget you, my love.", 1 },
  { 5, 12, 7, "If I ever find the ones responsible for the crash...!", 1 },
  { 6, 12, 7, "We should never have come along.", 1 },
  { 7, 12, 7, "Why, Luhanaa?  Why?!", 6 },
  { 8, 12, 7, "I miss you so much!", 1 },
  { 9, 12, 7, "You'll always be here, with me.", 1 },
  { 10, 16, 0, "%s weeps softly.", 18 },
  { 11, 16, 0, "%s bows his head and sighs, clearly exhausted.", 2 },
  { 12, 16, 0, "%s breaks down into huge, wracking sobs.", 18 },
  { 13, 16, 0, "%s stares in silence at the grave marker before him.", 0 }

--]]

local TEXT_MOURNER = {
{ 1, 12, 0, "<Sobbing> I hate graveyards.  So many dead.  And my sweet Luhanaa....", 1 },
{ 2, 12, 7, "It should have been me!", 6 },
{ 3, 12, 7, "Be at peace, my sweet, sweet, Luhanaa.", 6 },
{ 4, 12, 7, "I'll never forget you, my love.", 1 },
{ 5, 12, 7, "If I ever find the ones responsible for the crash...!", 1 },
{ 6, 12, 7, "We should never have come along.", 1 },
{ 7, 12, 7, "Why, Luhanaa?  Why?!", 6 },
{ 8, 12, 7, "I miss you so much!", 1 },
{ 9, 12, 7, "You'll always be here, with me.", 1 },
{ 10, 16, 0, "%s weeps softly.", 18 },
{ 11, 16, 0, "%s bows his head and sighs, clearly exhausted.", 2 },
{ 12, 16, 0, "%s breaks down into huge, wracking sobs.", 18 },
{ 13, 16, 0, "%s stares in silence at the grave marker before him.", 0 }
};

DRAENEI_MOURNER = {}

function DRAENEI_MOURNER.RandomChat( unit )
  if( unit:IsInCombat() == false )
  then
    local i = math.random( 1, 13 );
    unit:SendChatMessage( TEXT_MOURNER[ i ][ 2 ], TEXT_MOURNER[ i ][ 3 ], TEXT_MOURNER[ i ][ 4 ] );
    unit:Emote( TEXT_MOURNER[ i ][ 5 ], 0 );
    unit:RemoveEvents();
    unit:RegisterEvent( DRAENEI_MOURNER.RandomChat, math.random( 45000, 60000 ), 0 );
  end
end

function DRAENEI_MOURNER.OnSpawn( unit )
  unit:RegisterEvent( DRAENEI_MOURNER.RandomChat, math.random( 25000, 35000 ), 0 );
end

RegisterUnitEvent( 17073, 18, DRAENEI_MOURNER.OnSpawn );
