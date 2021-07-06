--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Azuremyst Isle: 
	Creature: Draenei Survivor

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

	enUS locale:

	"The last thing I remember is the ship falling and us getting into the pods.  I'll go see how I can help.  Thank you!",
	"Where am I?  Who are you?  Oh no!  What happened to the ship?",
	"$C, you saved me!  I owe you a debt that I can never repay.  I'll go see if I can help the others.",
	"Ugh... what is this place?  Is that all that's left of the ship over there?",
	"Oh, the pain...",
	"Everything hurts. Please, make it stop...",
	"Ughhh... I hurt.  Can you help me?",
	"I don't know if I can make it. Please help me..."

	esMX locale:

	"Lo último que recuerdo es la nave cayendo y nosotros entrando en cápsulas. Iré a ver cómo puedo ayudar. ¡Gracias!",
	"¿Dónde estoy? ¿Quién eres tú? ¡Oh no! ¿Qué pasó con la nave?",
	"$C, ¡me salvaste! Tengo una deuda que nunca podré saldar. Iré a ver si puedo ayudar a los demás.",
	"Ugh ... ¿Qué es este lugar? ¿Eso allí es todo lo que queda de la nave?",
	"Oh, el dolor...",
	"Todo duele. Por favor, haz que pare...",
	"Ughhh ... me duele. ¿Me puedes ayudar?",
	"No sé si podré hacerlo. Por favor, ayúdame...",

--]]

local TEXT = {
"The last thing I remember is the ship falling and us getting into the pods.  I'll go see how I can help.  Thank you!",
"Where am I?  Who are you?  Oh no!  What happened to the ship?",
"$C, you saved me!  I owe you a debt that I can never repay.  I'll go see if I can help the others.",
"Ugh... what is this place?  Is that all that's left of the ship over there?",
"Oh, the pain...",
"Everything hurts. Please, make it stop...",
"Ughhh... I hurt.  Can you help me?",
"I don't know if I can make it. Please help me..."
};

--local SPELL_IRRIDATION = 35046;
--local SPELL_STUNNED    = 28630;

--local UNIT_FIELD_FLAGS       		= 0x0006 + 0x0035;
--local UNIT_FLAG_PVP_ATTACKABLE	= 0x00000008
--local UNIT_FLAG_IN_COMBAT    		= 0x00080000;

DRAENEI_SURVIVOR = {};

function DRAENEI_SURVIVOR.OnSpawn( unit )

	local sUnit = tostring( unit );
	DRAENEI_SURVIVOR[ sUnit ] = {}
	local ref = DRAENEI_SURVIVOR[ sUnit ]

	ref.thanksTimer = 0;
	ref.runTimer = 0;
	ref.helpTimer = 10000;

	ref.canThanks = false;
	ref.canRun = false;
	ref.canAskHelp = true;

	--unit:CastSpell( 35046 );

	unit:SetFlag( 0x0006 + 0x0035, 0x00000008 + 0x00080000 ); -- pvp attackable + in combat
	unit:SetHealthPct( 10 ); -- need to disable regen here
	unit:RegisterAIUpdateEvent( 1000 );

end

function DRAENEI_SURVIVOR.OnAIUpdate( unit )

	local vars = DRAENEI_SURVIVOR[ tostring( unit ) ]

	vars.thanksTimer = vars.thanksTimer - 1;
	vars.runTimer = vars.runTimer - 1;
	vars.helpTimer = vars.helpTimer - 1;

	if( vars.canThanks == true and vars.thanksTimer <= 0 )
	then
		unit:SendChatMessage( 12, 35, TEXT[ math.random( 1, 4 ) ] );
		--unit:RemoveAura( 35046 ); maybe remove the stun here?
		unit:MoveTo( -4115.053711, -13754.831055, 73.508949 );

		vars.runTimer = 10000;
		vars.thanksTimer = 0;
		vars.canRun = true;
	end

	if( vars.canRun == true and vars.runTimer <= 0 )
	then
		unit:Despawn( 0, 300000 );
		vars.canRun = false;
	end

	if( vars.helpTimer <= 0 )
	then
		vars.canAskHelp = true;
		vars.helpTimer = 20000;
	end

	if( vars.canAskHelp == true )
	then
		local plr = unit:GetClosestPlayer();
		if( plr ~= nil )
		then
			if( unit:GetDistanceYards( plr ) <= 25 )
			then
				unit:SendChatMessage( 12, 35, TEXT[ math.random( 5, 8 ) ] );
				vars.helpTimer = 20000;
				vars.canAskHelp = false;
			end
		end
	end

	if( unit:HasAura( 35046 ) == false )
	then
		unit:RemoveFlag( 0x0006 + 0x0035, 0x00000008 ); -- pvp attackable
		unit:SetStandState( 0 ); -- stand up
		unit:CastSpell( 28630 ); -- stuned
		vars.thanksTimer = 5000;
	end
end

RegisterUnitEvent( 16483, 18, DRAENEI_SURVIVOR.OnSpawn );
RegisterUnitEvent( 16483, 21, DRAENEI_SURVIVOR.OnAIUpdate );
