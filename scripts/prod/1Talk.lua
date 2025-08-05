function Talk( unit, group )

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