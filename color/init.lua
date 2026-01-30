--- Color conversion library for SmartThings Edge
--- Provides core color space conversions with robust validation and consistent APIs

local M = {}

-- Core conversion functions
M.rgb_to_hsv = require 'color.rgb_to_hsv'
M.rgb_to_hsl = require 'color.rgb_to_hsl'
M.rgb_to_cct = require 'color.rgb_to_cct'
M.rgb_to_xyy = require 'color.rgb_to_xyy'

M.hsv_to_rgb = require 'color.hsv_to_rgb'
M.hsl_to_rgb = require 'color.hsl_to_rgb'
M.cct_to_rgb = require 'color.cct_to_rgb'
M.xyy_to_rgb = require 'color.xyy_to_rgb'

-- Format conversion modules
M.format = {
    rgb = require 'color.format.rgb',
    hue = require 'color.format.hue',
    cct = require 'color.format.cct',
    xyy = require 'color.format.xyy'
}

return M