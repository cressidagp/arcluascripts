--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Hellfire Peninsula
	Creature: Marshall Isildor

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	"What could be taking so long?",
	"How long can it take to pick a handful of weeds?",
	"At this rate I could have gathered them myself!",
	"If you want something done right, do it yourself!",
	
	esMX locale:

--]]

--local NPC_MARSHAL_ISILDOR = 19308;

local chat = {
"This war - and don't mistake this for anything but a war - is not going to win itself. If we do not fight, scratch, claw, and kick for every speck of land on this shattered world, all will be lost.",
"How many more soldiers need to die before we start paying attention out there?",
"Do you think that demons will play fair? These beasts are more savage than orcs and more cunning than the undead. Do not attempt to engage Legion by normal standards of war.",
"I regret to inform you all that we sent home another ten soldiers today - in body bags.",
};

MARSHAL_ISILDOR = {};

function MARSHAL_ISILDOR.OoCRandomChat( unit )

	if( unit:IsInCombat() == false )
	then
		local rand = math.random( 1, 4 );
		if( rand <= 1 and rand <= 3 )
		then
			unit:SendChatMessage( 12, 7, chat[ rand ] );
			unit:Emote( 5, 0 );
		else
			unit:SendChatMessage( 12, 7, chat[ rand ] );
			unit:Emote( 1, 0 );
		end
	end
end

function MARSHAL_ISILDOR.OnSpawn( unit )

	unit:RegisterEvent( MARSHAL_ISILDOR.OoCRandomChat, 60000, 1 );
	unit:RegisterEvent( MARSHAL_ISILDOR.OoCRandomChat, math.random( 120000, 180000 ), 0 );
end

RegisterUnitEvent( 19308, 18, MARSHAL_ISILDOR.OnSpawn );
