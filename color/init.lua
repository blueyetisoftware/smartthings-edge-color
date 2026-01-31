--- Color conversion library for SmartThings Edge
--- Provides core color space conversions with robust validation and consistent APIs

local M = {}

-- Core conversion functions
M.rgb_to_hsv = require 'color.core.rgb_to_hsv'
M.rgb_to_hsl = require 'color.core.rgb_to_hsl'
M.rgb_to_cct = require 'color.core.rgb_to_cctk'
M.rgb_to_xyy = require 'color.core.rgb_to_xyy'

M.hsv_to_rgb = require 'color.core.hsv_to_rgb'
M.hsl_to_rgb = require 'color.core.hsl_to_rgb'
M.hsv_to_hsl = require 'color.core.hsv_to_hsl'
M.hsl_to_hsv = require 'color.core.hsl_to_hsv'
M.cct_to_rgb = require 'color.core.cctk_to_rgb'
M.xyy_to_rgb = require 'color.core.xyy_to_rgb'

-- Format conversion modules
M.format = {
    rgb = require 'color.format.rgb',
    hsv = require 'color.format.hsv',
    hsl = require 'color.format.hsl',
    cct = require 'color.format.cct',
    xyy = require 'color.format.xyy'
}

return M