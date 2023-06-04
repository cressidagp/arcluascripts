--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Zone: Elwynn Forest, Dun Morogh
	Creature: Bread Vendors ( Kira Songshine, Myra Tyrngaarde )

	Credits:
	
	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.
	
	enUS locale:
	
	"Fresh bread, baked this very morning!",
	"Come get yer fresh bread!",
	"Fresh bread for sale!"
	
	esMX locale:

	"¡Pan casero, horneado esta mañana!",
	"¡Venga a buscar su pan casero!",
	"¡Pan casero a la venta!"

--]]

--local NPC_KIRA_SONGSHINE = 3937;
--local NPC_MYRA_TYRNGAARDE = 5109;

local text = {
"Fresh bread, baked this very morning!",
"Come get yer fresh bread!",
"Fresh bread for sale!"
};

BREAD_VENDORS = {}

function BREAD_VENDORS.OutOfCombatChat( unit, event )

	--
	-- on ai update
	--
	
	if event == 21 then
		if unit:IsInCombat() == false then
		
			unit:SendChatMessage( 12, 7, text[ math.random( 1, 3 ) ] )

			local entry = unit:GetEntry()
			
			-- Kira Songshine
			if entry == 3937 then
			
				unit:ModifyAIUpdateEvent( math.random( 30000, 45000 ) )
				
			else
			
				unit:ModifyAIUpdateEvent( math.random( 40000, 60000 ) )
				
			end	
		end
	
	--	
	-- on spawn
	--
	
	else
		local entry = unit:GetEntry()
		
		-- Kira Songshine
		if entry == 3937 then 
		
			unit:RegisterAIUpdateEvent( math.random( 5000, 10000 ) )

		else
		
			unit:RegisterAIUpdateEvent( math.random( 10000, 15000 ) )
			
		end
	end
end

-- Kira Songshine:
RegisterUnitEvent( 3937, 18, BREAD_VENDORS.OutOfCombatChat );
RegisterUnitEvent( 3937, 21, BREAD_VENDORS.OutOfCombatChat );

-- Myra Tyrngaarde:
RegisterUnitEvent( 5109, 18, BREAD_VENDORS.OutOfCombatChat );
RegisterUnitEvent( 5109, 21, BREAD_VENDORS.OutOfCombatChat );