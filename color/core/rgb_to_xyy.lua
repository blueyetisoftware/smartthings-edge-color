local st_utils = require 'st.utils'
local clamp_rgb = require 'color.format.rgb'.clamp_rgb

--- @internal
--- Converts RGB color values to CIE 1931 xyY color space coordinates.
---
--- This function is a pass-through to the SmartThings Edge st_utils.rgb_to_xy function,
--- which converts RGB color space values to CIE 1931 xyY color space. The conversion
--- handles the standard RGB to xyY transformation using the sRGB color space primaries.
---
--- @param red number Red component in the range [0,1] (normalized)
--- @param green number Green component in the range [0,1] (normalized)
--- @param blue number Blue component in the range [0,1] (normalized)
--- @return number, number, number CIE 1931 xyY coordinates (x, y, Y)
---   where x,y are chromaticity coordinates in [0,1] and Y is luminance in [0,1]
---
--- @raise error if red, green, or blue are not numbers
---
--- @usage
--- local x, y, Y = rgb_to_xyy(1, 0, 0)    -- Red: approximately 0.64, 0.33, 0.21
--- local x, y, Y = rgb_to_xyy(0, 1, 0)    -- Green: approximately 0.30, 0.60, 0.72
--- local x, y, Y = rgb_to_xyy(0, 0, 1)    -- Blue: approximately 0.15, 0.06, 0.07
local function rgb_to_xyy(red, green, blue)
    assert(type(red) == "number", "red must be a number")
    assert(type(green) == "number", "green must be a number")
    assert(type(blue) == "number", "blue must be a number")
    return st_utils.rgb_to_xy(clamp_rgb(red, green, blue))
end

return rgb_to_xyy
