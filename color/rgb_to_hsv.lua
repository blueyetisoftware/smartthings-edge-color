local st_utils = require 'st.utils'
--- Converts Red/Green/Blue to Hue/Saturation
---
--- @param red number red in range [0,1]
--- @param green number green in range [0,1]
--- @param blue number blue in range [0,1]
--- @return number, number, number equivalent hue, saturation, level with each value in range [0,1]
--- @function rgb_to_hsv
local function fn(red, green, blue)
    assert(type(red) == "number", "red must be a number")
    assert(type(green) == "number", "green must be a number")
    assert(type(blue) == "number", "blue must be a number")
    red = st_utils.clamp_value(red, 0, 1)
    green = st_utils.clamp_value(green, 0, 1)
    blue = st_utils.clamp_value(blue, 0, 1)
    return st_utils.rgb_to_hsv(red, green, blue)
end
return fn
