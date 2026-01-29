local st_utils = require 'st.utils'
local hsv_to_xy = require 'color.hsv_to_xy'
local xy_to_cct = require 'color.xy_to_cct'

--- Converts HSV (Hue, Saturation, Value) to correlated color temperature (CCT).
---
--- This function converts HSV color coordinates to correlated color temperature in Kelvin
--- by first converting HSV to CIE 1931 xyY coordinates using the hsv_to_xy function,
--- then converting xyY to CCT using the xy_to_cct function. The V (value) component
--- defaults to 1.0 if not provided.
---
--- @param h number hue component in range [0,1]
--- @param s number saturation component in range [0,1]
--- @param v number|nil value component in range [0,1], defaults to 1.0
--- @return number correlated color temperature in Kelvin, range [1000,40000]
---
--- @raise error if h, s, or v are not numbers
--- @raise error if h, s, or v are outside valid ranges
---
--- @usage
--- local cct = hsv_to_cct(0.1, 0.8, 1.0)  -- Warm color temperature
--- local cct = hsv_to_cct(0.6, 0.2, 0.8)  -- Cool color temperature
local function hsv_to_cct(h, s, v)
    assert(type(h) == "number", "h must be a number")
    assert(type(s) == "number", "s must be a number")
    assert(v == nil or type(v) == "number", "v must be a number or nil")
    h = st_utils.clamp_value(h, 0, 1)
    s = st_utils.clamp_value(s, 0, 1)
    if v ~= nil then
        v = st_utils.clamp_value(v, 0, 1)
    end
    return xy_to_cct(hsv_to_xy(h, s, v or 1))
end

return hsv_to_cct