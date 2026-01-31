--- Rgb ↔ Cct conversion module
--- Contains all format variants for this conversion pair
---
--- This module provides industry-standard color space conversions following
--- established algorithms and best practices for computer graphics.
---
--- RGB ↔ CCT conversions use optimized lookup table interpolation
--- with golden section search for accurate color temperature calculation.
--- Provides high accuracy across the full 1000K-30000K range.
---
--- Standards: CIE 1931 color space, correlated color temperature
--- Algorithm: Lookup table interpolation + golden section search
--- Accuracy: < 10K error across standard illuminant range

local rgb_to_cctk = require 'color.core.rgb_to_cctk'
local cctk_to_rgb = require 'color.core.cctk_to_rgb'
local from_rgb8 = require 'color.format.rgb'.rgb8_to_rgb
local to_cctk = require 'color.format.cct'.cctk_to_cctm
local to_cctm = require 'color.format.cct'.cctm_to_cctk
local from_hex24 = require 'color.format.rgb'.hex24_to_rgb
local from_rgb100 = require 'color.format.rgb'.rgb100_to_rgb
local from_cctk = require 'color.format.cct'.cctm_to_cctk
local to_rgb8 = require 'color.format.rgb'.rgb_to_rgb8
local to_hex24 = require 'color.format.rgb'.rgb_to_hex24
local to_rgb100 = require 'color.format.rgb'.rgb_to_rgb100
local from_cctm = require 'color.format.cct'.cctk_to_cctm

local M = {}

-- rgb8 to cctk
function M.rgb8_to_cctk(
    red, green, blue
)
    return to_cctk(rgb_to_cct(from_rgb8(red, green, blue)))
end

-- rgb8 to cctm
function M.rgb8_to_cctm(
    red, green, blue
)
    return to_cctm(rgb_to_cct(from_rgb8(red, green, blue)))
end

-- hex24 to cctk
function M.hex24_to_cctk(
    red, green, blue
)
    return to_cctk(rgb_to_cct(from_hex24(red, green, blue)))
end

-- hex24 to cctm
function M.hex24_to_cctm(
    red, green, blue
)
    return to_cctm(rgb_to_cct(from_hex24(red, green, blue)))
end

-- rgb100 to cctk
function M.rgb100_to_cctk(
    red, green, blue
)
    return to_cctk(rgb_to_cct(from_rgb100(red, green, blue)))
end

-- rgb100 to cctm
function M.rgb100_to_cctm(
    red, green, blue
)
    return to_cctm(rgb_to_cct(from_rgb100(red, green, blue)))
end

-- cctk to rgb8
function M.cctk_to_rgb8(
    kelvin
)
    return to_rgb8(cct_to_rgb(from_cctk(kelvin)))
end

-- cctk to hex24
function M.cctk_to_hex24(
    kelvin
)
    return to_hex24(cct_to_rgb(from_cctk(kelvin)))
end

-- cctk to rgb100
function M.cctk_to_rgb100(
    kelvin
)
    return to_rgb100(cct_to_rgb(from_cctk(kelvin)))
end

-- cctm to rgb8
function M.cctm_to_rgb8(
    mired
)
    return to_rgb8(cct_to_rgb(from_cctm(mired)))
end

-- cctm to hex24
function M.cctm_to_hex24(
    mired
)
    return to_hex24(cct_to_rgb(from_cctm(mired)))
end

-- cctm to rgb100
function M.cctm_to_rgb100(
    mired
)
    return to_rgb100(cct_to_rgb(from_cctm(mired)))
end

-- rgb to cct (normalized pass-through)
function M.rgb_to_cct(
    red, green, blue
)
    return rgb_to_cctk(red, green, blue)
end

-- cct to rgb (normalized pass-through)
function M.cct_to_rgb(
    kelvin
)
    return cctk_to_rgb(kelvin)
end

return M