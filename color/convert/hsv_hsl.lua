--- Hsv ↔ Hsl conversion module
--- Contains all format variants for this conversion pair
---
--- This module provides industry-standard color space conversions following
--- established algorithms and best practices for computer graphics.
---
--- HSV ↔ HSL conversions use direct mathematical relationships
--- avoiding RGB intermediate steps for optimal performance.
---
--- Formulas: L = V × (1 - S/2), V = L + S × min(L, 1-L)
--- Algorithm: Direct component transformation (H identical, S/V adjusted)

local hsv_to_hsl = require 'color.core.hsv_to_hsl'
local hsl_to_hsl360 = require 'color.format.hsl'.hsl_to_hsl360
local hsv360_to_hsv = require 'color.format.hsv'.hsv360_to_hsv
local hsl_to_hsv = require 'color.core.hsl_to_hsv'
local hsv_to_hsv360 = require 'color.format.hsv'.hsv_to_hsv360
local hsl360_to_hsl = require 'color.format.hsl'.hsl360_to_hsl

local M = {}

-- hsv to hsl
function M.hsv_to_hsl(
    hue, saturation, value
)
    return hsv_to_hsl(hue, saturation, value)
end

-- hsv to hsl360
function M.hsv_to_hsl360(
    hue, saturation, value
)
    return hsl_to_hsl360(hsv_to_hsl(hue, saturation, value))
end

-- hsv360 to hsl
function M.hsv360_to_hsl(
    hue_degrees, saturation, value
)
    return hsv_to_hsl(hsv360_to_hsv(hue_degrees, saturation, value))
end

-- hsv360 to hsl360
function M.hsv360_to_hsl360(
    hue_degrees, saturation, value
)
    return hsl_to_hsl360(hsv_to_hsl(hsv360_to_hsv(hue_degrees, saturation, value)))
end

-- hsl to hsv
function M.hsl_to_hsv(
    hue, saturation, lightness
)
    return hsl_to_hsv(hue, saturation, lightness)
end

-- hsl to hsv360
function M.hsl_to_hsv360(
    hue, saturation, lightness
)
    return hsv_to_hsv360(hsl_to_hsv(hue, saturation, lightness))
end

-- hsl360 to hsv
function M.hsl360_to_hsv(
    hue_degrees, saturation, lightness
)
    return hsl_to_hsv(hsl360_to_hsl(hue_degrees, saturation, lightness))
end

-- hsl360 to hsv360
function M.hsl360_to_hsv360(
    hue_degrees, saturation, lightness
)
    return hsv_to_hsv360(hsl_to_hsv(hsl360_to_hsl(hue_degrees, saturation, lightness)))
end

return M