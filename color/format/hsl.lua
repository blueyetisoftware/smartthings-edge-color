--- HSL format conversion utilities
---
--- This module provides clamping and conversion functions for HSL color values.

local st_utils = require 'st.utils'

--- Wraps hue (first arg) modulo 1, clamps saturation/lightness (other args) to [0, 1].
---
--- @param h number Hue in normalized range [0,1) (wrapped)
--- @param s number Saturation (0-1)
--- @param l number Lightness (0-1)
--- @return number,number,number Wrapped/clamped HSL values
local function clamp_hsl(h, s, l)
    return h % 1,
           st_utils.clamp_value(s, 0, 1),
           st_utils.clamp_value(l, 0, 1)
end

--- Wraps degrees hue (first arg) modulo 360, clamps saturation/lightness (other args) to [0, 1].
---
--- @param h number Hue in degrees [0,360) (wrapped)
--- @param s number Saturation (0-1)
--- @param l number Lightness (0-1)
--- @return number,number,number Wrapped/clamped HSL values
local function clamp_hsl360(h, s, l)
    return h % 360,
           st_utils.clamp_value(s, 0, 1),
           st_utils.clamp_value(l, 0, 1)
end

--- Converts normalized HSL to degrees-based HSL.
---
--- @param h number Hue in normalized range [0,1]
--- @param s number Saturation [0,1]
--- @param l number Lightness [0,1]
--- @return number,number,number Degrees-based HSL values
local function to_hsl360(h, s, l)
    return clamp_hsl360(h * 360, s, l)
end

--- Converts degrees-based HSL to normalized HSL.
---
--- @param h number Hue in degrees [0,360]
--- @param s number Saturation [0,1]
--- @param l number Lightness [0,1]
--- @return number,number,number Normalized HSL values
local function from_hsl360(h, s, l)
    return clamp_hsl(h / 360, s, l)
end

return {
    clamp_hsl = clamp_hsl,
    clamp_hsl360 = clamp_hsl360,
    to_hsl360 = to_hsl360,
    from_hsl360 = from_hsl360
}