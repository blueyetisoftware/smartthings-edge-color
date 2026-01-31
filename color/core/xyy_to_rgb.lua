local clamp_xyy = require 'color.format.xyy'.clamp_xyy
local clamp_rgb = require 'color.format.rgb'.clamp_rgb

--- @internal
--- Converts CIE 1931 xyY color space coordinates to RGB color values.
---
--- This function implements the xyY to RGB conversion using the sRGB color space primaries.
--- It deviates from the SmartThings Edge st_utils.xy_to_rgb implementation to fix multiple bugs:
--- - Division-by-zero when the maximum RGB component is 0 (e.g., for black or certain invalid inputs).
--- - Incomplete XYZ-to-RGB matrix: ST defines only 2 rows but accesses 3, causing runtime errors.
--- The ST version scales RGB values without these checks, leading to crashes.
--- This implementation adds input clamping, validation, and the complete standard matrix for robustness.
---
--- The "magic" numbers (matrices and gamma thresholds) are from the sRGB standard (IEC 61966-2-1),
--- ensuring accurate color conversion for digital displays and LEDs.
---
--- @param x number x chromaticity coordinate (typically in [0,1])
--- @param y number y chromaticity coordinate (typically in [0,1])
--- @param Y number|nil Y luminance coordinate (typically in [0,1]), defaults to 1.0 for full brightness
--- @return number, number, number RGB color values (red, green, blue) in the range [0,1]
---
--- @raise error if x or y are not numbers, or if Y is provided and not a number
---
--- @usage
--- local r, g, b = xyy_to_rgb(0.64, 0.33, 0.21)    -- Red with specific luminance
--- local r, g, b = xyy_to_rgb(0.64, 0.33)          -- Red at full brightness (Y=1.0)
--- local r, g, b = xyy_to_rgb(0.30, 0.60, 0.72)    -- Green with specific luminance
--- local r, g, b = xyy_to_rgb(0.15, 0.06, 0.07)    -- Blue with specific luminance
local function xyy_to_rgb(x, y, Y)
    assert(type(x) == "number", "x must be a number")
    assert(type(y) == "number", "y must be a number")
    assert(Y == nil or type(Y) == "number", "Y must be a number or nil")

    x, y, Y = clamp_xyy(x, y, Y or 1)

    -- Compute XYZ from xyY
    local subexpr = y ~= 0 and (Y / y) or 0
    local X = subexpr * x
    local Z = subexpr * (1.0 - x - y)

    -- XYZ to RGB matrix (sRGB inverse)
    local M = {
        {  3.2404542, -1.5371385, -0.4985314 },
        { -0.9692660,  1.8760108,  0.0415560 },
        {  0.0556434, -0.2040259,  1.0572252 }
    }

    local r = X * M[1][1] + Y * M[1][2] + Z * M[1][3]
    local g = X * M[2][1] + Y * M[2][2] + Z * M[2][3]
    local b = X * M[3][1] + Y * M[3][2] + Z * M[3][3]

    -- Clamp to [0,1] for gamut
    r, g, b = clamp_rgb(r, g, b)

    -- Fix: Check for max_rgb == 0 to avoid division by zero (ST bug)
    local max_rgb = math.max(r, g, b)
    if max_rgb < 1e-10 then  -- Use epsilon for floating-point safety
        return 0, 0, 0
    end

    -- Apply gamma correction (revert to linear)
    local function color_gamma_revert(value)
        return value <= 0.0031308 and 12.92 * value or (1.0 + 0.055) * (value ^ (1.0 / 2.4)) - 0.055
    end

    r = color_gamma_revert(r / max_rgb)
    g = color_gamma_revert(g / max_rgb)
    b = color_gamma_revert(b / max_rgb)

    r, g, b = clamp_rgb(r, g, b)
    return r, g, b
end
return xyy_to_rgb
