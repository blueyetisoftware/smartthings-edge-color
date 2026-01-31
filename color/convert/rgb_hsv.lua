--- Rgb ↔ Hsv conversion module
--- Contains all format variants for this conversion pair
---
--- This module provides industry-standard color space conversions following
--- established algorithms and best practices for computer graphics.
---
--- RGB ↔ HSV conversions follow the standard computer graphics
--- algorithm with proper handling of achromatic colors.
---
--- Standards: Computer graphics standard (Foley et al.)
--- Algorithm: Component-wise maximum/minimum calculations

local rgb_to_hsv = require 'color.core.rgb_to_hsv'
local hsv_to_rgb = require 'color.core.hsv_to_rgb'
local rgb8_to_rgb = require 'color.format.rgb'.rgb8_to_rgb
local hsv_to_hsv360 = require 'color.format.hsv'.hsv_to_hsv360
local hex24_to_rgb = require 'color.format.rgb'.hex24_to_rgb
local rgb100_to_rgb = require 'color.format.rgb'.rgb100_to_rgb
local rgb_to_rgb8 = require 'color.format.rgb'.rgb_to_rgb8
local rgb_to_hex24 = require 'color.format.rgb'.rgb_to_hex24
local rgb_to_rgb100 = require 'color.format.rgb'.rgb_to_rgb100
local hsv360_to_hsv = require 'color.format.hsv'.hsv360_to_hsv

local M = {}

-- rgb8 to hsv
function M.rgb8_to_hsv(
    red, green, blue
)
    return rgb_to_hsv(rgb8_to_rgb(red, green, blue))
end

-- rgb8 to hsv360
function M.rgb8_to_hsv360(
    red, green, blue
)
    return hsv_to_hsv360(rgb_to_hsv(rgb8_to_rgb(red, green, blue)))
end

-- hex24 to hsv
function M.hex24_to_hsv(
    hex
)
    return rgb_to_hsv(hex24_to_rgb(hex))
end

-- hex24 to hsv360
function M.hex24_to_hsv360(
    hex
)
    return hsv_to_hsv360(rgb_to_hsv(hex24_to_rgb(hex)))
end

-- rgb100 to hsv
function M.rgb100_to_hsv(
    red, green, blue
)
    return rgb_to_hsv(rgb100_to_rgb(red, green, blue))
end

-- rgb100 to hsv360
function M.rgb100_to_hsv360(
    red, green, blue
)
    return hsv_to_hsv360(rgb_to_hsv(rgb100_to_rgb(red, green, blue)))
end

-- hsv to rgb8
function M.hsv_to_rgb8(
    hue, saturation, value
)
    return rgb_to_rgb8(hsv_to_rgb(hue, saturation, value))
end

-- hsv to hex24
function M.hsv_to_hex24(
    hue, saturation, value
)
    return rgb_to_hex24(hsv_to_rgb(hue, saturation, value))
end

-- hsv to rgb100
function M.hsv_to_rgb100(
    hue, saturation, value
)
    return rgb_to_rgb100(hsv_to_rgb(hue, saturation, value))
end

-- hsv360 to rgb8
function M.hsv360_to_rgb8(
    hue_degrees, saturation, value
)
    return rgb_to_rgb8(hsv_to_rgb(hsv360_to_hsv(hue_degrees, saturation, value)))
end

-- hsv360 to hex24
function M.hsv360_to_hex24(
    hue_degrees, saturation, value
)
    return rgb_to_hex24(hsv_to_rgb(hsv360_to_hsv(hue_degrees, saturation, value)))
end

-- hsv360 to rgb100
function M.hsv360_to_rgb100(
    hue_degrees, saturation, value
)
    return rgb_to_rgb100(hsv_to_rgb(hsv360_to_hsv(hue_degrees, saturation, value)))
end

-- rgb to hsv (normalized pass-through)
function M.rgb_to_hsv(
    red, green, blue
)
    return rgb_to_hsv(red, green, blue)
end

-- hsv to rgb (normalized pass-through)
function M.hsv_to_rgb(
    hue, saturation, value
)
    return hsv_to_rgb(hue, saturation, value)
end

return M