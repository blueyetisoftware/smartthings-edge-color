local st_utils = require 'st.utils'

--- Safely converts HSV (Hue/Saturation/Value) to CIE 1931 xyY coordinates with 16-bit output.
---
--- This function is a pass-through to the SmartThings Edge st_utils.safe_hsv_to_xy function,
--- which converts HSV color values to CIE 1931 xyY coordinates. The function handles nil inputs
--- gracefully by using default values, and returns coordinates scaled to 16-bit integer range.
---
--- @param hue number|nil Hue component in the range [0,100]%, defaults to 0 if nil
--- @param saturation number|nil Saturation component in the range [0,100]%, defaults to 0 if nil
--- @return number, number, number CIE 1931 xyY coordinates (x, y, Y) scaled to 16-bit range [0x0000, 0xFFFF]
---
--- @usage
--- local x, y, Y = safe_hsv_to_xy(0, 100)    -- Red color coordinates
--- local x, y, Y = safe_hsv_to_xy(nil, nil)  -- Default values used
local function fn(hue, saturation)
  return st_utils.safe_hsv_to_xy(hue, saturation)
end
return fn
