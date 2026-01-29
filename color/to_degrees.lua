local scale = require 'color.scale'

--- Converts normalized values [0,1] to degree values [0,360].
---
--- This function scales floating-point color components in the range [0,1] to
--- degree values in the range [0,360] by multiplying by 360. It supports
--- converting 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param a number First normalized value to convert in range [0,1] (required)
--- @param b number|nil Second normalized value to convert in range [0,1] (optional)
--- @param c number|nil Third normalized value to convert in range [0,1] (optional)
--- @return number|number,number|number,number,number The degree value(s) in range [0,360]
---
--- @raise error if a is nil
---
--- @usage
--- local hue = to_degrees(0.5)             -- returns 180
--- local h1, h2 = to_degrees(0.0, 0.667)   -- returns 0, 240
--- local h, s, v = to_degrees(0.167, 1.0, 0.5) -- returns 60, 360, 180
---
--- @see from_degrees
local function to_degrees(a, b, c)
    assert(a ~= nil and type(a) == "number" and a >= 0 and a <= 1, "a must be a number in range [0, 1]")
    assert(b == nil or (type(b) == "number" and b >= 0 and b <= 1), "b must be a number in range [0, 1] or nil")
    assert(c == nil or (type(c) == "number" and c >= 0 and c <= 1), "c must be a number in range [0, 1] or nil")
    return scale(360.0, a, b, c)
end

return to_degrees