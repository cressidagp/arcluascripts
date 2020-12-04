--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Hooks Chat
	Engine: A.L.E
	Credits: nil

--]]

local COMMANDS = { "help", "gdisplay", "removeauras", "getphase" };

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
			end
		
			plr:SendBroadcastMessage( "Lua global table has been printed." );
	
		elseif( msg == "#gdisplay" )
		then
			for n in pairs( _G ) 
			do 
				plr:SendBroadcastMessage( ""..n.."" ); 
			end
		
		-- .debug rangecheck
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
		end
	end
end

RegisterServerHook( 16, HOOKS_CHAT.AllCommands );
