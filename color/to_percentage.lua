local scale = require 'color.scale'
local st_utils = require 'st.utils'

--- Converts normalized values to percentage values.
---
--- This function scales floating-point color components by multiplying by 100. It supports
--- converting 1, 2, or 3 values depending on how many arguments are provided.
---
--- @param a number First value to convert (required)
--- @param b number|nil Second value to convert (optional)
--- @param c number|nil Third value to convert (optional)
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
    assert(type(a) == "number", "a must be a number")
    assert(b == nil or type(b) == "number", "b must be a number or nil")
    assert(c == nil or type(c) == "number", "c must be a number or nil")
    if c ~= nil then
        return st_utils.clamp_value(a * 100.0, 0, 100), st_utils.clamp_value(b * 100.0, 0, 100), st_utils.clamp_value(c * 100.0, 0, 100)
    elseif b ~= nil then
        return st_utils.clamp_value(a * 100.0, 0, 100), st_utils.clamp_value(b * 100.0, 0, 100)
    else
        return st_utils.clamp_value(a * 100.0, 0, 100)
    end
end

return to_percentage