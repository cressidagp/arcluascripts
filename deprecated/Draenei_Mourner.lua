--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Azuremyst Isle
	Creature: Draenei Mourner

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:

	{ 12, 0, "<Sobbing> I hate graveyards.  So many dead.  And my sweet Luhanaa....", 1 },
	{ 12, 7, "It should have been me!", 6 },
	{ 12, 7, "Be at peace, my sweet, sweet, Luhanaa.", 6 },
	{ 12, 7, "I'll never forget you, my love.", 1 },
	{ 12, 7, "If I ever find the ones responsible for the crash...!", 1 },
	{ 12, 7, "We should never have come along.", 1 },
	{ 12, 7, "Why, Luhanaa?  Why?!", 6 },
	{ 12, 7, "I miss you so much!", 1 },
	{ 12, 7, "You'll always be here, with me.", 1 },
	{ 16, 0, "%s weeps softly.", 18 },
	{ 16, 0, "%s bows his head and sighs, clearly exhausted.", 2 },
	{ 16, 0, "%s breaks down into huge, wracking sobs.", 18 },
	{ 16, 0, "%s stares in silence at the grave marker before him.", 0 }

	esMX locale:

	{ 12, 0, "<Sollozando> Odio los cementerios.  Tantos muertos.  Y mi dulce Luhanaa....", 1 },
	{ 12, 7, "¡Debería haber sido yo!", 6 },
	{ 12, 7, "Descansa en paz, mi dulce, dulce, Luhanaa.", 6 },
	{ 12, 7, "Nunca te olvidaré, mi amor.", 1 },
	{ 12, 7, "¡Si alguna vez encuentro a los responsables del accidente...!", 1 },
	{ 12, 7, "Nunca deberíamos haber venido.", 1 },
	{ 12, 7, "¿Por qué, Luhanaa? ¡¿Por qué?!", 6 },
	{ 12, 7, "¡Te extraño tanto!", 1 },
	{ 12, 7, "Siempre estarás aquí conmigo.", 1 },
	{ 16, 0, "%s llora suavemente.", 18 },
	{ 16, 0, "%s inclina la cabeza y suspira, claramente exhausto.", 2 },
	{ 16, 0, "%s se rompe en sollozos enormes y devastadores.", 18 },
	{ 16, 0, "%s mira en silencio la lápida que tiene ante él.", 0 }

--]]

--NPC_DRAENEI_MOURNER = 17073;

local data = {
{ 12, 0, "<Sobbing> I hate graveyards.  So many dead.  And my sweet Luhanaa....", 1 },
{ 12, 7, "It should have been me!", 6 },
{ 12, 7, "Be at peace, my sweet, sweet, Luhanaa.", 6 },
{ 12, 7, "I'll never forget you, my love.", 1 },
{ 12, 7, "If I ever find the ones responsible for the crash...!", 1 },
{ 12, 7, "We should never have come along.", 1 },
{ 12, 7, "Why, Luhanaa?  Why?!", 6 },
{ 12, 7, "I miss you so much!", 1 },
{ 12, 7, "You'll always be here, with me.", 1 },
{ 16, 0, "%s weeps softly.", 18 },
{ 16, 0, "%s bows his head and sighs, clearly exhausted.", 2 },
{ 16, 0, "%s breaks down into huge, wracking sobs.", 18 },
{ 16, 0, "%s stares in silence at the grave marker before him.", 0 }
};

DRAENEI_MOURNER = {};

function DRAENEI_MOURNER.RandomChat( unit )

	if( unit:IsInCombat() == false )
	then
		local i = math.random( 1, 13 );
		unit:SendChatMessage( data[ i ][ 1 ], data[ i ][ 2 ], data[ i ][ 3 ] );
		unit:Emote( data[ i ][ 4 ], 0 );
		unit:RemoveEvents();
		unit:RegisterEvent( DRAENEI_MOURNER.RandomChat, math.random( 45000, 60000 ), 0 );
	end
end

function DRAENEI_MOURNER.OnSpawn( unit )

  unit:RegisterEvent( DRAENEI_MOURNER.RandomChat, math.random( 25000, 35000 ), 0 );
  
end

RegisterUnitEvent( 17073, 18, DRAENEI_MOURNER.OnSpawn );