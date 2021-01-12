--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Hooks Chat
	Engine: A.L.E
	Credits: nil

--]]

local COMMANDS = { "help", "gprint", "removeauras", "getphase", "jail", "entry" };

HOOKS_CHAT = {}

function HOOKS_CHAT.AllCommands( event, plr, msg )

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
			
		else
			local target = plr:GetSelection();
			if( target == nil )
			then
				plr:SendBroadcastMessage( "You dont have a target." );
				
			else
				if( msg == "#removeauras" )
				then
					target:RemoveAllAuras();
				
				elseif( msg == "#getphase" )
				then
					plr:SendBroadcastMessage( "Phase: "..target:GetPhase().."" );
				
				elseif( msg == "#jail" )
				then
					target:Teleport( 0, -8667.677, 624.130, 95.69, 2.2 );
					target:SendBroadcastMessage( "You are in jail." );
					plr:SendBroadcastMessage( "Player has been send to jail." );					
			
				elseif( msg == "#entry" )
				then
					plr:SendBroadcastMessage( "Entry: "..target:GetEntry().."" );
				
				--[[ debug rangecheck
				elseif( msg == "#distance" )
				then 
					plr:SendBroadcastMessage( "Distance: "..plr:GetDistance( target ).."" );
					plr:SendBroadcastMessage( "Use .debug dist to get distance in yards." );
				--]]
				end
			end
		end
	end
end

RegisterServerHook( 16, HOOKS_CHAT.AllCommands );
