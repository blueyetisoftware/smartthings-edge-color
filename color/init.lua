local Color = {}
local rgb_format = require 'color.format.rgb'
local cct_format = require 'color.format.cct'

Color.rgb_to_cct = require 'color.rgb_to_cct'
Color.cct_to_rgb = require 'color.cct_to_rgb'
Color.xy_to_cct = require 'color.xy_to_cct'
Color.cct_to_xy = require 'color.cct_to_xy'
Color.xy_to_hsv = require 'color.xy_to_hsv'
Color.hsv_to_xy = require 'color.hsv_to_xy'
Color.cct_to_hsv = require 'color.cct_to_hsv'
Color.hsv_to_cct = require 'color.hsv_to_cct'
Color.rgb_to_hsv = require 'color.rgb_to_hsv'
Color.hsv_to_rgb = require 'color.hsv_to_rgb'
Color.rgb_to_xy = require 'color.rgb_to_xy'
Color.xy_to_rgb = require 'color.xy_to_rgb'
Color.rgb_to_hsl = require 'color.rgb_to_hsl'
Color.hsl_to_rgb = require 'color.hsl_to_rgb'
Color.to_rgb8 = rgb_format.to_rgb8
Color.from_rgb8 = rgb_format.from_rgb8
Color.to_rgb16 = rgb_format.to_rgb16
Color.from_rgb16 = rgb_format.from_rgb16
Color.to_rgb100 = rgb_format.to_rgb100
Color.from_rgb100 = rgb_format.from_rgb100
Color.kelvin_to_mired = cct_format.to_mired
Color.mired_to_kelvin = cct_format.to_kelvin
Color.kelvin_to_mirek = cct_format.to_mired
Color.mirek_to_kelvin = cct_format.to_kelvin

-- Algorithm constants for self-documenting code
Color.RGB_TO_CCT_DEFAULT_FAST = true

return Color