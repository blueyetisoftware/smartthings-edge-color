local Format = require 'color.format'
local rgb_to_xy = require 'color.rgb_to_xy'
local cct_to_rgb = require 'color.cct_to_rgb'

--- Converts correlated color temperature (CCT) to CIE 1931 xyY color coordinates.
---
--- This function converts a correlated color temperature in Kelvin to CIE 1931 xyY
--- color coordinates by first converting CCT to RGB using the cct_to_rgb function,
--- then converting RGB to xyY using the rgb_to_xy function. The resulting xyY coordinates
--- represent the color appearance of a blackbody radiator at the given temperature.
---
--- @param cct number correlated color temperature in Kelvin, range [1000,40000]
--- @return number, number, number equivalent x, y, Y coordinates where x,y are in [0,1] and Y=1
---
--- @raise error if cct is not a number
--- @raise error if cct is outside the valid range [1000,40000]
---
--- @usage
--- local x, y, Y = cct_to_xy(2700)  -- Warm white (incandescent bulb)
--- local x, y, Y = cct_to_xy(6500)  -- Daylight white (D65)
local function cct_to_xy(cct)
    assert(type(cct) == "number", "cct must be a number")
    return Format.clampXYY(rgb_to_xy(cct_to_rgb(cct)))
end

return cct_to_xy