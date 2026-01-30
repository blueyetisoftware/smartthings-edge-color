--- Hue format conversion utilities
---
--- This module provides clamping and conversion functions for hue values.

local st_utils = require 'st.utils'

--- Wraps hue (first arg) modulo 1, clamps saturation/value (other args) to [0, 1].
---
--- @param h number Hue in normalized range [0,1) (wrapped)
--- @param s number Saturation/value/lightness (0-1)
--- @param v number Value/lightness (0-1)
--- @return number,number,number Wrapped/clamped values
local function clampHFF(h, s, v)
    return h % 1,
           st_utils.clamp_value(s, 0, 1),
           st_utils.clamp_value(v, 0, 1)
end

--- Wraps degrees hue (first arg) modulo 360, clamps saturation/value (other args) to [0, 1].
---
--- @param h number Hue in degrees [0,360) (wrapped)
--- @param s number Saturation/value/lightness (0-1)
--- @param v number Value/lightness (0-1)
--- @return number,number,number Wrapped/clamped values
local function clampHdFF(h, s, v)
    return h % 360,
           st_utils.clamp_value(s, 0, 1),
           st_utils.clamp_value(v, 0, 1)
end

--- Converts normalized HSL/HSV to degrees-based HSL/HSV.
---
--- @param h number Hue in normalized range [0,1]
--- @param s number Saturation/value/lightness [0,1]
--- @param v number Value/lightness [0,1]
--- @return number,number,number Degrees-based HSL/HSV values
local function toHdFF(h, s, v)
    return clampHdFF(h * 360, s, v)
end

--- Converts degrees-based HSL/HSV to normalized HSL/HSV.
---
--- @param h number Hue in degrees [0,360]
--- @param s number Saturation/value/lightness [0,1]
--- @param v number Value/lightness [0,1]
--- @return number,number,number Normalized HSL/HSV values
local function fromHdFF(h, s, v)
    return clampHFF(h / 360, s, v)
end

return {
    clampHFF = clampHFF,
    clampHdFF = clampHdFF,
    toHdFF = toHdFF,
    fromHdFF = fromHdFF
}