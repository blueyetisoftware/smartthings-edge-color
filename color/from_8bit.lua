local scale = require 'color.scale'

--- Converts 8-bit integer color values [0,255] to normalized values [0,1].
---
--- This function scales 8-bit integer color components to floating-point values
--- in the range [0,1] by dividing by 255. It supports converting 1, 2, or 3 values
--- depending on how many arguments are provided.
---
--- @param a number First 8-bit value to convert in range [0,255] (required)
--- @param b number|nil Second 8-bit value to convert in range [0,255] (optional)
--- @param c number|nil Third 8-bit value to convert in range [0,255] (optional)
--- @return number|number,number|number,number,number The normalized value(s) in range [0,1]
---
--- @raise error if a is nil
---
--- @usage
--- local r = from_8bit(255)                    -- returns 1.0
--- local r, g = from_8bit(128, 179)            -- returns 0.502, 0.702
--- local r, g, b = from_8bit(26, 51, 77)       -- returns 0.102, 0.2, 0.302
---
--- @see to_8bit
local function from_8bit(a, b, c)
    assert(a ~= nil and type(a) == "number" and a >= 0 and a <= 255, "a must be a number in range [0, 255]")
    assert(b == nil or (type(b) == "number" and b >= 0 and b <= 255), "b must be a number in range [0, 255] or nil")
    assert(c == nil or (type(c) == "number" and c >= 0 and c <= 255), "c must be a number in range [0, 255] or nil")
    return scale(1 / 255.0, a, b, c)
end

return from_8bit