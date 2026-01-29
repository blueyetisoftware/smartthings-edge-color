local st_utils = require 'st.utils'

--- Converts normalized color values [0,1] to 16-bit integer values [0,65535].
---
--- This function scales floating-point color components in the range [0,1] to
--- 16-bit integer values in the range [0,65535] by multiplying by 65535 and rounding.
--- It supports converting 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param a number First value to convert in range [0,1] (required)
--- @param b number|nil Second value to convert in range [0,1] (optional)
--- @param c number|nil Third value to convert in range [0,1] (optional)
--- @return number|number,number|number,number,number The converted 16-bit value(s) in range [0,65535]
---
--- @raise error if a is nil
---
--- @usage
--- local x16 = to_16bit(1.0)                    -- returns 65535
--- local x16, y16 = to_16bit(0.5, 0.7)          -- returns 32768, 45875
--- local x16, y16, Y16 = to_16bit(0.1, 0.2, 0.3) -- returns 6554, 13107, 19661
local function to_16bit(a, b, c)
    assert(a ~= nil and type(a) == "number" and a >= 0 and a <= 1, "a must be a number in range [0, 1]")
    assert(b == nil or (type(b) == "number" and b >= 0 and b <= 1), "b must be a number in range [0, 1] or nil")
    assert(c == nil or (type(c) == "number" and c >= 0 and c <= 1), "c must be a number in range [0, 1] or nil")
    if c ~= nil then
        return st_utils.round(a * 65535.0), st_utils.round(b * 65535.0), st_utils.round(c * 65535.0)
    elseif b ~= nil then
        return st_utils.round(a * 65535.0), st_utils.round(b * 65535.0)
    else
        return st_utils.round(a * 65535.0)
    end
end

return to_16bit