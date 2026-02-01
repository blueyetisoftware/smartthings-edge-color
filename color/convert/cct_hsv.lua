--- Cct ↔ Hsv conversion module
--- Contains all format variants for this conversion pair
---
--- This module provides industry-standard color space conversions following
--- established algorithms and best practices for computer graphics.
---
--- CCT ↔ HSV conversions chain through RGB intermediate representation
--- using optimized lookup table interpolation for CCT and standard
--- computer graphics algorithms for HSV.
---
--- Standards: CIE 1931 color space, correlated color temperature,
--- computer graphics (Foley et al.)
--- Algorithm: Lookup table interpolation + golden section search →
--- component-wise max/min
--- Accuracy: < 10K error for CCT, standard HSV precision

local cctk_to_rgb = require 'color.core.cctk_to_rgb'
local rgb_to_hsv = require 'color.core.rgb_to_hsv'
local hsv_to_hsv360 = require 'color.format.hsv'.hsv_to_hsv360
local cctk_to_cctm = require 'color.format.cct'.cctk_to_cctm
local hsv_to_rgb = require 'color.core.hsv_to_rgb'
local rgb_to_cctk = require 'color.core.rgb_to_cctk'
local cctm_to_cctk = require 'color.format.cct'.cctm_to_cctk
local hsv360_to_hsv = require 'color.format.hsv'.hsv360_to_hsv

local M = {}

-- cctk to hsv
function M.cctk_to_hsv(
    kelvin
)
    return rgb_to_hsv(cctk_to_rgb(kelvin))
end

-- cctk to hsv360
function M.cctk_to_hsv360(
    kelvin
)
    return hsv_to_hsv360(rgb_to_hsv(cctk_to_rgb(kelvin)))
end

-- cctm to hsv
function M.cctm_to_hsv(
    mired
)
    return rgb_to_hsv(cctk_to_rgb(cctk_to_cctm(mired)))
end

-- cctm to hsv360
function M.cctm_to_hsv360(
    mired
)
    return hsv_to_hsv360(rgb_to_hsv(cctk_to_rgb(cctk_to_cctm(mired))))
end

-- hsv to cctk
function M.hsv_to_cctk(
    hue, saturation, value
)
    return rgb_to_cctk(hsv_to_rgb(hue, saturation, value))
end

-- hsv to cctm
function M.hsv_to_cctm(
    hue, saturation, value
)
    return cctm_to_cctk(rgb_to_cctk(hsv_to_rgb(hue, saturation, value)))
end

-- hsv360 to cctk
function M.hsv360_to_cctk(
    hue_degrees, saturation, value
)
    return rgb_to_cctk(hsv_to_rgb(hsv360_to_hsv(hue_degrees, saturation, value)))
end

-- hsv360 to cctm
function M.hsv360_to_cctm(
    hue_degrees, saturation, value
)
    return cctm_to_cctk(rgb_to_cctk(hsv_to_rgb(hsv360_to_hsv(hue_degrees, saturation, value))))
end

return M