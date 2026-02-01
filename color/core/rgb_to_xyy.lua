local clamp_rgb = require 'color.format.rgb'.clamp_rgb
local clamp_xyy = require 'color.format.xyy'.clamp_xyy

--- @internal
--- Converts RGB color values to CIE 1931 xyY color space coordinates.
---
--- This function implements the RGB to xyY conversion using the sRGB color space primaries.
--- It deviates from the SmartThings Edge st_utils.rgb_to_xy implementation to fix a division-by-zero
--- bug that occurs when X + Y + Z is 0 (e.g., for black RGB inputs).
--- The ST version divides by the sum without checking for zero, which can cause runtime errors.
--- This implementation adds input clamping and validation for robustness.
---
--- The "magic" numbers (matrices and gamma thresholds) are from the sRGB standard (IEC 61966-2-1),
--- ensuring accurate color conversion for digital displays and LEDs.
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

    red, green, blue = clamp_rgb(red, green, blue)

    -- Apply gamma adjustment (to linear)
    local function color_gamma_adjust(value)
        return value > 0.04045 and ((value + 0.055) / (1.0 + 0.055)) ^ 2.4 or value / 12.92
    end

    local r = color_gamma_adjust(red)
    local g = color_gamma_adjust(green)
    local b = color_gamma_adjust(blue)

    -- RGB to XYZ matrix (sRGB)
    local M = {
        { 0.4124564,  0.3575761,  0.1804375 },
        { 0.2126729,  0.7151522,  0.0721750 },
        { 0.0193339,  0.1191920,  0.9503041 }
    }

    local X = r * M[1][1] + g * M[1][2] + b * M[1][3]
    local Y = r * M[2][1] + g * M[2][2] + b * M[2][3]
    local Z = r * M[3][1] + g * M[3][2] + b * M[3][3]

    -- Fix: Check for X + Y + Z == 0 to avoid division by zero (ST bug)
    local sum = X + Y + Z
    if sum < 1e-10 then  -- Use epsilon for floating-point safety
        return 0, 0, 0
    end

    local x = X / sum
    local y = Y / sum

    x, y, Y = clamp_xyy(x, y, Y)
    return x, y, Y
end

return rgb_to_xyy
