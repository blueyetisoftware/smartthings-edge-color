local st_utils = require 'st.utils'

--- Converts HSV (Hue/Saturation/Value) color values to RGB color values.
---
--- This function is a pass-through to the SmartThings Edge st_utils.hsv_to_rgb function,
--- which converts HSV color space values to RGB. The conversion handles the standard
--- HSV to RGB transformation algorithm.
---
--- @param hue number Hue component in the range [0,1] (normalized)
--- @param saturation number Saturation component in the range [0,1] (normalized)
--- @return number, number, number RGB color values (red, green, blue) in the range [0,1]
---
--- @usage
--- local r, g, b = hsv_to_rgb(0, 1)    -- Pure red: 1, 0, 0
--- local r, g, b = hsv_to_rgb(0.333, 1)  -- Pure green: 0, 1, 0
--- local r, g, b = hsv_to_rgb(0.667, 1)  -- Pure blue: 0, 0, 1
local function fn(hue, saturation)
  return st_utils.hsv_to_rgb(hue, saturation)
end
return fn
