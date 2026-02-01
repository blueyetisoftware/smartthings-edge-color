--- Cct ↔ Hsl conversion module
--- Contains all format variants for this conversion pair
---
--- This module provides industry-standard color space conversions following
--- established algorithms and best practices for computer graphics.
---
--- CCT ↔ HSL conversions chain through RGB intermediate representation
--- using optimized lookup table interpolation for CCT and standard
--- lightness calculations for HSL.
---
--- Standards: CIE 1931 color space, correlated color temperature,
--- CSS Color Module Level 4
--- Algorithm: Lookup table interpolation + golden section search →
--- Lightness = (max + min)/2
--- Accuracy: < 10K error for CCT, standard HSL precision

local cctk_to_rgb = require 'color.core.cctk_to_rgb'
local rgb_to_hsl = require 'color.core.rgb_to_hsl'
local hsl_to_hsl360 = require 'color.format.hsl'.hsl_to_hsl360
local cctk_to_cctm = require 'color.format.cct'.cctk_to_cctm
local hsl_to_rgb = require 'color.core.hsl_to_rgb'
local rgb_to_cctk = require 'color.core.rgb_to_cctk'
local cctm_to_cctk = require 'color.format.cct'.cctm_to_cctk
local hsl360_to_hsl = require 'color.format.hsl'.hsl360_to_hsl

local M = {}

-- cctk to hsl
function M.cctk_to_hsl(
    kelvin
)
    return rgb_to_hsl(cctk_to_rgb(kelvin))
end

-- cctk to hsl360
function M.cctk_to_hsl360(
    kelvin
)
    return hsl_to_hsl360(rgb_to_hsl(cctk_to_rgb(kelvin)))
end

-- cctm to hsl
function M.cctm_to_hsl(
    mired
)
    return rgb_to_hsl(cctk_to_rgb(cctk_to_cctm(mired)))
end

-- cctm to hsl360
function M.cctm_to_hsl360(
    mired
)
    return hsl_to_hsl360(rgb_to_hsl(cctk_to_rgb(cctk_to_cctm(mired))))
end

-- hsl to cctk
function M.hsl_to_cctk(
    hue, saturation, lightness
)
    return rgb_to_cctk(hsl_to_rgb(hue, saturation, lightness))
end

-- hsl to cctm
function M.hsl_to_cctm(
    hue, saturation, lightness
)
    return cctm_to_cctk(rgb_to_cctk(hsl_to_rgb(hue, saturation, lightness)))
end

-- hsl360 to cctk
function M.hsl360_to_cctk(
    hue_degrees, saturation, lightness
)
    return rgb_to_cctk(hsl_to_rgb(hsl360_to_hsl(hue_degrees, saturation, lightness)))
end

-- hsl360 to cctm
function M.hsl360_to_cctm(
    hue_degrees, saturation, lightness
)
    return cctm_to_cctk(rgb_to_cctk(hsl_to_rgb(hsl360_to_hsl(hue_degrees, saturation, lightness))))
end

return M