local scale = require 'color.scale'

--- Converts percentage values to normalized values.
---
--- This function scales percentage color components to floating-point values
--- by dividing by 100. It supports converting 1, 2, or 3 values
--- depending on how many arguments are provided.
---
--- @param a number First percentage value to convert (required)
--- @param b number|nil Second percentage value to convert (optional)
--- @param c number|nil Third percentage value to convert (optional)
--- @return number|number,number|number,number,number The normalized value(s)
---
--- @raise error if a is nil
---
--- @usage
--- local saturation = from_percentage(50)      -- returns 0.5
--- local h, s = from_percentage(120, 80)       -- returns 1.2, 0.8
--- local r, g, b = from_percentage(100, 50, 0) -- returns 1.0, 0.5, 0.0
---
--- @see to_percentage
local function from_percentage(a, b, c)
    assert(type(a) == "number", "a must be a number")
    assert(b == nil or type(b) == "number", "b must be a number or nil")
    assert(c == nil or type(c) == "number", "c must be a number or nil")
    return scale(1 / 100.0, a, b, c)
end

return from_percentage