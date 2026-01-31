--- Rgb ↔ Xyy conversion module
--- Contains all format variants for this conversion pair
---
--- This module provides industry-standard color space conversions following
--- established algorithms and best practices for computer graphics.
---
--- RGB ↔ xyY conversions use the sRGB color space primaries and
--- standard CIE 1931 color matching functions.
---
--- Standards: CIE 1931, sRGB (IEC 61966-2-1)
--- Algorithm: Linear transformation with proper gamma correction

local rgb_to_xyy = require 'color.core.rgb_to_xyy'
local xyy_to_rgb = require 'color.core.xyy_to_rgb'
local from_rgb8 = require 'color.format.rgb'.from_rgb8
local from_hex24 = require 'color.format.rgb'.from_hex24
local from_rgb100 = require 'color.format.rgb'.from_rgb100
local to_rgb8 = require 'color.format.rgb'.to_rgb8
local to_hex24 = require 'color.format.rgb'.to_hex24
local to_rgb100 = require 'color.format.rgb'.to_rgb100

local M = {}

-- rgb8 to xyy
function M.rgb8_to_xyy(
    red, green, blue
)
    return rgb_to_xyy(from_rgb8(red, green, blue))
end

-- hex24 to xyy
function M.hex24_to_xyy(
    red, green, blue
)
    return rgb_to_xyy(from_hex24(red, green, blue))
end

-- rgb100 to xyy
function M.rgb100_to_xyy(
    red, green, blue
)
    return rgb_to_xyy(from_rgb100(red, green, blue))
end

-- xyy to rgb8
function M.xyy_to_rgb8(
    x, y, Y
)
    return to_rgb8(xyy_to_rgb(x, y, Y))
end

-- xyy to hex24
function M.xyy_to_hex24(
    x, y, Y
)
    return to_hex24(xyy_to_rgb(x, y, Y))
end

-- xyy to rgb100
function M.xyy_to_rgb100(
    x, y, Y
)
    return to_rgb100(xyy_to_rgb(x, y, Y))
end

-- rgb to xyy (normalized pass-through)
function M.rgb_to_xyy(
    red, green, blue
)
    return rgb_to_xyy(red, green, blue)
end

-- xyy to rgb (normalized pass-through)
function M.xyy_to_rgb(
    x, y, Y
)
    return xyy_to_rgb(x, y, Y)
end

return M