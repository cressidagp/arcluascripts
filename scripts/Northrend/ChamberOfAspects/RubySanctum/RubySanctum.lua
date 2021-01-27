--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	The Ruby Sanctum

	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	yt
	
	ToDo:

	*) More clean up
	*) 75416: need spellscript?
	
	enUS locale:

	"Thank you! I could not have held out for much longer.... A terrible thing has happened here.";
	"We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault.";
	"The Black dragonkin materialized from thin air, and set upon us before we could react.";
	"We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.";
	"They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum.";
	"The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work.";
	"In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon.";
	"I know not the extent of their plans, heroes, but I know this:  They cannot be allowed to succeed!";
	"Help! I am trapped within this tree!  I require aid!";
	"Your power wanes, ancient one.... Soon you will join your friends.";

	esMX locale:

	"¡Gracias! No podía aguantar mucho más.... A ocurrido algo terrible en este lugar.";
	"Creíamos que el sagrario estaba bien fortificado, pero no estabamos preparados para este tipo de asalto.";
	"El dragonante Negro se apareció de la nada, y nos enbistió antes de que pudieramos reaccionar.";
	"Era nuestro fin. Con mis hermanos pereciendo a mi alrededor logre la retirada hasta aqui. Donde barrique la entrada";
	"Nos masacraron con una eficacia fria, pero pareciann mas interesado en los huevos guardados aquim en el Sagrario.";
	"El comandante de las fuerzas terrestres es un salvaje cruel llamado Zarithrian ground here is a cruel brute named Zarithrian, pero me temo que hay fuerzas superiores en el medio.";
	"En su asalto inicial, pude ver fugazmente a su verdadero lider, un temible dragon crepuscular.";
	"Desconozco sus verdaderos plates heroes, pero si s esto: no hay que permitirles que los lleven a coboI know not: No hay que permitirles que los lleven a cabo.";
	"¡Ayudenme! ¡Estoy atrapado dentro de este arbol!";
	"Tu poder mengua, anciano... Pronto te unirás a tus amigos.";

--]]

--print( "Lua memory before Ruby Sanctum: "..gcinfo().." KB." );

--[[ Constants:
local MAP_RUBY_SANCTUM	= 724;
local NPC_XERESTRASZA	= 40429;
local NPC_BALTHARUS		= 39751;
local FACTION_HOSTILE = 14;
local AT_BALTHARUS_PLATEAU = 5867;
]]

--[[ For 3.3.5a
local GAMEOBJECT_BYTES_1	= 0x0006 + 0x000B;
local GAMEOBJECT_DYNAMIC =  0x0006 + 0x0008;
local UNIT_FIELD_FLAGS_2		= 0x0006 + 0x0036;
local UNIT_FLAG2_ENABLE_POWER_REGEN	= 0x0000800;
]]

local sound = {
17491,	-- Xerex event 1
17492,	-- Xerex event 2
17493,	-- Xerex event 3
17494,	-- Xerex event 4
17495,	-- Xerex event 5
17496,	-- Xerex event 6
17497,	-- Xerex event 7
17498,	-- Xerex event 8
17490,	-- Xerex Intro
17525	-- Baltharus Intro
};

local chat = {
"Thank you! I could not have held out for much longer.... A terrible thing has happened here.",
"We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault.",
"The Black dragonkin materialized from thin air, and set upon us before we could react.",
"We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.",
"They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum.",
"The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work.",
"In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon.",
"I know not the extent of their plans, heroes, but I know this:  They cannot be allowed to succeed!",
"Help! I am trapped within this tree!  I require aid!",
"Your power wanes, ancient one.... Soon you will join your friends."
};

--[[ WorldStates:
local WORLDSTATE_CORPOREALITY_MATERIAL  = 5049;
local WORLDSTATE_CORPOREALITY_TWILIGHT  = 5050;
local WORLDSTATE_CORPOREALITY_TOGGLE    = 5051;
]]

--[[ Spells:
local SPELL_RALLY = 75416;
]]

RUBY_SANCTUM = {}

function RUBY_SANCTUM.OnPlayerEnter( _, plr )

    -- Developer notes: i discover argument iid isnt safe. If a player enter the function triggers and variables
    -- are created. But then if player from opposite faction enter variables wont be created with the same idd number.
    -- So will have no more choice than spend resources getting instance id again.

    local iid = plr:GetInstanceID();

	-- create protected variables
    if( RUBY_SANCTUM[ iid ] == nil )
    then
		RUBY_SANCTUM[ iid ] = {

		isIntro = true,
		isDone = false,
		baltharusIsDead = false,
		savianaIsDead = false,
		zarithrianIsDead = false,
		action = 0

		};
	end
end

function RUBY_SANCTUM.OnCreatureDeath( _, victim, killer )

	local iid = killer:GetInstanceID();

	local entry = victim:GetEntry();
	
	-- baltharus
	if( entry == 39751 )
	then
		RUBY_SANCTUM[ iid ].baltharusIsDead = true;

		local xerex = GetInstanceCreature( 724, iid, 134456 );
		if( xerex )
		then
			xerex:RegisterEvent( RUBY_SANCTUM.DoAction, 2000, 1 );
		end
		
		if( RUBY_SANCTUM[ iid ].savianaIsDead == true )
		then
			local flame = victim:GetGameObjectNearestCoords( 3050.36, 526.1, 88.41, 203006 );
			
			if( flame )
			then
				-- open door
				flame:SetByte( 0x0006 + 0x000B, 0, 0 );
			end
		end
		
	-- saviana
	elseif( entry == 39747 )
	then
        RUBY_SANCTUM[ iid ].savianaIsDead = true;

        if( RUBY_SANCTUM[ iid ].baltharusIsDead == true )
        then

            local flame = victim:GetGameObjectNearestCoords( 3050.36, 526.1, 88.41, 203006 );
			
			if( flame )
			then
				-- open door
				flame:SetByte( 0x0006 + 0x000B, 0, 0 );
			end
        end

	-- zarithrian
    elseif( entry == 39746 )
    then
        RUBY_SANCTUM[ iid ].zarithrianIsDead = true;
		
        local controller = victim:GetCreatureNearestCoords( 3156.04, 533.266, 72.9721, 40146 );
		
		if( controller )
		then
			--[[
			controller:CastSpell( 76006 );
			controller:SpawnCreature( 39863, 3156.67, 533.8108, 72.98822, 3.159046, 14, 0, 1, 1, 1, 1, 0 );]]
		end
    end
end

function RUBY_SANCTUM.DoAction( unit )

	local iid = unit:GetInstanceID();
	
	RUBY_SANCTUM[ iid ].action = RUBY_SANCTUM[ iid ].action + 1;
	
	-- intro xerex
	if( RUBY_SANCTUM[ iid ].action == 1 )
	then
		RUBY_SANCTUM[ iid ].introDone = true;
		unit:PlaySoundToSet( sound[ 9 ] );
		unit:SendChatMessage( 14, 0, chat[ 9 ] );
		unit:Emote( 5, 0 );
	
	-- intro baltharus
	elseif( RUBY_SANCTUM[ iid ].action == 2 )
	then
		unit:PlaySoundToSet( sound[ 10 ] );
		unit:SendChatMessage( 14, 0, chat[ 10 ] );
		
	-- baltharus death
	elseif( RUBY_SANCTUM[ iid ].action == 3 )
	then
		unit:PlaySoundToSet( sound[ 1 ] );
		unit:SendChatMessage( 14, 0, chat[ 1 ] );
		unit:Emote( 5, 0 );
		
		unit:RegisterAIUpdateEvent( 1000 );
		
		RUBY_SANCTUM[ iid ].isIntro = false;
		
		-- add protected variables
		RUBY_SANCTUM[ iid ].event1 = 16;
		RUBY_SANCTUM[ iid ].event2 = 25;
		RUBY_SANCTUM[ iid ].event3 = 32;
		RUBY_SANCTUM[ iid ].event4 = 42;
		RUBY_SANCTUM[ iid ].event5 = 51;
		RUBY_SANCTUM[ iid ].event6 = 61;
		RUBY_SANCTUM[ iid ].event7 = 69;
		RUBY_SANCTUM[ iid ].vars = 0;
	end
end

function RUBY_SANCTUM.XerexOnAIUpdate( unit )
	
	local iid = unit:GetInstanceID();
	
	if( RUBY_SANCTUM[ iid ].isIntro == true )
	then return; end
	
	RUBY_SANCTUM[ iid ].event1 = RUBY_SANCTUM[ iid ].event1 - 1;
	RUBY_SANCTUM[ iid ].event2 = RUBY_SANCTUM[ iid ].event2 - 1;
	RUBY_SANCTUM[ iid ].event3 = RUBY_SANCTUM[ iid ].event3 - 1;
	RUBY_SANCTUM[ iid ].event4 = RUBY_SANCTUM[ iid ].event4 - 1;
	RUBY_SANCTUM[ iid ].event5 = RUBY_SANCTUM[ iid ].event5 - 1;
	RUBY_SANCTUM[ iid ].event6 = RUBY_SANCTUM[ iid ].event6 - 1;
	RUBY_SANCTUM[ iid ].event7 = RUBY_SANCTUM[ iid ].event7 - 1;
	
	if( RUBY_SANCTUM[ iid ].event1 <= 0 and RUBY_SANCTUM[ iid ].vars == 0 )
	then
		unit:PlaySoundToSet( sound[ 2 ] );
		unit:SendChatMessage( 12, 0, chat[ 2 ] );
		RUBY_SANCTUM[ iid ].vars = 1;
	
	elseif( RUBY_SANCTUM[ iid ].event2 <= 0 and RUBY_SANCTUM[ iid ].vars == 1 )
	then
		unit:PlaySoundToSet( sound[ 3 ] );
		unit:SendChatMessage( 12, 0, chat[ 3 ] );
		RUBY_SANCTUM[ iid ].vars = 2;
	
	elseif( RUBY_SANCTUM[ iid ].event3 <= 0 and RUBY_SANCTUM[ iid ].vars == 2 )
	then
		unit:PlaySoundToSet( sound[ 4 ] );
		unit:SendChatMessage( 12, 0, chat[ 4 ] );
		RUBY_SANCTUM[ iid ].vars = 3;

	elseif( RUBY_SANCTUM[ iid ].event4 <= 0 and RUBY_SANCTUM[ iid ].vars == 3 )
	then
		unit:PlaySoundToSet( sound[ 5 ] );
		unit:SendChatMessage( 12, 0, chat[ 5 ] );
		RUBY_SANCTUM[ iid ].vars = 4;

	elseif( RUBY_SANCTUM[ iid ].event5 <= 0 and RUBY_SANCTUM[ iid ].vars == 4 )
	then
		unit:PlaySoundToSet( sound[ 6 ] );
		unit:SendChatMessage( 12, 0, chat[ 6 ] );
		RUBY_SANCTUM[ iid ].vars = 5;
		
	elseif( RUBY_SANCTUM[ iid ].event6 <= 0 and RUBY_SANCTUM[ iid ].vars == 5 )
	then
		unit:PlaySoundToSet( sound[ 7 ] );
		unit:SendChatMessage( 12, 0, chat[ 7 ] );
		RUBY_SANCTUM[ iid ].vars = 6;
		
	elseif( RUBY_SANCTUM[ iid ].event7 <= 0 and RUBY_SANCTUM[ iid ].vars == 6 )
	then
		unit:PlaySoundToSet( sound[ 8 ] );
		unit:SendChatMessage( 12, 0, chat[ 8 ] );
		unit:Emote( 5, 0 );
		unit:RemoveAIUpdateEvent();
		unit:SetNPCFlags( 3 );
		RUBY_SANCTUM[ iid ].vars = nil;
	end
end

function RUBY_SANCTUM.OnAreaTrigger( _, plr, areaTriggerID )

	local iid = plr:GetInstanceID();
	
	-- on baltharus plateau
	if( areaTriggerID == 5867 )
	then
		-- get xerex using spawnid
		local xerex = GetInstanceCreature( 724, iid, 134456 );
		if( xerex )
		then
			xerex:RegisterEvent( RUBY_SANCTUM.DoAction, 1000, 1 );
		end
		
		-- get baltharus using spawnid
		local baltharus = GetInstanceCreature( 724, iid, 134428 );
		if( baltharus )
		then
			baltharus:RegisterEvent( RUBY_SANCTUM.DoAction, 7000, 1 );
		end
	end
end

RegisterUnitEvent( 40429, 21, RUBY_SANCTUM.XerexOnAIUpdate );
RegisterInstanceEvent( 724, 2, RUBY_SANCTUM.OnPlayerEnter );
RegisterInstanceEvent( 724, 5, RUBY_SANCTUM.OnCreatureDeath );
RegisterInstanceEvent( 724, 3, RUBY_SANCTUM.OnAreaTrigger );

--print( "Lua memory after Ruby Sanctum: "..gcinfo().." KB." );

--[[
function RUBY_SANCTUM.GoOnSpawn( go )
	
	state 0: from green to black (close)
	state 1: from black to green (open)
	state 2: 
	state 3: green (set to this at database )
	go:SetByte( 0x0006 + 0x000B, 0, 3 );
	go:SetUInt32Value( 0x0006 + 0x0008, 1 );
end

RegisterGameObjectEvent( 203034, 2, RUBY_SANCTUM.GoOnSpawn );
RegisterGameObjectEvent( 203035, 2, RUBY_SANCTUM.GoOnSpawn );
RegisterGameObjectEvent( 203036, 2, RUBY_SANCTUM.GoOnSpawn );
RegisterGameObjectEvent( 203037, 2, RUBY_SANCTUM.GoOnSpawn );

-- fire ring 203007
 0: spawn fire on, then fire off
 1: spawn fire on
 2: spawn fire on, then fire off
 3: 
 
-- deactivate gameobject
function RUBY_SANCTUM.GoOnSpawn( go )
	go:SetUInt32Value( 0x0006 + 0x0008, 0 );
end

RegisterGameObjectEvent( 203007, 2, RUBY_SANCTUM.GoOnSpawn );
--]]

--[[ 
		DEBUG COMMANDS DISABLED BY DEFAULT


local COMMANDS = { "ruby", "port", "exit", "xerex", "open", "close", "phase1", "phase32" };

function RubyCommands( _, plr, message )

	if( plr:IsGm() == true )
	then
		if( message == "#ruby" )
		then
			for i = 1, #COMMANDS
			do
				plr:SendBroadcastMessage( ""..COMMANDS[ i ].."" );
			end

		elseif( message == "#port" )
		then
			plr:Teleport( 724, 3190.85, 637.78, 78.93, 3.11 );
			
		elseif( message == "#exit" )
		then
			plr:Teleport( 571, 3597.61, 200.96, -113.74, 5.30 );
		
		elseif( message == "#xerex" )
		then
			local iid = plr:GetInstanceID();
			local xerex = GetInstanceCreature( 724, iid, 134456 );
			xerex:SendChatMessage( 12, 0, chat[ 6 ] );
			
		elseif( message == "#open" )
		then
			local firefield = plr:GetGameObjectNearestCoords( 3153.27, 380.47, 86.36, 203005 );
			firefield:SetByte( 0x0006 + 0x000B, 0, 0 );
		
		elseif( message == "#close" )
		then
			local firefield = plr:GetGameObjectNearestCoords( 3153.27, 380.47, 86.36, 203005 );
			firefield:SetByte( 0x0006 + 0x000B, 0, 1 );
		
		elseif( message == "#phase1" )
		then
			plr:PhaseSet( 1 );
		
		elseif( message == "#phase32" )
		then
			plr:PhaseSet( 32 );
		
		end
    end
end

RegisterServerHook( 16, RubyCommands );
--]]
