local scale = require 'color.scale'

--- Converts 16-bit integer values [0,65535] to normalized color values [0,1].
---
--- This function scales 16-bit integer color components in the range [0,65535] to
--- normalized floating-point values in the range [0,1] by dividing by 65535.
--- It supports converting 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param a number First value to convert in range [0,65535] (required)
--- @param b number Second value to convert in range [0,65535] (optional)
--- @param c number Third value to convert in range [0,65535] (optional)
--- @return number|number,number|number,number,number The converted normalized value(s) in range [0,1]
---
--- @raise error if a is nil
---
--- @usage
--- local x = from_16bit(65535)                    -- returns 1.0
--- local x, y = from_16bit(32768, 45875)          -- returns 0.5, 0.7
--- local x, y, Y = from_16bit(6554, 13107, 19661) -- returns 0.1, 0.2, 0.3
local function from_16bit(a, b, c)
    return scale(1 / 65535.0, a, b, c)
end

return from_16bit