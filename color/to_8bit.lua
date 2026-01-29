local st_utils = require 'st.utils'

--- Converts normalized color values [0,1] to 8-bit integer values [0,255].
---
--- This function scales floating-point color components in the range [0,1] to
--- 8-bit integer values in the range [0,255] by multiplying by 255 and rounding.
--- It supports converting 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param a number First value to convert in range [0,1] (required)
--- @param b number Second value to convert in range [0,1] (optional)
--- @param c number Third value to convert in range [0,1] (optional)
--- @return number|number,number|number,number,number The converted 8-bit value(s) in range [0,255]
---
--- @raise error if a is nil
---
--- @usage
--- local r8 = to_8bit(1.0)                    -- returns 255
--- local r8, g8 = to_8bit(0.5, 0.7)          -- returns 128, 179
--- local r8, g8, b8 = to_8bit(0.1, 0.2, 0.3) -- returns 26, 51, 77
local function to_8bit(a, b, c)
    assert(a ~= nil)
    if c ~= nil then
        return st_utils.round(a * 255.0), st_utils.round(b * 255.0), st_utils.round(c * 255.0)
    elseif b ~= nil then
        return st_utils.round(a * 255.0), st_utils.round(b * 255.0)
    else
        return st_utils.round(a * 255.0)
    end
end

return to_8bit