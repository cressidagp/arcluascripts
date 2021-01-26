--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Engine: A.L.E
	
	Hooks Chat
	
	Credits:

	*) TrinityCore for texts, sound ids, timers, spell ids and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and his A.L.E, specially to dfighter1985.

--]]

local COMMANDS = { "help", "gprint", "removeauras", "getphase", "jail", "entry", "movetype" };

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
			
				
		elseif( msg == "#removeauras" )
		then
			local selection = plr:GetSelection();
			selection:RemoveAllAuras();
				
		elseif( msg == "#getphase" )
		then
			local selection = plr:GetSelection();
			plr:SendBroadcastMessage( "Phase: "..selection:GetPhase().."" );
				
		elseif( msg == "#jail" )
		then
			local selection = plr:GetSelection();
			selection:Teleport( 0, -8667.677, 624.130, 95.69, 2.2 );
			selection:SendBroadcastMessage( "You are in jail." );
			plr:SendBroadcastMessage( "Player has been send to jail." );					
			
		elseif( msg == "#entry" )
		then
			plr:SendBroadcastMessage( "Entry: "..selection:GetEntry().."" );
					
		elseif( msg == "#movetype" )
		then
			local selection = plr:GetSelection();
			plr:SendBroadcastMessage( "Entry: "..selection:GetMovementType().."" );
					
		--[[ debug rangecheck
		elseif( msg == "#distance" )
		then 
			plr:SendBroadcastMessage( "Distance: "..plr:GetDistance( target ).."" );
			plr:SendBroadcastMessage( "Use .debug dist to get distance in yards." );
		--]]
		end
	end
end

RegisterServerHook( 16, HOOKS_CHAT.AllCommands );