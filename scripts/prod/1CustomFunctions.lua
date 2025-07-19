--[[

	ArcLuaScripts for ArcEmu
	Engine: A.L.E
	2024

	Credits:

	*) TrinityCore for texts, sound ids, timers and some Inspiration.
	*) Hypersniper for his lua guides and some job in the lua engine.
	*) Paroxysm for his Modular Way of scripting, LCF and Lua Scripting Expected Standards.
	*) ArcEmu developers for ArcEmu and A.L.E, specially to dfighter1985.

	Developer notes: added here some custom function(s) that can be used at more than one script.

--]]
function table.find( t, v ) 
    if type( t ) == "table" and v then
        for k, value in pairs( t ) do
            if v == value then
                return true 
            end
        end
    end
    return false
end

function talkFromDB( unit, group )

	if unit == nil or group == nil then return end
	
	local entry = unit:GetEntry()
	
	local result = WorldDBQuery("SELECT ID, Text, Type, Language, Probability, Emote, Duration, Sound FROM lua_text WHERE npcId = '"..entry.."' AND groupId = '"..group.."' ")
	
	if result ~= nil then
		
		local rowCount = result:GetRowCount()
		
		if rowCount >= 2 then
		
			local randomRow = math.random( 1, rowCount )
				
			for i = randomRow, rowCount, 1 do
			
				if i == rowCount then
				
					break
				
				else
				
					result:NextRow()
					
				end
			
			end
		
		end
		
		local ID = result:GetColumn( 0 ):GetUByte()
		local textString = result:GetColumn( 1 ):GetString()
		local Type = result:GetColumn( 2 ):GetUByte()
		local language = result:GetColumn( 3 ):GetUByte()
		local probability = result:GetColumn( 4 ):GetUShort()
		local emoteId = result:GetColumn( 5 ):GetUShort()
		local duration = result:GetColumn( 6 ):GetUShort()
		local soundId = result:GetColumn( 7 ):GetUShort()
		
		local randomUInt = math.random( 0, 100 )
		
		if randomUInt <= probability then
		
			if duration > 0 then
		
				unit:EventChat( Type, language, textString, duration )
				
				-- waiting for EventPlaySound :(
			
			else
		
				unit:SendChatMessage( Type, language, textString )
			
			end
			
			if soundId ~= 0 then
			
				unit:PlaySoundToSet( soundId )
				
			end
		
			if emoteId ~= 0 then
		
				unit:Emote( emoteId )
		
			end
			
		end
	
	end
	
end