local scale = require 'color.scale'

--- Converts percentage values [0,100] to normalized values [0,1].
---
--- This function scales percentage color components to floating-point values
--- in the range [0,1] by dividing by 100. It supports converting 1, 2, or 3 values
--- depending on how many arguments are provided.
---
--- @param a number First percentage value to convert in range [0,100] (required)
--- @param b number Second percentage value to convert in range [0,100] (optional)
--- @param c number Third percentage value to convert in range [0,100] (optional)
--- @return number|number,number|number,number,number The normalized value(s) in range [0,1]
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
    return scale(1 / 100.0, a, b, c)
end

return from_percentage