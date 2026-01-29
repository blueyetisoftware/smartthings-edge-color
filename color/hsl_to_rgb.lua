local st_utils = require 'st.utils'

--- Converts HSL (Hue/Saturation/Lightness) color values to RGB color values.
---
--- This function is a pass-through to the SmartThings Edge st_utils.hsl_to_rgb function,
--- which converts HSL color space values to RGB. The conversion handles the standard
--- HSL to RGB transformation algorithm.
---
--- @param hue number Hue component in the range [0,100]% (percentage)
--- @param saturation number Saturation component in the range [0,100]% (percentage)
--- @param lightness number|nil Lightness component in the range [0,100]% (percentage), defaults to 50 if nil
--- @return number, number, number RGB color values (red, green, blue) in the range [0,255]
---
--- @usage
--- local r, g, b = hsl_to_rgb(0, 100, 50)    -- Pure red: 255, 0, 0
--- local r, g, b = hsl_to_rgb(120, 100, 50)  -- Pure green: 0, 255, 0
--- local r, g, b = hsl_to_rgb(240, 100, 50)  -- Pure blue: 0, 0, 255
local function fn(hue, saturation, lightness)
  return st_utils.hsl_to_rgb(hue, saturation, lightness)
end
return fn
