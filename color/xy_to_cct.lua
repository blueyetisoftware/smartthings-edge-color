local Format = require 'color.format'
local xy_to_rgb = require 'color.xy_to_rgb'
local rgb_to_cct = require 'color.rgb_to_cct'

--- Converts CIE 1931 xyY color coordinates to correlated color temperature (CCT).
---
--- This function converts CIE 1931 xyY color coordinates to correlated color temperature
--- in Kelvin by first converting xyY to RGB using the xy_to_rgb function, then converting
--- RGB to CCT using the rgb_to_cct function. The Y (luminance) component defaults to 1.0
--- if not provided.
---
--- @param x number x coordinate in CIE 1931 color space, range [0,1]
--- @param y number y coordinate in CIE 1931 color space, range [0,1]
--- @param Y number|nil luminance (Y) component, range [0,1], defaults to 1.0
--- @return number correlated color temperature in Kelvin, range [1000,40000]
---
--- @raise error if x, y, or Y are not numbers
--- @raise error if x, y, or Y are outside valid ranges
---
--- @usage
--- local cct = xy_to_cct(0.3127, 0.3290, 1.0)  -- D65 white point
--- local cct = xy_to_cct(0.4476, 0.4074, 1.0)  -- A (2856K) illuminant
local function xy_to_cct(x, y, Y)
    assert(type(x) == "number", "x must be a number")
    assert(type(y) == "number", "y must be a number")
    assert(Y == nil or type(Y) == "number", "Y must be a number or nil")
    x, y, Y = Format.clampXYY(x, y, Y or 1)
    return rgb_to_cct(xy_to_rgb(x, y, Y))
end

return xy_to_cct