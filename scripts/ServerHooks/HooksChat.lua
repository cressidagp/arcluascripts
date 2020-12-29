--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Hooks Chat
	Engine: A.L.E

	Credits:

	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his ArcEmu Lua Engine, specially to dfighter1985.

--]]

local COMMANDS = { "help", "gprint", "removeauras", "getphase", "jail", "entry" };

HOOKS_CHAT = {}

function HOOKS_CHAT.AllCommands( event, plr, msg, type, lang, misc )

	if( plr:IsGm() == true )
	then
		if( msg == "#help" )
		then
			for i = 1, #COMMANDS
			do
				plr:SendBroadcastMessage( ""..COMMANDS[ i ].."" );
			end
	
		elseif( msg == "#gprint" )
		then
			for n in pairs( _G )
			do 
				print( n );
				plr:SendBroadcastMessage( ""..n.."" );
			end
		
			plr:SendBroadcastMessage( "Lua global table has been printed." );
		
		--.debug rangecheck
		--elseif( msg == "#distance" )
		--then
			--local target = plr:GetSelection();
			--plr:SendBroadcastMessage( "Distance: "..plr:GetDistance( target ).."" );
			--plr:SendBroadcastMessage( "Use .debug dist to get distance in yards." );
		
		elseif( msg == "#removeauras" )
		then
			local target = plr:GetSelection();
			if( target ~= nil )
			then
				target:RemoveAllAuras();
				plr:SendBroadcastMessage( "All auras has been removed from the target." );
			else
				plr:SendBroadcastMessage( "You dont have a target." );
			end
			
		elseif( msg == "#getphase" )
		then
			local target = plr:GetSelection();
			if( target ~= nil )
			then
				plr:SendBroadcastMessage( "Phase: "..target:GetPhase().."" );
			else
				plr:SendBroadcastMessage( "You dont have a target." );
			end
		
		elseif( msg == "#jail" )
		then
			local target = plr:GetSelection();
			if( target ~= nil )
			then
				target:Teleport( 0, -8667.677, 624.130, 95.69, 2.2 );
				target:SendBroadcastMessage( "You are in jail." );
				plr:SendBroadcastMessage( "Player has been send to jail." );
			else
				plr:SendBroadcastMessage( "You dont have a target." );
			end
			
		elseif( msg == "#entry" )
		then
			local target = plr:GetSelection();
			if( target ~= nil )
			then
				plr:SendBroadcastMessage( "Entry: "..target:GetEntry().."" );
			else
				plr:SendBroadcastMessage( "You dont have a target." );
			end
		end
	end
end

RegisterServerHook( 16, HOOKS_CHAT.AllCommands );
