local scale = require 'color.scale'

--- Converts normalized values [0,1] to percentage values [0,100].
---
--- This function scales floating-point color components in the range [0,1] to
--- percentage values in the range [0,100] by multiplying by 100. It supports
--- converting 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param a number First normalized value to convert in range [0,1] (required)
--- @param b number Second normalized value to convert in range [0,1] (optional)
--- @param c number Third normalized value to convert in range [0,1] (optional)
--- @return number|number,number|number,number,number The percentage value(s) in range [0,100]
---
--- @raise error if a is nil
---
--- @usage
--- local saturation = to_percentage(0.5)      -- returns 50
--- local h, s = to_percentage(0.333, 0.8)     -- returns 33.3, 80
--- local r, g, b = to_percentage(1.0, 0.5, 0) -- returns 100, 50, 0
---
--- @see from_percentage
local function to_percentage(a, b, c)
    return scale(100.0, a, b, c)
end

return to_percentage