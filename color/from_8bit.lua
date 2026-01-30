local scale = require 'color.scale'

--- Converts 8-bit integer color values to normalized values.
---
--- This function scales 8-bit integer color components to floating-point values
--- by dividing by 255. It supports converting 1, 2, or 3 values
--- depending on how many arguments are provided.
---
--- @param a number First value to convert (required)
--- @param b number|nil Second value to convert (optional)
--- @param c number|nil Third value to convert (optional)
--- @return number|number,number|number,number,number The normalized value(s)
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
    assert(type(a) == "number", "a must be a number")
    assert(b == nil or type(b) == "number", "b must be a number or nil")
    assert(c == nil or type(c) == "number", "c must be a number or nil")
    return scale(1 / 255.0, a, b, c)
end

return from_8bit