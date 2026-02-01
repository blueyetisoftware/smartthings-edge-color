--- Hsv ↔ Xyy conversion module
--- Contains all format variants for this conversion pair
---
--- This module provides industry-standard color space conversions following
--- established algorithms and best practices for computer graphics.
---
--- HSV ↔ xyY conversions chain through RGB intermediate representation
--- using standard computer graphics algorithms and CIE 1931 color matching functions.
---
--- Standards: Computer graphics standard (Foley et al.), CIE 1931, sRGB (IEC 61966-2-1)
--- Algorithm: Component-wise maximum/minimum calculations → Linear transformation with gamma correction

local hsv_to_rgb = require 'color.core.hsv_to_rgb'
local rgb_to_xyy = require 'color.core.rgb_to_xyy'
local hsv360_to_hsv = require 'color.format.hsv'.hsv360_to_hsv
local xyy_to_rgb = require 'color.core.xyy_to_rgb'
local rgb_to_hsv = require 'color.core.rgb_to_hsv'
local hsv_to_hsv360 = require 'color.format.hsv'.hsv_to_hsv360

local M = {}

-- hsv to xyy
function M.hsv_to_xyy(
    hue, saturation, value
)
    return rgb_to_xyy(hsv_to_rgb(hue, saturation, value))
end

-- hsv360 to xyy
function M.hsv360_to_xyy(
    hue_degrees, saturation, value
)
    return rgb_to_xyy(hsv_to_rgb(hsv360_to_hsv(hue_degrees, saturation, value)))
end

-- xyy to hsv
function M.xyy_to_hsv(
    x, y, Y
)
    return rgb_to_hsv(xyy_to_rgb(x, y, Y))
end

-- xyy to hsv360
function M.xyy_to_hsv360(
    x, y, Y
)
    return hsv_to_hsv360(rgb_to_hsv(xyy_to_rgb(x, y, Y)))
end

return M