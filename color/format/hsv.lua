--- HSV format conversion utilities
---
--- This module provides clamping and conversion functions for HSV color values.

local st_utils = require 'st.utils'

--- Wraps hue (first arg) modulo 1, clamps saturation/value (other args) to [0, 1].
---
--- @param h number Hue in normalized range [0,1) (wrapped)
--- @param s number Saturation (0-1)
--- @param v number Value (0-1)
--- @return number,number,number Wrapped/clamped HSV values
local function clamp_hsv(h, s, v)
    return h % 1,
           st_utils.clamp_value(s, 0, 1),
           st_utils.clamp_value(v, 0, 1)
end

--- Wraps degrees hue (first arg) modulo 360, clamps saturation/value (other args) to [0, 1].
---
--- @param h number Hue in degrees [0,360) (wrapped)
--- @param s number Saturation (0-1)
--- @param v number Value (0-1)
--- @return number,number,number Wrapped/clamped HSV values
local function clamp_hsv360(h, s, v)
    return h % 360,
           st_utils.clamp_value(s, 0, 1),
           st_utils.clamp_value(v, 0, 1)
end

--- Converts normalized HSV to degrees-based HSV.
---
--- @param h number Hue in normalized range [0,1]
--- @param s number Saturation [0,1]
--- @param v number Value [0,1]
--- @return number,number,number Degrees-based HSV values
local function to_hsv360(h, s, v)
    return clamp_hsv360(h * 360, s, v)
end

--- Converts degrees-based HSV to normalized HSV.
---
--- @param h number Hue in degrees [0,360]
--- @param s number Saturation [0,1]
--- @param v number Value [0,1]
--- @return number,number,number Normalized HSV values
local function from_hsv360(h, s, v)
    return clamp_hsv(h / 360, s, v)
end

return {
    clamp_hsv = clamp_hsv,
    clamp_hsv360 = clamp_hsv360,
    to_hsv360 = to_hsv360,
    from_hsv360 = from_hsv360
}