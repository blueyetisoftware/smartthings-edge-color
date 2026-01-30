local st_utils = require 'st.utils'
local Clamp = require 'color.clamp'

--- Converts floating-point color values to 8-bit integer values.
---
--- This function scales floating-point color components by multiplying by 255 and rounding.
--- It supports converting 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param a number First value to convert (required)
--- @param b number|nil Second value to convert (optional)
--- @param c number|nil Third value to convert (optional)
--- @return integer|integer,integer|integer,integer,integer The converted 8-bit integer value(s) in range [0,255]
---
--- @raise error if a is nil
---
--- @usage
--- local r8 = to_8bit(1.0)                    -- returns 255
--- local r8, g8 = to_8bit(0.5, 0.7)          -- returns 128, 179
--- local r8, g8, b8 = to_8bit(0.1, 0.2, 0.3) -- returns 26, 51, 77
local function to_8bit(a, b, c)
    assert(type(a) == "number", "a must be a number")
    assert(b == nil or type(b) == "number", "b must be a number or nil")
    assert(c == nil or type(c) == "number", "c must be a number or nil")
    if c ~= nil then
        return Clamp.clamp8(a * 255.0, b * 255.0, c * 255.0)
    elseif b ~= nil then
        return Clamp.clamp8(a * 255.0, b * 255.0)
    else
        return Clamp.clamp8(a * 255.0)
    end
end

return to_8bit