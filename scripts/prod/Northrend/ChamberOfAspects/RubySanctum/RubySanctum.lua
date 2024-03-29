--[[

	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Instance: The Ruby Sanctum

	Credits:

	*) TrinityCore for texts, sounds, timers, spells and some Inspiration.
	*) DarkAngel39 for his instance progression system.
	*) Marforius for ArcAddons who make my life much easier.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	yt
	
	ToDo:

	*) clear up variables if all players leave instance... need a new instance hook.
	*) 75416: need spellscript?.
	*) xerex should teleport to pos2 if instance previously started when spawn? research.
	*) burning trees (go): unable to make them spawn burned (so far they can spawn green and go burn, burn and go green, or green).
	*) fire circle (go): unable to make it spawn off (so far, they can spawn on and go off, off and go on, or on).
	
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

--
--
--[[ DEFINES:
--
--

local MAP_RUBY_SANCTUM	= 724;
local NPC_XERESTRASZA	= 40429;
local NPC_BALTHARUS		= 39751;
local FACTION_HOSTILE = 14;
local AT_BALTHARUS_PLATEAU = 5867;

local GAMEOBJECT_BYTES_1	= 0x0006 + 0x000B;
local GAMEOBJECT_DYNAMIC	= 0x0006 + 0x0008;
local UNIT_FIELD_FLAGS	= 0x0006 + 0x0035;
local UNIT_FLAG_NOT_ATTACKABLE_9	= 0x00000100;
local UNIT_FLAG_NOT_SELECTABLE	= 0x02000000;

local WORLDSTATE_CORPOREALITY_MATERIAL  = 5049;
local WORLDSTATE_CORPOREALITY_TWILIGHT  = 5050;
local WORLDSTATE_CORPOREALITY_TOGGLE    = 5051;

local SPELL_RALLY = 75416;

]]

--[[
local talk = {
{ 17491, "Thank you! I could not have held out for much longer.... A terrible thing has happened here." }, -- Xerex event 1
{ 17492, "We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault." },
{ 17493, "The Black dragonkin materialized from thin air, and set upon us before we could react." },
{ 17494, "We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance." },
{ 17495, "They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum." },
{ 17496, "The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work." },
{ 17497, "In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon." },
{ 17498, "I know not the extent of their plans, heroes, but I know this:  They cannot be allowed to succeed!" },
{ 17490, "Help! I am trapped within this tree!  I require aid!" }, -- Xerex Intro
{ 17525, "Your power wanes, ancient one.... Soon you will join your friends." }	-- Baltharus Intro
};
--]]

local RUBY_SANCTUM = {};

function RUBY_SANCTUM.OnPlayerEnter( _, plr )

	-- Developer notes: i discover argument iid isnt safe. If a player enter the function triggers and variables
	-- are created. But then if player from opposite faction enter variables will be created with the same idd number.
	-- So will have no more choice than spend resources getting instance id again.

	local iid = plr:GetInstanceID();

	-- create protected variables
	if( RUBY_SANCTUM[ iid ] == nil )
	then
		RUBY_SANCTUM[ iid ] = {
		
		hasTriggered = false,
		isIntro = true,
		introDone = false,
		baltharusIsDead = false,
		savianaIsDead = false,
		zarithrianIsDead = false,
		halionIsDone = false
		};
		
		--
		-- DarkAngel39 instance progression system
		--
		
		local string_data = {};
		local result = CharDBQuery( "SELECT killed_npc_guids FROM instances WHERE id = "..iid.."; " );
		if( result ~= nil )
		then
			local colcount = result:GetColumnCount();
			
			repeat
			
				for col = 0, colcount - 1, 1 do
				
					string_data[ col ] = result:GetColumn( col ):GetString();
					
					local b1 = string.find( string_data[ col ], "39751" ); -- Baltharus
					local b2 = string.find( string_data[ col ], "39747" ); -- Saviana
					local b3 = string.find( string_data[ col ], "39746" ); -- Zarithrian
					local b4 = string.find( string_data[ col ], "39746" ); -- Halion
					
					if( b1 ~= nil ) 
					then 
						RUBY_SANCTUM[ iid ].hasTriggered = true;
						RUBY_SANCTUM[ iid ].baltharusIsDead = true; 
					end
					
					if( b2 ~= nil ) then RUBY_SANCTUM[ iid ].savianaIsDead = true; end
					if( b3 ~= nil ) then RUBY_SANCTUM[ iid ].zarithrianIsDead = true; end
					if( b4 ~= nil ) then RUBY_SANCTUM[ iid ].halionIsDone = true; end
				end
		
			until result:NextRow() ~= true;
		end	
	end
end

function RUBY_SANCTUM.OnCreatureDeath( _, victim, killer )

	local entry = victim:GetEntry();
	
	local iid = killer:GetInstanceID();
	
	-- victinm is baltharus
	if( entry == 39751 )
	then
		RUBY_SANCTUM[ iid ].baltharusIsDead = true;

		-- get xerex using spawnid
		local xerex = GetInstanceCreature( 724, iid, 134456 );
		if( xerex )
		then
			xerex:RegisterLuaEvent( RUBY_SANCTUM.DoAction, 2000, 1, 3 );
		end

		-- victim seems to work fine here, but maybe i should find a way to register this without a unit
		victim:RegisterLuaEvent( RUBY_SANCTUM.DoAction, 1000, 1, 4 );
	
		
	-- victim is saviana
	elseif( entry == 39747 )
	then
		RUBY_SANCTUM[ iid ].savianaIsDead = true;

		-- victim seems to work fine here, but maybe i should find a way to register this without a unit
		victim:RegisterLuaEvent( RUBY_SANCTUM.DoAction, 1000, 1, 4 );


	-- victim is zarithrian
	elseif( entry == 39746 )
	then
		RUBY_SANCTUM[ iid ].zarithrianIsDead = true;
		
		-- get controller using coords
		local controller = victim:GetCreatureNearestCoords( 3156.04, 533.266, 72.9721, 40146 );
		if( controller )
		then
			controller:RegisterAIUpdateEvent( 1000 );
		end
	end
end

function RUBY_SANCTUM.DoAction( unit, action )

	local iid = unit:GetInstanceID();
	
	-- intro xerex
	if( action == 1 )
	then
		unit:PlaySoundToSet( 17490 );
		unit:SendChatMessage( 14, 0, "Help! I am trapped within this tree!  I require aid!" );
		unit:Emote( 5, 0 );
	
	-- intro baltharus
	elseif( action == 2 )
	then
		RUBY_SANCTUM[ iid ].introDone = true;
		unit:PlaySoundToSet( 17525 );
		unit:SendChatMessage( 14, 0, "Your power wanes, ancient one.... Soon you will join your friends." );
		
	-- baltharus death
	elseif( action == 3 )
	then
		unit:RegisterAIUpdateEvent( 1000 );
		
		RUBY_SANCTUM[ iid ].isIntro = false;
		
		-- add protected variables
		RUBY_SANCTUM[ iid ].timer = 14;
		RUBY_SANCTUM[ iid ].vars = 0;
	
	-- check general
	elseif( action == 4 )
	then
		if( RUBY_SANCTUM[ iid ].baltharusIsDead == true and RUBY_SANCTUM[ iid ].savianaIsDead == true )
		then
			-- get flame walls using coords
			local flame = victim:GetGameObjectNearestCoords( 3050.36, 526.1, 88.41, 203006 );
			if( flame )
			then
				-- disable flame walls
				flame:SetByte( 0x0006 + 0x000B, 0, 0 );
			end	
	
			-- get zarithrian using spawnid
			local zarithrian = GetInstanceCreature( 724, iid, 134456 );
			if( zarithrian )
			then
				-- remove unit field flag not selectable so players can try to kill him
				zarithrian:RemoveFlag( 0x0006 + 0x0035, 0x00000100 + 0x02000000 );
			end
		end
	end
end

function RUBY_SANCTUM.XerexOnAIUpdate( unit )
	
	local iid = unit:GetInstanceID();
	
	if( RUBY_SANCTUM[ iid ].isIntro == true )
	then return; end
	
	RUBY_SANCTUM[ iid ].timer = RUBY_SANCTUM[ iid ].timer - 1;
	
	if( RUBY_SANCTUM[ iid ].timer <= 0 and RUBY_SANCTUM[ iid ].vars == 0 )
	then
		unit:PlaySoundToSet( 17491 );
		unit:SendChatMessage( 14, 0, "Thank you! I could not have held out for much longer.... A terrible thing has happened here." );
		unit:Emote( 5, 0 );
		RUBY_SANCTUM[ iid ].vars = 1;
		RUBY_SANCTUM[ iid ].timer = 16;
	
	elseif( RUBY_SANCTUM[ iid ].timer <= 0 and RUBY_SANCTUM[ iid ].vars == 1 )
	then
		unit:PlaySoundToSet( 17492 );
		unit:SendChatMessage( 12, 0, "We believed the Sanctum was well-fortified, but we were not prepared for the nature of this assault." );
		RUBY_SANCTUM[ iid ].vars = 2;
		RUBY_SANCTUM[ iid ].timer = 9;
	
	elseif( RUBY_SANCTUM[ iid ].timer <= 0 and RUBY_SANCTUM[ iid ].vars == 2 )
	then
		unit:PlaySoundToSet( 17493 );
		unit:SendChatMessage( 12, 0, "The Black dragonkin materialized from thin air, and set upon us before we could react." );
		RUBY_SANCTUM[ iid ].vars = 3;
		RUBY_SANCTUM[ iid ].timer = 7;
	
	elseif( RUBY_SANCTUM[ iid ].timer <= 0 and RUBY_SANCTUM[ iid ].vars == 3 )
	then
		unit:PlaySoundToSet( 17494 );
		unit:SendChatMessage( 12, 0, "We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance." );
		RUBY_SANCTUM[ iid ].vars = 4;
		RUBY_SANCTUM[ iid ].timer = 10;

	elseif( RUBY_SANCTUM[ iid ].timer <= 0 and RUBY_SANCTUM[ iid ].vars == 4 )
	then
		unit:PlaySoundToSet( 17495 );
		unit:SendChatMessage( 12, 0, "They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the Sanctum." );
		RUBY_SANCTUM[ iid ].vars = 5;
		RUBY_SANCTUM[ iid ].timer = 9;

	elseif( RUBY_SANCTUM[ iid ].timer <= 0 and RUBY_SANCTUM[ iid ].vars == 5 )
	then
		unit:PlaySoundToSet( 17496 );
		unit:SendChatMessage( 12, 0, "The commander of the forces on the ground here is a cruel brute named Zarithrian, but I fear there are greater powers at work." );
		RUBY_SANCTUM[ iid ].vars = 6;
		RUBY_SANCTUM[ iid ].timer = 10;
		
	elseif( RUBY_SANCTUM[ iid ].timer <= 0 and RUBY_SANCTUM[ iid ].vars == 6 )
	then
		unit:PlaySoundToSet( 17497 );
		unit:SendChatMessage( 12, 0, "In their initial assault, I caught a glimpse of their true leader, a fearsome full-grown twilight dragon." );
		RUBY_SANCTUM[ iid ].vars = 7;
		RUBY_SANCTUM[ iid ].timer = 8;
		
	elseif( RUBY_SANCTUM[ iid ].timer <= 0 and RUBY_SANCTUM[ iid ].vars == 7 )
	then
		unit:PlaySoundToSet( 17498 );
		unit:SendChatMessage( 12, 0, "I know not the extent of their plans, heroes, but I know this:  They cannot be allowed to succeed!" );
		unit:Emote( 5, 0 );
		unit:RemoveAIUpdateEvent();
		unit:SetNPCFlags( 3 );
		RUBY_SANCTUM[ iid ].vars = nil;
		RUBY_SANCTUM[ iid ].timer = nil;
	end
end

function RUBY_SANCTUM.OnAreaTrigger( _, plr, areaTriggerID )

	local iid = plr:GetInstanceID();
	
	-- on baltharus plateau
	if( areaTriggerID == 5867 and RUBY_SANCTUM[ iid ].hasTriggered == false )
	then
		-- get xerex using spawnid
		local xerex = GetInstanceCreature( 724, iid, 134456 );
		if( xerex )
		then
			xerex:RegisterLuaEvent( RUBY_SANCTUM.DoAction, 1000, 1, 1 );
		end
		
		-- get baltharus using spawnid
		local baltharus = GetInstanceCreature( 724, iid, 134428 );
		if( baltharus )
		then
			baltharus:RegisterLuaEvent( RUBY_SANCTUM.DoAction, 7000, 1, 2 );
		end
		
		-- dont cry for help again if already cryed
		RUBY_SANCTUM[ iid ].hasTriggered = true;
	end
end

function RUBY_SANCTUM.OnCreaturePush( _, creature )

	local entry = creature:GetEntry();
	
	local iid = creature:GetInstanceID();
	
	-- zarithrian
	if( entry == 39746 )
	then
		if( RUBY_SANCTUM[ iid ].savianaIsDead == true and RUBY_SANCTUM[ iid ].baltharusIsDead == true )
		then
			-- make him attacable and selectable
			creature:RemoveFlag( 0x0006 + 0x0035, 0x00000100 + 0x02000000 );

		elseif( RUBY_SANCTUM[ iid ].savianaIsDead == false and RUBY_SANCTUM[ iid ].baltharusIsDead == false )
		then
			-- make him not attacable and not selectable
			creature:SetFlag( 0x0006 + 0x0035, 0x00000100 + 0x02000000 );
		end
	end
end

function RUBY_SANCTUM.OnGOPush( _, go )

	local entry = go:GetEntry();
	
	local iid = go:GetInstanceID();
	
	-- fire field
	if( entry == 203005 and RUBY_SANCTUM[ iid ].baltharusIsDead == true )
	then
		go:SetByte( 0x0006 + 0x000B, 0, 0 );
	
	-- flame wall
	elseif( entry == 203006 and RUBY_SANCTUM[ iid ].savianaIsDead == true and RUBY_SANCTUM[ iid ].baltharusIsDead == true )
	then
		go:SetByte( 0x0006 + 0x000B, 0, 0 );
	
	-- burning trees
	elseif( entry == 203034 or entry == 203035 or entry == 203036 or entry == 203037 )
	then
		if( RUBY_SANCTUM[ iid ].zarithrianIsDead == true )
		then
			go:SetByte( 0x0006 + 0x000B, 0, 0 );
		end
	end
end

RegisterUnitEvent( 40429, 21, RUBY_SANCTUM.XerexOnAIUpdate );
RegisterInstanceEvent( 724, 2, RUBY_SANCTUM.OnPlayerEnter );
RegisterInstanceEvent( 724, 5, RUBY_SANCTUM.OnCreatureDeath );
RegisterInstanceEvent( 724, 3, RUBY_SANCTUM.OnAreaTrigger );
RegisterInstanceEvent( 724, 6, RUBY_SANCTUM.OnCreaturePush );
RegisterInstanceEvent( 724, 8, RUBY_SANCTUM.OnGOPush );

--print( "Lua memory after Ruby Sanctum: "..gcinfo().." KB." );

--
--
--[[ 
		DEBUG COMMANDS DISABLED BY DEFAULT
--
--
--

local COMMANDS = { "ruby", "xerex", "open", "close", "phase1", "phase32" };

function RubyCommands( _, plr, message )

	if( plr:IsGm() == true )
	then
		if( message == "#ruby" )
		then
			for i = 1, #COMMANDS
			do
				plr:SendBroadcastMessage( ""..COMMANDS[ i ].."" );
			end
		
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