--- Cct ↔ Xyy conversion module
--- Contains all format variants for this conversion pair
---
--- This module provides industry-standard color space conversions following
--- established algorithms and best practices for computer graphics.
---
--- CCT ↔ xyY conversions use the CIE daylight illuminant series
--- approximation for correlated color temperature calculations.
---
--- Standards: CIE daylight illuminants, Planckian locus approximation
--- Algorithm: Polynomial approximation of daylight chromaticity

local cctk_to_rgb = require 'color.core.cctk_to_rgb'
local rgb_to_xyy = require 'color.core.rgb_to_xyy'
local cctk_to_cctm = require 'color.format.cct'.cctk_to_cctm
local xyy_to_rgb = require 'color.core.xyy_to_rgb'
local rgb_to_cctk = require 'color.core.rgb_to_cctk'
local cctm_to_cctk = require 'color.format.cct'.cctm_to_cctk

local M = {}

-- cctk to xyy
function M.cctk_to_xyy(
    kelvin
)
    return rgb_to_xyy(cctk_to_rgb(kelvin))
end

-- cctm to xyy
function M.cctm_to_xyy(
    mired
)
    return rgb_to_xyy(cctk_to_rgb(cctk_to_cctm(mired)))
end

-- xyy to cctk
function M.xyy_to_cctk(
    x, y, Y
)
    return rgb_to_cctk(xyy_to_rgb(x, y, Y))
end

-- xyy to cctm
function M.xyy_to_cctm(
    x, y, Y
)
    return cctm_to_cctk(rgb_to_cctk(xyy_to_rgb(x, y, Y)))
end

return M