--- General format conversion utilities
---
--- This module provides general clamping functions for normalized values.

local st_utils = require 'st.utils'

--- Clamps a value to normalized float range [0, 1].
---
--- @param a number Value to clamp
--- @return number Clamped value
local function clampF(a)
    return st_utils.clamp_value(a, 0, 1)
end

--- Clamps three values to normalized float range [0, 1].
---
--- @param a number First value to clamp
--- @param b number Second value to clamp
--- @param c number Third value to clamp
--- @return number,number,number Clamped values
local function clampFFF(a, b, c)
    return st_utils.clamp_value(a, 0, 1),
           st_utils.clamp_value(b, 0, 1),
           st_utils.clamp_value(c, 0, 1)
end

return {
    clampF = clampF,
    clampFFF = clampFFF
}