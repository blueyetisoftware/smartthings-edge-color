local Color = {}
local Format = require 'color.format'

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
Color.format = Format
Color.to_rgb8 = Format.toRGB8
Color.from_rgb8 = Format.fromRGB8
Color.to_rgb16 = Format.toRGB16
Color.from_rgb16 = Format.fromRGB16
Color.to_rgb100 = Format.toRGB100
Color.from_rgb100 = Format.fromRGB100
Color.kelvin_to_mired = Format.toMired
Color.mired_to_kelvin = Format.toKelvin
Color.kelvin_to_mirek = Format.toMired
Color.mirek_to_kelvin = Format.toKelvin

return Color