--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Icecrown Citadel: Lord Marrowgar
	Engine: A.L.E
	Credits: Trinity for sound ids, chats and text.

local SOUND = {
[ 1 ] = 16950; -- OnEnterZone
[ 2 ] = 16941; -- OnEnterCombat
[ 3 ] = 16946; -- OnCast: "Bonestorm"
[ 4 ] = 16947; -- OnCast: "Bonespike" 1
[ 5 ] = 16948; -- OnCast: "Bonespike" 2
[ 6 ] = 16949; -- OnCast: "Bonespike" 3
[ 7 ] = 16942; -- OnTargetDied 1
[ 8 ] = 16943; -- OnTargetDied 2
[ 9 ] = 16944; -- OnDeath
[ 10 ] = 16945; -- OnCast: "Berserk"
};

local CHAT = {
[ 1 ] = "This is the beginning AND the end, mortals. None may enter the master's sanctum!";
[ 2 ] = "The Scourge will wash over this world as a swarm of death and destruction!";
[ 3 ] = "BONE STORM!";
[ 4 ] = "Bound by bone!";
[ 5 ] = "Stick around!";
[ 6 ] = "The only escape is death!";
[ 7 ] = "More bones for the offering!";
[ 8 ] = "Languish in damnation!";
[ 9 ] = "I see... Only darkness.";
[ 10 ] = "THE MASTER'S RAGE COURSES THROUGH ME!";
};

local TEXT = {
[ 1 ] = "%s creates a whirling storm of bone!"; -- Bonestorm emote
};
--]]

local self = getfenv( 1 )

function LordMarrowgar_OnSpawn( unit, event )

	unit:SendChatMessage( 14, 0, "This is the beginning AND the end, mortals. None may enter the master's sanctum!" )
	unit:PlaySoundToSet( 16950 )

end

function LordMarrowgar_OnEnterCombat( unit, event, attacker )

	unit:PlaySoundToSet( 16941 )
	
	unit:RegisterAIUpdateEvent( 1000 )
	
	self[ tostring( unit ) ] = {
	
		boneSliceEnabled = false,
		boneSlice = 10,
		boneSliceAttack = 10,
		coldFlame = 5,
		boneSpikeGraveyard = 15,
		coldflame = 5,
		warnBoneStorm = math.random( 45, 50 ),
		berserk = 10 * 60 * 1000
	
	}

end

function LordMarrowgar_OnTargetDied( unit, event, victim )

	local chance = math.random( 0, 1 )
	
	if chance == 0 then
	
		unit:SendChatMessage( 14, 0, "More bones for the offering!" )
		unit:PlaySoundToSet( 16942 )
	
	else
		
		unit:SendChatMessage( 14, 0, "Languish in damnation!" )
		unit:PlaySoundToSet( 16943 )
	
	end
	
end

function LordMarrowgar_OnDied( unit, event, killer )

	unit:PlaySoundToSet( 16944 )

end

function LordMarrowgar_OnAIUpdate( unit )

	if( unit:GetAIState() == 2 ) then return; end

	local vars = self[ tostring( unit ) ]
	
	if vars.boneSliceEnabled == false then
	
		vars.boneSlice = vars.boneSlice - 1
		
		if vars.boneSlice <= 0 then
		
			vars.boneSliceEnabled = true
			unit:DisableMelee( 1 )
			
		end

	else
	
		vars.boneSliceAttack = vars.boneSliceAttack - 1
		
		if vars.boneSliceAttack <= 0 then
		
			unit:CastSpellOnTarget( 69055, unit:GetMainTank() )
			vars.boneSliceAttack = 10
		
		end
	
	end
	
	vars.boneSpikeGraveyard = vars.boneSpikeGraveyard - 1
	vars.coldflame = vars.coldflame - 1
	vars.warnBonestorm = vars.warnBonestorm - 1
	vars.berserk = vars.berserk - 1
	
	if vars.boneSpikeGraveyard <= 0 then
	
		unit:FullCastSpell( 69057 )
		
		local chance = math.random( 0, 2 )
		
		if chance == 0 then
		
			unit:SendChatMessage( 14, 0, "Bound by bone!" )
			unit:PlaySoundToSet( 16947 )
		
		elseif chance == 1 then
		
			unit:SendChatMessage( 14, 0, "Stick around!" )
			unit:PlaySoundToSet( 16948 )
		
		else
		
			unit:SendChatMessage( 14, 0, "The only escape is death!" )
			unit:PlaySoundToSet( 16949 )
		
		end
		
		vars.boneSpikeGraveyard = math.random( 15, 20 )
	
	elseif vars.coldflame <= 0 then
	
		if unit:HasAura( 69076 ) == false then
		
			unit:FullCastSpell( 69140 )
			
		else
		
			unit:FullCastSpell( 72705 )
			
		end
		
		vars.coldflame = 5
	
	elseif vars.warnBonestorm <= 0 then
	
		unit:SendChatMessage( 42, 0, "%s creates a whirling storm of bone!" )
		vars.warnBonestorm = 95
	
	elseif vars.berserk <= 0 then
	
		unit:CastSpell( 26662 )
		unit:SendChatMessage( 14, 0, "THE MASTER'S RAGE COURSES THROUGH ME!" )
		unit:PlaySoundToSet( 16945 )
		vars.berserk = 10 * 60 * 1000
	
	end

end

RegisterUnitEvent( 36612, 18, LordMarrowgar_OnSpawn )
RegisterUnitEvent( 36612, 1, LordMarrowgar_OnEnterCombat )
RegisterUnitEvent( 36612, 3, LordMarrowgar_OnTargetDied )
RegisterUnitEvent( 36612, 4, LordMarrowgar_OnDied )
RegisterUnitEvent( 36612, 21, LordMarrowgar_OnAIUpdate )