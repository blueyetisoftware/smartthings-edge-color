--- Hsl ↔ Xyy conversion module
--- Contains all format variants for this conversion pair
---
--- This module provides industry-standard color space conversions following
--- established algorithms and best practices for computer graphics.
---
--- HSL ↔ xyY conversions chain through RGB intermediate representation
--- using standard lightness calculations and CIE 1931 color matching functions.
---
--- Standards: CSS Color Module Level 4, CIE 1931, sRGB (IEC 61966-2-1)
--- Algorithm: Lightness = (max + min)/2 → Linear transformation with gamma correction

local hsl_to_rgb = require 'color.core.hsl_to_rgb'
local rgb_to_xyy = require 'color.core.rgb_to_xyy'
local hsl360_to_hsl = require 'color.format.hsl'.hsl360_to_hsl
local xyy_to_rgb = require 'color.core.xyy_to_rgb'
local rgb_to_hsl = require 'color.core.rgb_to_hsl'
local hsl_to_hsl360 = require 'color.format.hsl'.hsl_to_hsl360

local M = {}

-- hsl to xyy
function M.hsl_to_xyy(
    hue, saturation, lightness
)
    return rgb_to_xyy(hsl_to_rgb(hue, saturation, lightness))
end

-- hsl360 to xyy
function M.hsl360_to_xyy(
    hue_degrees, saturation, lightness
)
    return rgb_to_xyy(hsl_to_rgb(hsl360_to_hsl(hue_degrees, saturation, lightness)))
end

-- xyy to hsl
function M.xyy_to_hsl(
    x, y, Y
)
    return rgb_to_hsl(xyy_to_rgb(x, y, Y))
end

-- xyy to hsl360
function M.xyy_to_hsl360(
    x, y, Y
)
    return hsl_to_hsl360(rgb_to_hsl(xyy_to_rgb(x, y, Y)))
end

return M