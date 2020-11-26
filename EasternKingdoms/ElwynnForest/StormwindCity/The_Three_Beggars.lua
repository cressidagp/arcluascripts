--[[	
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Stormwind City: The Three Beggars (Ol' Beasley, Topper Mcnabb, Morris Lawry)
	Engine: A.L.E
	Credits: to Trinity for creature texts
	
	enUS:
	
	MCNABB[ 1 ] = "Could ye spare some coin?";
	MCNABB[ 2 ] = "Help a poor bloke out?";
	MCNABB[ 3 ] = "Shine yer armor fer a copper.";
	MCNABB[ 4 ] = "It's all their fault, stupid orcs. Had to burn my farm to the ground.";
	MCNABB[ 5 ] = "Spare some change for a poor blind man? ...What do you mean I'm not blind? ...I'M NOT BLIND! I CAN SEE!! It's a miracle!";
	MCNABB[ 6 ] = "Alms for the poor?";
	MCNABB[ 7 ] = "I will gladly pay you Tuesday for a hamburger today.";
	MCNABB[ 8 ] = "It's all their fault, stupid Alliance army. Just had to build their towers right behind my farm.";

	esMX:
	
	MCNABB[ 1 ] = "¿Podrías regalarme alguna moneda?";
	MCNABB[ 2 ] = "¿Ayuda a un pobre hombre?";
	MCNABB[ 3 ] = "Dale brillo a tu armadura por un cobre.";
	MCNABB[ 4 ] = "Todo es su culpa, estúpidos orcos. Tuve que quemar mi granja hasta el suelo.";
	MCNABB[ 5 ] = "¿Regalarías algo de cambio a un pobre hombre ciego? ...¿Qué quieres decir con que no estoy ciego? ...NO ESTOY CIEGO! PUEDO VER!! Es un milagro!";
	MCNABB[ 6 ] = "¿Una limosna para los pobres?";
	MCNABB[ 7 ] = "Cómprame una hamburguesa hoy y con gusto te la pagare el martes.";
	MCNABB[ 8 ] = "Todo es su culpa, estúpido ejército de La Alianza. Tenían que construir sus torres justo detrás de mi granja.";	
	
--]]

local NPC_BEGGARS_ENTRY = { 1395, 1402, 1405 };

MCNABB = {}
MCNABB[ 1 ] = "Could ye spare some coin?";
MCNABB[ 2 ] = "Help a poor bloke out?";
MCNABB[ 3 ] = "Shine yer armor fer a copper.";
MCNABB[ 4 ] = "It's all their fault, stupid orcs. Had to burn my farm to the ground.";
MCNABB[ 5 ] = "Spare some change for a poor blind man? ...What do you mean I'm not blind? ...I'M NOT BLIND! I CAN SEE!! It's a miracle!";
MCNABB[ 6 ] = "Alms for the poor?";
MCNABB[ 7 ] = "I will gladly pay you Tuesday for a hamburger today.";
MCNABB[ 8 ] = "It's all their fault, stupid Alliance army. Just had to build their towers right behind my farm.";

function MCNABB.RandomSay( unit, event )

    if( unit:IsInCombat() == false )
	
    then
	
        unit:SendChatMessage( 12, 7, MCNABB[ math.random( 1, 8 ) ] );
		
    end
	
end

function MCNABB.OnSpawn( unit, event )

    unit:RegisterEvent( MCNABB.RandomSay, 180000, 0 );
	
end

for i = 1, #NPC_BEGGARS_ENTRY
do

    RegisterUnitEvent( NPC_BEGGARS_ENTRY[ i ], 18, MCNABB.OnSpawn );

end