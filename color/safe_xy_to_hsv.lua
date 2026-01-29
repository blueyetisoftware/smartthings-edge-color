local st_utils = require 'st.utils'

--- Safely converts CIE 1931 xyY coordinates to HSV (Hue/Saturation/Value) with percentage output.
---
--- This function is a pass-through to the SmartThings Edge st_utils.safe_xy_to_hsv function,
--- which converts CIE 1931 xyY coordinates to HSV color values. The function handles nil inputs
--- gracefully by using default values, and returns HSV components as percentages.
---
--- @param x number|nil x chromaticity coordinate in 16-bit range [0x0000, 0xFFFF], defaults to 0 if nil
--- @param y number|nil y chromaticity coordinate in 16-bit range [0x0000, 0xFFFF], defaults to 0 if nil
--- @param Y number|nil Y luminance coordinate in 16-bit range [0x0000, 0xFFFF], defaults to 1 if nil
--- @return number, number HSV color values (hue, saturation) in the range [0,100]%
---
--- @usage
--- local h, s = safe_xy_to_hsv(0xA000, 0x4000, 0x8000)    -- Color coordinates
--- local h, s = safe_xy_to_hsv(nil, nil, nil)             -- Default values used
local function fn(x, y, Y)
  return st_utils.safe_xy_to_hsv(x, y, Y)
end
return fn
