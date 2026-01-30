local clampXYY = require 'color.format.xyy'.clampXYY
local xy_to_rgb = require 'color.xy_to_rgb'
local rgb_to_hsv = require 'color.rgb_to_hsv'

--- Converts CIE 1931 xyY color coordinates to HSV (Hue, Saturation, Value).
---
--- This function converts CIE 1931 xyY color coordinates to HSV by first converting
--- xyY to RGB using the xy_to_rgb function, then converting RGB to HSV using the
--- rgb_to_hsv function. The Y (luminance) component defaults to 1.0 if not provided.
---
--- @param x number x coordinate in CIE 1931 color space, range [0,1]
--- @param y number y coordinate in CIE 1931 color space, range [0,1]
--- @param Y number|nil luminance (Y) component, range [0,1], defaults to 1.0
--- @return number, number, number equivalent hue, saturation, value with each component in range [0,1]
---
--- @raise error if x or y are not numbers
--- @raise error if x, y, or Y are outside valid ranges
---
--- @usage
--- local h, s, v = xy_to_hsv(0.3127, 0.3290, 0.8)  -- D65 white point with 80% luminance
--- local h, s, v = xy_to_hsv(0.6400, 0.3300, 1.0)  -- sRGB red primary
local function xy_to_hsv(x, y, Y)
    assert(type(x) == "number", "x must be a number")
    assert(type(y) == "number", "y must be a number")
    assert(Y == nil or type(Y) == "number", "Y must be a number or nil")
    x, y, Y = clampXYY(x, y, Y or 1)
    return rgb_to_hsv(xy_to_rgb(x, y, Y))
end

return xy_to_hsv