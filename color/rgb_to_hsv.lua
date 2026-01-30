local st_utils = require 'st.utils'
local clamp_rgb = require 'color.format.rgb'.clamp_rgb
--- Converts Red/Green/Blue to Hue/Saturation/Value
---
--- This function converts RGB color values to HSV (Hue, Saturation, Value) color space.
--- The conversion uses the SmartThings Edge st_utils.rgb_to_hsv function.
---
--- @param red number red in range [0,1]
--- @param green number green in range [0,1]
--- @param blue number blue in range [0,1]
--- @return number hue Hue component in range [0,1] (0 = red, 1/3 = green, 2/3 = blue)
--- @return number saturation Saturation component in range [0,1] (0 = grayscale, 1 = fully saturated)
--- @return number value Value (brightness) component in range [0,1] (0 = black, 1 = full brightness)
---
--- @raise error if red, green, or blue are not numbers
---
--- @usage
--- local h, s, v = rgb_to_hsv(1, 0, 0)    -- Pure red: 0, 1, 1
--- local h, s, v = rgb_to_hsv(0, 1, 0)    -- Pure green: 0.333, 1, 1
--- local h, s, v = rgb_to_hsv(0, 0, 1)    -- Pure blue: 0.667, 1, 1
local function fn(red, green, blue)
    assert(type(red) == "number", "red must be a number")
    assert(type(green) == "number", "green must be a number")
    assert(type(blue) == "number", "blue must be a number")
    return st_utils.rgb_to_hsv(clamp_rgb(red, green, blue))
end
return fn
