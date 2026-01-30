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
    clampRGB8 = RGB.clampRGB8,
    clampRGB16 = RGB.clampRGB16,
    clampRGB100 = RGB.clampRGB100,
    clampRGB = RGB.clampRGB,
    roundRGB = RGB.roundRGB,
    toRGB8 = RGB.toRGB8,
    fromRGB8 = RGB.fromRGB8,
    toRGB16 = RGB.toRGB16,
    fromRGB16 = RGB.fromRGB16,
    toRGB100 = RGB.toRGB100,
    fromRGB100 = RGB.fromRGB100,

    -- xyY functions
    clampXYY = XYY.clampXYY,

    -- Hue functions
    clampHFF = Hue.clampHFF,
    clampHdFF = Hue.clampHdFF,
    toHdFF = Hue.toHdFF,
    fromHdFF = Hue.fromHdFF,

    -- Kelvin functions
    clampKelvin = CCT.clampKelvin,
    clampMired = CCT.clampMired,
    toMired = CCT.toMired,
    toKelvin = CCT.toKelvin,

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