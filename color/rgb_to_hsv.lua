local st_utils = require 'st.utils'
--- Converts Red/Green/Blue to Hue/Saturation
---
--- @param red number red in range [0,1]
--- @param green number green in range [0,1]
--- @param blue number blue in range [0,1]
--- @return number, number, number equivalent hue, saturation, level with each value in range [0,1]
--- @function rgb_to_hsv
local function fn(red, green, blue)
  return st_utils.rgb_to_hsv(red, green, blue)
end
return fn
