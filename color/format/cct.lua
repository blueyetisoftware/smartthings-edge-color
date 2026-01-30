--- CCT format conversion utilities
---
--- This module provides clamping and scale conversion functions for CCT (Correlated Color Temperature) values
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

--- Converts color temperature from Kelvin to Mired (micro reciprocal degrees).
---
--- Mired is a unit used in lighting to express color temperature. It is defined
--- as 1,000,000 divided by the color temperature in Kelvin. Lower mired values
--- correspond to warmer (lower temperature) light, while higher mired values
--- correspond to cooler (higher temperature) light.
---
--- @param kelvin number Color temperature in Kelvin
--- @return integer Color temperature in Mired, rounded to nearest integer
---
--- @usage
--- local mired = toMired(3000)  -- returns 333 (warm white)
--- local mired = toMired(6500)  -- returns 154 (daylight white)
---
--- @see toKelvin
local function toMired(kelvin)
    return st_utils.round(1000000 / clampKelvin(kelvin))  -- mired = 1,000,000 / kelvin (micro reciprocal degrees)
end

--- Converts color temperature from Mired (micro reciprocal degrees) to Kelvin.
---
--- This is the inverse operation of toMired. Mired values are converted
--- back to Kelvin by dividing 1,000,000 by the mired value.
---
--- @param mired number Color temperature in Mired
--- @return integer Color temperature in Kelvin, rounded to nearest integer
---
--- @usage
--- local kelvin = toKelvin(333)  -- returns 3000 (warm white)
--- local kelvin = toKelvin(154)  -- returns 6494 (approximately daylight white)
---
--- @see toMired
local function toKelvin(mired)
    return st_utils.round(1000000 / clampMired(mired))  -- kelvin = 1,000,000 / mired (micro reciprocal degrees)
end

return {
    clampKelvin = clampKelvin,
    clampMired = clampMired,
    toMired = toMired,
    toKelvin = toKelvin
}