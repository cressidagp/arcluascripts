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