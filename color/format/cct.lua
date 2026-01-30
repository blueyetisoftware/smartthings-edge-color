--- CCT format conversion utilities
---
--- This module provides clamping functions for CCT (Correlated Color Temperature) values
--- in both Kelvin and Mired scales.

local st_utils = require 'st.utils'

--- Clamps values to Kelvin temperature range [1000, 40000].
---
--- @param a number Value to clamp
--- @return number Clamped Kelvin value
local function clampKelvin(a)
    return st_utils.clamp_value(a, 1000, 40000)
end

--- Clamps values to Mired range [25, 1000].
---
--- @param a number Value to clamp
--- @return number Clamped Mired value
local function clampMired(a)
    return st_utils.clamp_value(a, 25, 1000)
end

return {
    clampKelvin = clampKelvin,
    clampMired = clampMired
}