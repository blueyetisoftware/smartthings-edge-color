local st_utils = require 'st.utils'

--- Converts RGB color values to HSL (Hue/Saturation/Lightness) color values.
---
--- This function is a pass-through to the SmartThings Edge st_utils.rgb_to_hsl function,
--- which converts RGB color space values to HSL. The conversion handles the standard
--- RGB to HSL transformation algorithm.
---
--- @param red number Red component in the range [0,255]
--- @param green number Green component in the range [0,255]
--- @param blue number Blue component in the range [0,255]
--- @return number, number, number HSL color values (hue, saturation, lightness)
---   with hue and saturation in [0,100]%, lightness in [0,100]%
---
--- @usage
--- local h, s, l = rgb_to_hsl(255, 0, 0)    -- Pure red: 0, 100, 50
--- local h, s, l = rgb_to_hsl(0, 255, 0)    -- Pure green: 120, 100, 50
--- local h, s, l = rgb_to_hsl(0, 0, 255)    -- Pure blue: 240, 100, 50
local function fn(red, green, blue)
  return st_utils.rgb_to_hsl(red, green, blue)
end
return fn
