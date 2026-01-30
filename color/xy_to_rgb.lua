local st_utils = require 'st.utils'
local clamp_xyy = require 'color.format.xyy'.clamp_xyy

--- Converts CIE 1931 xyY color space coordinates to RGB color values.
---
--- This function is a pass-through to the SmartThings Edge st_utils.xy_to_rgb function,
--- which converts CIE 1931 xyY color space coordinates to RGB color space values.
--- The conversion handles the standard xyY to RGB transformation using the sRGB color space primaries.
---
--- @param x number x chromaticity coordinate (typically in [0,1])
--- @param y number y chromaticity coordinate (typically in [0,1])
--- @param Y number|nil Y luminance coordinate (typically in [0,1]), defaults to 1.0 for full brightness
--- @return number, number, number RGB color values (red, green, blue) in the range [0,1]
---
--- @raise error if x or y are not numbers, or if Y is provided and not a number
---
--- @usage
--- local r, g, b = xy_to_rgb(0.64, 0.33, 0.21)    -- Red with specific luminance
--- local r, g, b = xy_to_rgb(0.64, 0.33)          -- Red at full brightness (Y=1.0)
--- local r, g, b = xy_to_rgb(0.30, 0.60, 0.72)    -- Green with specific luminance
--- local r, g, b = xy_to_rgb(0.15, 0.06, 0.07)    -- Blue with specific luminance
local function fn(x, y, Y)
    assert(type(x) == "number", "x must be a number")
    assert(type(y) == "number", "y must be a number")
    assert(Y == nil or type(Y) == "number", "Y must be a number or nil")
    return st_utils.xy_to_rgb(clamp_xyy(x, y, Y or 1))
end
return fn
