local scale = require 'color.scale'

--- Converts degree values [0,360] to normalized values [0,1].
---
--- This function scales degree-based color components (typically hue) to
--- floating-point values in the range [0,1] by dividing by 360. It supports
--- converting 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param a number First degree value to convert in range [0,360] (required)
--- @param b number|nil Second degree value to convert in range [0,360] (optional)
--- @param c number|nil Third degree value to convert in range [0,360] (optional)
--- @return number|number,number|number,number,number The normalized value(s) in range [0,1]
---
--- @raise error if a is nil
---
--- @usage
--- local hue = from_degrees(180)           -- returns 0.5
--- local h1, h2 = from_degrees(0, 240)     -- returns 0.0, 0.667
--- local h, s, v = from_degrees(60, 100, 50) -- returns 0.167, 1.0, 0.139
---
--- @see to_degrees
local function from_degrees(a, b, c)
    assert(a ~= nil and type(a) == "number" and a >= 0 and a <= 360, "a must be a number in range [0, 360]")
    assert(b == nil or (type(b) == "number" and b >= 0 and b <= 360), "b must be a number in range [0, 360] or nil")
    assert(c == nil or (type(c) == "number" and c >= 0 and c <= 360), "c must be a number in range [0, 360] or nil")
    return scale(1 / 360.0, a, b, c)
end

return from_degrees