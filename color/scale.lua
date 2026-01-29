--- Scales one to three numeric values by a scalar multiplier.
---
--- This utility function multiplies each provided value by the given scalar.
--- It supports scaling 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param scalar number The multiplier to apply to all values
--- @param a number First value to scale (required)
--- @param b number|nil Second value to scale (optional)
--- @param c number|nil Third value to scale (optional)
--- @return number|number,number|number,number,number scaled value(s)
---
--- @raise error if a is nil
---
--- @usage
--- local scaled = scale(2.0, 1.0)           -- returns 2.0
--- local r, g = scale(255.0, 0.5, 0.7)      -- returns 127.5, 178.5
--- local x, y, z = scale(100.0, 0.1, 0.2, 0.3) -- returns 10.0, 20.0, 30.0
local function scale(scalar, a, b, c)
    assert(type(scalar) == "number", "scalar must be a number")
    assert(a ~= nil and type(a) == "number", "a must be a number")
    assert(b == nil or type(b) == "number", "b must be a number or nil")
    assert(c == nil or type(c) == "number", "c must be a number or nil")
    if c ~= nil then
        return a * scalar, b * scalar, c * scalar
    elseif b ~= nil then
        return a * scalar, b * scalar
    elseif a ~= nil then
        return a * scalar
    end
end

return scale