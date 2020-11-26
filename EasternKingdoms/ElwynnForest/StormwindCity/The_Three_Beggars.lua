--[[	
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Stormwind City: The Three Beggars (Ol' Beasley, Topper Mcnabb, Morris Lawry)
	Engine: A.L.E
	Credits: to Trinity for creature texts
	
	enUS:
	
	local BEASLEY = {
	[ 1 ] = "It's all their fault, stupid Alliance army. Just had to build their towers right behind my farm.";
	[ 2 ] = "Spare some change for a poor blind man? ...What do you mean I'm not blind? ...I'M NOT BLIND! I CAN SEE!! It's a miracle!";
	[ 3 ] = "I will gladly pay you Tuesday for a hamburger today.";
	[ 4 ] = "Could ye spare some coin?";
	[ 5 ] = "Help a poor bloke out?";
	[ 6 ] = "Shine yer armor for a copper.";
	[ 7 ] = "It's all their fault, stupid orcs. Had to burn my farm to the ground.";
	[ 8 ] = "Alms for the poor?";

	local MCNABB = {
	[ 1 ] = "Could ye spare some coin?";
	[ 2 ] = "Help a poor bloke out?";
	[ 3 ] = "Shine yer armor fer a copper.";
	[ 4 ] = "It's all their fault, stupid orcs. Had to burn my farm to the ground.";
	[ 5 ] = "Spare some change for a poor blind man? ...What do you mean I'm not blind? ...I'M NOT BLIND! I CAN SEE!! It's a miracle!";
	[ 6 ] = "Alms for the poor?";
	[ 7 ] = "I will gladly pay you Tuesday for a hamburger today.";
	[ 8 ] = "It's all their fault, stupid Alliance army. Just had to build their towers right behind my farm.";

	local MORRISLAWRY = {
	[ 1 ] = "Could ye spare some coin?";
	[ 2 ] = "Help a poor bloke out?";
	[ 3 ] = "Shine yer armor for a copper.";
	[ 4 ] = "It's all their fault, stupid Alliance army. Just had to build their towers right behind my farm.";
	[ 5 ] = "Spare some change for a poor blind man? ...What do you mean I'm not blind? ...I'M NOT BLIND! I CAN SEE!! It's a miracle!";
	[ 6 ] = "I will gladly pay you Tuesday for a hamburger today.";
	[ 7 ] = "It's all their fault, stupid orcs. Had to burn my farm to the ground.";
	[ 8 ] = "Alms for the poor?";

	esMX:

	local BEASLEY = {
	[ 1 ] = "Todo es su culpa, estúpido ejército de La Alianza. Tenían que construir sus torres justo detrás de mi granja.";
	[ 2 ] = "¿Regalarías algo de cambio a un pobre hombre ciego? ...¿Qué quieres decir con que no estoy ciego? ...NO ESTOY CIEGO! PUEDO VER!! Es un milagro!";
	[ 3 ] = "Cómprame una hamburguesa hoy y con gusto te la pagare el martes.";
	[ 4 ] = "¿Podrías regalarme alguna moneda?";
	[ 5 ] = "¿Ayuda a un pobre hombre?";
	[ 6 ] = "Dale brillo a tu armadura por un cobre.";
	[ 7 ] = "Todo es su culpa, estúpidos orcos. Tuve que quemar mi granja hasta el suelo.";
	[ 8 ] = "¿Una limosna para los pobres?";
	
	local MCNABB = {
	[ 1 ] = "¿Podrías regalarme alguna moneda?";
	[ 2 ] = "¿Ayuda a un pobre hombre?";
	[ 3 ] = "Dale brillo a tu armadura por un cobre..";
	[ 4 ] = "Todo es su culpa, estúpidos orcos. Tuve que quemar mi granja hasta el suelo.";
	[ 5 ] = "¿Regalarías algo de cambio a un pobre hombre ciego? ...¿Qué quieres decir con que no estoy ciego? ...NO ESTOY CIEGO! PUEDO VER!! Es un milagro!";
	[ 6 ] = "¿Una limosna para los pobres?";
	[ 7 ] = "Cómprame una hamburguesa hoy y con gusto te la pagare el martes.";
	[ 8 ] = "Todo es su culpa, estúpido ejército de La Alianza. Tenían que construir sus torres justo detrás de mi granja.";

	local MORRISLAWRY = {
	[ 1 ] = "¿Podrías regalarme alguna moneda?";
	[ 2 ] = "¿Ayuda a un pobre hombre?";
	[ 3 ] = "Dale brillo a tu armadura por un cobre.";
	[ 4 ] = "Todo es su culpa, estúpido ejército de La Alianza. Tenían que construir sus torres justo detrás de mi granja.";
	[ 5 ] = "¿Regalarías algo de cambio a un pobre hombre ciego? ...¿Qué quieres decir con que no estoy ciego? ...NO ESTOY CIEGO! PUEDO VER!! Es un milagro!";
	[ 6 ] = "Cómprame una hamburguesa hoy y con gusto te la pagare el martes.";
	[ 7 ] = "Todo es su culpa, estúpidos orcos. Tuve que quemar mi granja hasta el suelo.";
	[ 8 ] = "¿Una limosna para los pobres?";
	
--]]

local NPC_BEGGARS_ENTRY = { 1395, 1402, 1405 };

local BEASLEY = {
[ 1 ] = "It's all their fault, stupid Alliance army. Just had to build their towers right behind my farm.";
[ 2 ] = "Spare some change for a poor blind man? ...What do you mean I'm not blind? ...I'M NOT BLIND! I CAN SEE!! It's a miracle!";
[ 3 ] = "I will gladly pay you Tuesday for a hamburger today.";
[ 4 ] = "Could ye spare some coin?";
[ 5 ] = "Help a poor bloke out?";
[ 6 ] = "Shine yer armor for a copper.";
[ 7 ] = "It's all their fault, stupid orcs. Had to burn my farm to the ground.";
[ 8 ] = "Alms for the poor?";
};

local MCNABB = {
[ 1 ] = "Could ye spare some coin?";
[ 2 ] = "Help a poor bloke out?";
[ 3 ] = "Shine yer armor fer a copper.";
[ 4 ] = "It's all their fault, stupid orcs. Had to burn my farm to the ground.";
[ 5 ] = "Spare some change for a poor blind man? ...What do you mean I'm not blind? ...I'M NOT BLIND! I CAN SEE!! It's a miracle!";
[ 6 ] = "Alms for the poor?";
[ 7 ] = "I will gladly pay you Tuesday for a hamburger today.";
[ 8 ] = "It's all their fault, stupid Alliance army. Just had to build their towers right behind my farm.";
};

local MORRISLAWRY = {
[ 1 ] = "Could ye spare some coin?";
[ 2 ] = "Help a poor bloke out?";
[ 3 ] = "Shine yer armor for a copper.";
[ 4 ] = "It's all their fault, stupid Alliance army. Just had to build their towers right behind my farm.";
[ 5 ] = "Spare some change for a poor blind man? ...What do you mean I'm not blind? ...I'M NOT BLIND! I CAN SEE!! It's a miracle!";
[ 6 ] = "I will gladly pay you Tuesday for a hamburger today.";
[ 7 ] = "It's all their fault, stupid orcs. Had to burn my farm to the ground.";
[ 8 ] = "Alms for the poor?";
};

THREE_BEGGARS = {}

function THREE_BEGGARS.RandomSay( unit, event )

	if( unit:GetEntry() == 1395 and unit:IsInCombat() == false )
	
	then
	
		unit:SendChatMessage( 12, 7, BEASLEY[ math.random( 1, 8 ) ] ); -- 9397
		
	elseif( unit:GetEntry() == 1402 and unit:IsInCombat() == false )
	
	then
		
		unit:SendChatMessage( 12, 7, MCNABB[ math.random( 1, 8 ) ] ); -- 9475
		
	elseif( unit:GetEntry() == 1405 and unit:IsInCombat() == false )
	
	then
	
		unit:SendChatMessage( 12, 7, MORRISLAWRY[ math.random( 1, 8 ) ] ); -- 9477
		
	end
	
end

function THREE_BEGGARS.OnSpawn( unit, event )

	unit:RegisterEvent( THREE_BEGGARS.RandomSay, 180000, 0 );
	
end

for i = 1, #NPC_BEGGARS_ENTRY
do

	RegisterUnitEvent( NPC_BEGGARS_ENTRY[ i ], 18, THREE_BEGGARS.OnSpawn );

end