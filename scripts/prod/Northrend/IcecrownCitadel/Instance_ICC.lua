local ICC = {}

function ICC.onPlayerEnter( iid, plr )

	local iid = plr:GetInstanceID()

	-- create protected variables
	if ICC[ iid ] == nil
	then
		ICC[ iid ] = {
		
			lordMarrowgarIsDead = false,
			ladyDeathwhisperIsDead = false
		
		}

		--
		-- @DarkAngel39 instance progression system
		--
		local string_data = {}

		local result = CharDBQuery( "SELECT killed_npc_guids FROM instances WHERE id = "..iid.."; " )

		if result ~= nil
		then
			local colcount = result:GetColumnCount()

			repeat

				for col = 0, colcount - 1, 1 do

					string_data[ col ] = result:GetColumn( col ):GetString()

					-- Lord Marrowgar
					local b1 = string.find( string_data[ col ], "36612" )

					if( b1 ~= nil ) then ICC[ iid ].lordMarrowgarIsDead = true end

				end

			until result:NextRow() ~= true;

		end

	end

end

RegisterInstanceEvent( 631, 2, ICC.onPlayerEnter )