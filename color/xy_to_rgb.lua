local st_utils = require 'st.utils'

--- Converts CIE 1931 xyY color space coordinates to RGB color values.
---
--- This function is a pass-through to the SmartThings Edge st_utils.xy_to_rgb function,
--- which converts CIE 1931 xyY color space coordinates to RGB color space values.
--- The conversion handles the standard xyY to RGB transformation using the sRGB color space primaries.
---
--- @param x number x chromaticity coordinate (typically in [0,1])
--- @param y number y chromaticity coordinate (typically in [0,1])
--- @param Y number Y luminance coordinate (typically in [0,1])
--- @return number, number, number RGB color values (red, green, blue) in the range [0,1]
---
--- @usage
--- local r, g, b = xy_to_rgb(0.64, 0.33, 0.21)    -- Red: approximately 1, 0, 0
--- local r, g, b = xy_to_rgb(0.30, 0.60, 0.72)    -- Green: approximately 0, 1, 0
--- local r, g, b = xy_to_rgb(0.15, 0.06, 0.07)    -- Blue: approximately 0, 0, 1
local function fn(x, y, Y)
  return st_utils.xy_to_rgb(x, y, Y)
end
return fn
