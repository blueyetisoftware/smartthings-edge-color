local st_utils = require 'st.utils'
local hsv_to_rgb = require 'color.hsv_to_rgb'
local rgb_to_xy = require 'color.rgb_to_xy'

--- Converts HSV (Hue, Saturation, Value) to CIE 1931 xyY color coordinates.
---
--- This function converts HSV color coordinates to CIE 1931 xyY color coordinates
--- by first converting HSV to RGB using the hsv_to_rgb function, then converting
--- RGB to xyY using the rgb_to_xy function. The V (value) component defaults to 1.0
--- if not provided.
---
--- @param h number hue component in range [0,1]
--- @param s number saturation component in range [0,1]
--- @param v number|nil value component in range [0,1], defaults to 1.0
--- @return number, number, number equivalent x, y, Y coordinates where x,y are in [0,1] and Y=1
---
--- @raise error if h, s, or v are not numbers
--- @raise error if h, s, or v are outside valid ranges
---
--- @usage
--- local x, y, Y = hsv_to_xy(0.1, 0.8, 1.0)  -- Warm color
--- local x, y, Y = hsv_to_xy(0.6, 0.2, 0.8)  -- Cool color
local function hsv_to_xy(h, s, v)
    assert(type(h) == "number", "h must be a number")
    assert(type(s) == "number", "s must be a number")
    assert(v == nil or type(v) == "number", "v must be a number or nil")
    h = st_utils.clamp_value(h, 0, 1)
    s = st_utils.clamp_value(s, 0, 1)
    if v ~= nil then
        v = st_utils.clamp_value(v, 0, 1)
    end
    return rgb_to_xy(hsv_to_rgb(h, s, v or 1))
end

return hsv_to_xy