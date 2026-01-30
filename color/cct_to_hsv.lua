local clamp_hff = require 'color.format.hue'.clamp_hff
local cct_to_xy = require 'color.cct_to_xy'
local xy_to_hsv = require 'color.xy_to_hsv'

--- Converts correlated color temperature (CCT) to HSV (Hue, Saturation, Value).
---
--- This function converts a correlated color temperature in Kelvin to HSV color space
--- by first converting CCT to CIE 1931 xyY coordinates using the cct_to_xy function,
--- then converting xyY to HSV using the xy_to_hsv function. The resulting HSV represents
--- the color appearance of a blackbody radiator at the given temperature.
---
--- @param cct number correlated color temperature in Kelvin, range [1,30000]
--- @return number, number, number equivalent hue, saturation, value with each component in range [0,1]
---
--- @raise error if cct is not a number
--- @raise error if cct is outside the valid range [1,30000]
---
--- @usage
--- local h, s, v = cct_to_hsv(2700)  -- Warm white (incandescent bulb)
--- local h, s, v = cct_to_hsv(6500)  -- Daylight white (D65)
local function cct_to_hsv(cct)
    assert(type(cct) == "number", "cct must be a number")
    return clamp_hff(xy_to_hsv(cct_to_xy(cct)))
end

return cct_to_hsv