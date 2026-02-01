--- Hsl ↔ Rgb conversion module
--- Contains all format variants for this conversion pair
---
--- This module provides industry-standard color space conversions following
--- established algorithms and best practices for computer graphics.

local hsl_to_rgb = require 'color.core.hsl_to_rgb'
local rgb_to_hsl = require 'color.core.rgb_to_hsl'
local rgb_to_rgb8 = require 'color.format.rgb'.rgb_to_rgb8
local rgb_to_hex24 = require 'color.format.rgb'.rgb_to_hex24
local rgb_to_rgb100 = require 'color.format.rgb'.rgb_to_rgb100
local hsl360_to_hsl = require 'color.format.hsl'.hsl360_to_hsl
local rgb8_to_rgb = require 'color.format.rgb'.rgb8_to_rgb
local hsl_to_hsl360 = require 'color.format.hsl'.hsl_to_hsl360
local hex24_to_rgb = require 'color.format.rgb'.hex24_to_rgb
local rgb100_to_rgb = require 'color.format.rgb'.rgb100_to_rgb

local M = {}

-- hsl to rgb8
function M.hsl_to_rgb8(
    hue, saturation, lightness
)
    return rgb_to_rgb8(hsl_to_rgb(hue, saturation, lightness))
end

-- hsl to hex24
function M.hsl_to_hex24(
    hue, saturation, lightness
)
    return rgb_to_hex24(hsl_to_rgb(hue, saturation, lightness))
end

-- hsl to rgb100
function M.hsl_to_rgb100(
    hue, saturation, lightness
)
    return rgb_to_rgb100(hsl_to_rgb(hue, saturation, lightness))
end

-- hsl360 to rgb8
function M.hsl360_to_rgb8(
    hue_degrees, saturation, lightness
)
    return rgb_to_rgb8(hsl_to_rgb(hsl360_to_hsl(hue_degrees, saturation, lightness)))
end

-- hsl360 to hex24
function M.hsl360_to_hex24(
    hue_degrees, saturation, lightness
)
    return rgb_to_hex24(hsl_to_rgb(hsl360_to_hsl(hue_degrees, saturation, lightness)))
end

-- hsl360 to rgb100
function M.hsl360_to_rgb100(
    hue_degrees, saturation, lightness
)
    return rgb_to_rgb100(hsl_to_rgb(hsl360_to_hsl(hue_degrees, saturation, lightness)))
end

-- rgb8 to hsl
function M.rgb8_to_hsl(
    red, green, blue
)
    return rgb_to_hsl(rgb8_to_rgb(red, green, blue))
end

-- rgb8 to hsl360
function M.rgb8_to_hsl360(
    red, green, blue
)
    return hsl_to_hsl360(rgb_to_hsl(rgb8_to_rgb(red, green, blue)))
end

-- hex24 to hsl
function M.hex24_to_hsl(
    hex
)
    return rgb_to_hsl(hex24_to_rgb(hex))
end

-- hex24 to hsl360
function M.hex24_to_hsl360(
    hex
)
    return hsl_to_hsl360(rgb_to_hsl(hex24_to_rgb(hex)))
end

-- rgb100 to hsl
function M.rgb100_to_hsl(
    red, green, blue
)
    return rgb_to_hsl(rgb100_to_rgb(red, green, blue))
end

-- rgb100 to hsl360
function M.rgb100_to_hsl360(
    red, green, blue
)
    return hsl_to_hsl360(rgb_to_hsl(rgb100_to_rgb(red, green, blue)))
end

-- hsl to rgb (normalized pass-through)
function M.hsl_to_rgb(
    hue, saturation, lightness
)
    return hsl_to_rgb(hue, saturation, lightness)
end

-- rgb to hsl (normalized pass-through)
function M.rgb_to_hsl(
    red, green, blue
)
    return rgb_to_hsl(red, green, blue)
end

return M