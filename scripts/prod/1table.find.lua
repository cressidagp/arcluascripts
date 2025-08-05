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