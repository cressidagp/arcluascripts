--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Cast Fishing Net (29866)
	Engine: A.L.E

	Credits:

	*) Fasthio, Jackpoz, Sadikum, dfighter1985
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

	Precondition(s):

	*) Casted by player.
	*) Player has quest 9452.
	*) Player is near a school of Red Snapper fish.

	Effect(s):

	*) Despawns the fish school and gives to player one Red Snapper (23614).
	*) Has a chance of spawning and Angry Murloc.

--]]

function CastFishingNetDummy( effectIndex, spellObject )

	local caster = spellObject:GetCaster();

	if( caster == nil or caster:IsPlayer() == false )
	then return; end

	if( caster:HasQuest( 9452 ) == false ) then return; end

	local target = caster:GetGameObjectNearestCoords( caster:GetX(), caster:GetY(), caster:GetZ(), 181616 );

	if( target ) then target:Activate();

		-- TODO: play some water effect

		target:Despawn( 1000, 200000 );
	end

	local chance = math.random( 1, 10 );

	if( chance >= 7 )
	then
		local murloc = caster:SpawnCreature( 17102, caster:GetX(), caster:GetY(), caster:GetZ(), caster:GetO(), 14, 0, 0, 0, 0, 1, 0 );
		murloc:StopMovement( 500 );
		murloc:SetAttackTimer( 1000 );
	end
	
	if( caster:GetItemCount( 23614 ) < 10 )
	then
		caster:AddItem( 23614, 1 );
	end
end

RegisterDummySpell( 29866, CastFishingNetDummy );