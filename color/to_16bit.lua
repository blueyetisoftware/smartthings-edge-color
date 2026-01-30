local st_utils = require 'st.utils'
local Clamp = require 'color.clamp'

--- Converts floating-point color values to 16-bit integer values.
---
--- This function scales floating-point color components by multiplying by 65535 and rounding.
--- It supports converting 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param a number First value to convert (required)
--- @param b number|nil Second value to convert (optional)
--- @param c number|nil Third value to convert (optional)
--- @return integer|integer,integer|integer,integer,integer The converted 16-bit integer value(s) in range [0,65535]
---
--- @raise error if a is nil
---
--- @usage
--- local x16 = to_16bit(1.0)                    -- returns 65535
--- local x16, y16 = to_16bit(0.5, 0.7)          -- returns 32768, 45875
--- local x16, y16, Y16 = to_16bit(0.1, 0.2, 0.3) -- returns 6554, 13107, 19661
local function to_16bit(a, b, c)
    assert(type(a) == "number", "a must be a number")
    assert(b == nil or type(b) == "number", "b must be a number or nil")
    assert(c == nil or type(c) == "number", "c must be a number or nil")
    if c ~= nil then
        return Clamp.clamp16(a * 65535.0, b * 65535.0, c * 65535.0)
    elseif b ~= nil then
        return Clamp.clamp16(a * 65535.0, b * 65535.0)
    else
        return Clamp.clamp16(a * 65535.0)
    end
end

return to_16bit