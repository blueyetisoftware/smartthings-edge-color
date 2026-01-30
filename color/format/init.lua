--- Color format conversion utilities
---
--- This module provides scaling and clamping functions for converting between
--- different color value representations (normalized, 8-bit, 16-bit, percentage, degrees).

local st_utils = require 'st.utils'
local RGB = require 'color.format.rgb'
local Hue = require 'color.format.hue'
local XYY = require 'color.format.xyy'
local CCT = require 'color.format.cct'

return {
    -- RGB functions
    clamp_rgb8 = RGB.clamp_rgb8,
    clamp_rgb16 = RGB.clamp_rgb16,
    clamp_rgb100 = RGB.clamp_rgb100,
    clamp_rgb = RGB.clamp_rgb,
    round_rgb = RGB.round_rgb,
    to_rgb8 = RGB.to_rgb8,
    from_rgb8 = RGB.from_rgb8,
    to_rgb16 = RGB.to_rgb16,
    from_rgb16 = RGB.from_rgb16,
    to_rgb100 = RGB.to_rgb100,
    from_rgb100 = RGB.from_rgb100,

    -- xyY functions
    clamp_xyy = XYY.clamp_xyy,

    -- Hue functions
    clamp_hff = Hue.clamp_hff,
    clamp_hdff = Hue.clamp_hdff,
    to_hdff = Hue.to_hdff,
    from_hdff = Hue.from_hdff,

    -- Kelvin functions
    clamp_kelvin = CCT.clamp_kelvin,
    clamp_mired = CCT.clamp_mired,
    to_mired = CCT.to_mired,
    to_kelvin = CCT.to_kelvin,

    -- Generic scaling functions
    to8 = function(a, b, c)
        if c then
            return st_utils.round(a * 255), st_utils.round(b * 255), st_utils.round(c * 255)
        elseif b then
            return st_utils.round(a * 255), st_utils.round(b * 255)
        else
            return st_utils.round(a * 255)
        end
    end,
    to16 = function(a, b, c)
        if c then
            return st_utils.round(a * 65535), st_utils.round(b * 65535), st_utils.round(c * 65535)
        elseif b then
            return st_utils.round(a * 65535), st_utils.round(b * 65535)
        else
            return st_utils.round(a * 65535)
        end
    end,
    toPct = function(a, b, c)
        if c then
            return a * 100, b * 100, c * 100
        elseif b then
            return a * 100, b * 100
        else
            return a * 100
        end
    end
}