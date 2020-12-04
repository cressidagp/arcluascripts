--[[
	ArcLuaScripts for ArcEmu
	www.ArcEmu.org
	Debug Kit
	Engine: A.L.E
	Credits: nil

--]]

HOOKS_CHAT = {}

function HOOKS_CHAT.AllCommands( event, plr, msg, type, lang, misc )

	if( plr:IsGm() == true )
	then
		if( msg == "#gprint" )
		then
			for n in pairs( _G )
			do 
				print( n ); 
			end
		
			plr:SendBroadcastMessage( "Global table has been printed." );
	
		elseif( msg == "#gdisplay" )
		then
			for n in pairs( _G ) 
			do 
				plr:SendBroadcastMessage( ""..n.."" ); 
			end
		end
	end
end

RegisterServerHook( 16, HOOKS_CHAT.AllCommands );
