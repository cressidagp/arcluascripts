--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Dun Morogh
	Creature: Myra Tyrngaarde (5109)	

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	[ 1 ] = "Fresh bread, baked this very morning!";
	[ 2 ] = "Come get yer fresh bread!";
	[ 3 ] = "Fresh bread for sale!";
	
	esMX locale:

	[ 1 ] = "¡Pan casero, horneado esta mañana!";
	[ 2 ] = "¡Come get yer fresh bread!";
	[ 3 ] = "¡Fresh bread for sale!";

--]]
MYRA = {
[ 1 ] = "Fresh bread, baked this very morning!";
[ 2 ] = "Come get yer fresh bread!";
[ 3 ] = "Fresh bread for sale!";
};

function MYRA.OoCRandomChat( unit, event )

	-- on ai update
    if( event == 21 )
    then
	
		if( unit:IsInCombat() == false )
		then
		    unit:SendChatMessage( 12, 7, MYRA[ math.random( 1, 3 ) ] );
            unit:ModifyAIUpdateEvent( math.random( 40000, 60000 ) );
		end
	
	-- on spawn
    else
		unit:RegisterAIUpdateEvent( math.random( 10000, 15000 ) );
    end
end

RegisterUnitEvent( 5109, 18, MYRA.OoCRandomChat );
RegisterUnitEvent( 5109, 21, MYRA.OoCRandomChat );
