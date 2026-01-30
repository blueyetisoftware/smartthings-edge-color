--- CCT format conversion utilities
---
--- This module provides clamping and scale conversion functions for CCT (Correlated Color Temperature) values
--- in both Kelvin and Mired scales.

local st_utils = require 'st.utils'

--- Clamps values to SmartThings colorTemperature capability range [1, 30000].
---
--- This matches the Kelvin range expected by SmartThings Edge color temperature
--- capabilities. Values outside this range are clamped to the valid boundaries.
---
--- @param a number Value to clamp
--- @return number Clamped Kelvin value compatible with SmartThings
local function clamp_kelvin(a)
    return st_utils.clamp_value(a, 1, 30000)
end

--- Clamps values to Mired range [33, 1000000].
---
--- This corresponds to the full SmartThings Kelvin range [1, 30000].
--- In practice, most lighting applications use 150-500 mireds (2000K-6500K).
---
--- @param a number Value to clamp
--- @return number Clamped Mired value
local function clamp_mired(a)
    return st_utils.clamp_value(a, 33, 1000000)
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
--- local mired = to_mired(3000)  -- returns 333 (warm white)
--- local mired = to_mired(6500)  -- returns 154 (daylight white)
---
--- @see to_kelvin
local function to_mired(kelvin)
    return st_utils.round(1000000 / clamp_kelvin(kelvin))  -- mired = 1,000,000 / kelvin (micro reciprocal degrees)
end

--- Converts color temperature from Mired (micro reciprocal degrees) to Kelvin.
---
--- This is the inverse operation of to_mired. Mired values are converted
--- back to Kelvin by dividing 1,000,000 by the mired value.
---
--- @param mired number Color temperature in Mired
--- @return integer Color temperature in Kelvin, rounded to nearest integer
---
--- @usage
--- local kelvin = to_kelvin(333)  -- returns 3000 (warm white)
--- local kelvin = to_kelvin(154)  -- returns 6494 (approximately daylight white)
---
--- @see to_mired
local function to_kelvin(mired)
    return st_utils.round(1000000 / clamp_mired(mired))  -- kelvin = 1,000,000 / mired (micro reciprocal degrees)
end

return {
    clamp_kelvin = clamp_kelvin,
    clamp_mired = clamp_mired,
    to_mired = to_mired,
    to_kelvin = to_kelvin
}