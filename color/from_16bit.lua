local scale = require 'color.scale'

--- Converts 16-bit integer values to normalized color values.
---
--- This function scales 16-bit integer color components to
--- normalized floating-point values by dividing by 65535.
--- It supports converting 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param a number First value to convert (required)
--- @param b number|nil Second value to convert (optional)
--- @param c number|nil Third value to convert (optional)
--- @return number|number,number|number,number,number The converted normalized value(s)
---
--- @raise error if a is nil
---
--- @usage
--- local x = from_16bit(65535)                    -- returns 1.0
--- local x, y = from_16bit(32768, 45875)          -- returns ~0.5, ~0.7
--- local x, y, Y = from_16bit(6554, 13107, 19661) -- returns ~0.1, ~0.2, ~0.3
local function from_16bit(a, b, c)
    assert(type(a) == "number", "a must be a number")
    assert(b == nil or type(b) == "number", "b must be a number or nil")
    assert(c == nil or type(c) == "number", "c must be a number or nil")
    return scale(1 / 65535.0, a, b, c)
end

return from_16bit