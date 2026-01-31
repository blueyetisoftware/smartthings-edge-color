--- RGB format conversion utilities
---
--- This module provides scaling, clamping, and rounding functions for RGB color values.

local st_utils = require 'st.utils'

--- Clamps RGB values to 8-bit integer range [0, 255].
---
--- @param r number Red value to clamp
--- @param g number Green value to clamp
--- @param b number Blue value to clamp
--- @return number,number,number Clamped 8-bit RGB values
local function clamp_rgb8(r, g, b)
    return st_utils.clamp_value(r, 0, 255),
           st_utils.clamp_value(g, 0, 255),
           st_utils.clamp_value(b, 0, 255)
end

--- Clamps RGB values to normalized range [0, 1].
---
--- @param r number Red value to clamp
--- @param g number Green value to clamp
--- @param b number Blue value to clamp
--- @return number,number,number Clamped normalized RGB values
local function clamp_rgb(r, g, b)
    return st_utils.clamp_value(r, 0, 1),
           st_utils.clamp_value(g, 0, 1),
           st_utils.clamp_value(b, 0, 1)
end

--- Clamps RGB values to percentage range [0, 100].
---
--- @param r number Red value to clamp
--- @param g number Green value to clamp
--- @param b number Blue value to clamp
--- @return number,number,number Clamped percentage RGB values
local function clamp_rgb100(r, g, b)
    return st_utils.clamp_value(r, 0, 100),
           st_utils.clamp_value(g, 0, 100),
           st_utils.clamp_value(b, 0, 100)
end

--- Rounds RGB values to integers (no scaling, no clamping).
---
--- @param r number Red value to round
--- @param g number Green value to round
--- @param b number Blue value to round
--- @return number,number,number Rounded RGB values
local function round_rgb(r, g, b)
    return st_utils.round(r),
           st_utils.round(g),
           st_utils.round(b)
end

--- Converts normalized RGB values to 8-bit integers (scale, clamp, then round).
---
--- @param r number Red value to convert (0-1)
--- @param g number Green value to convert (0-1)
--- @param b number Blue value to convert (0-1)
--- @return integer,integer,integer Converted 8-bit RGB integer values
local function rgb_to_rgb8(r, g, b)
    return round_rgb(clamp_rgb8(r * 255, g * 255, b * 255))
end

--- Converts 8-bit RGB integers to normalized values.
---
--- @param r8 number Red value to convert (0-255)
--- @param g8 number Green value to convert (0-255)
--- @param b8 number Blue value to convert (0-255)
--- @return number,number,number Converted normalized RGB values
local function rgb8_to_rgb(r8, g8, b8)
    return clamp_rgb(r8 / 255, g8 / 255, b8 / 255)
end

--- Converts normalized RGB values to percentage values [0,100].
---
--- @param r number Red value to convert (0-1)
--- @param g number Green value to convert (0-1)
--- @param b number Blue value to convert (0-1)
--- @return number,number,number Converted percentage RGB values
local function rgb_to_rgb100(r, g, b)
    return clamp_rgb100(r * 100, g * 100, b * 100)
end

--- Converts percentage RGB values [0,100] to normalized values.
---
--- @param r100 number Red value to convert (0-100)
--- @param g100 number Green value to convert (0-100)
--- @param b100 number Blue value to convert (0-100)
--- @return number,number,number Converted normalized RGB values
local function rgb100_to_rgb(r100, g100, b100)
    return clamp_rgb(r100 / 100, g100 / 100, b100 / 100)
end

--- Converts normalized RGB values to hex color integer.
---
--- @param r number Red value to convert (0-1)
--- @param g number Green value to convert (0-1)
--- @param b number Blue value to convert (0-1)
--- @return integer Hex color integer in format 0xRRGGBB
local function rgb_to_hex24(r, g, b)
    local r8, g8, b8 = rgb_to_rgb8(r, g, b)
    return (r8 << 16) | (g8 << 8) | b8
end

--- Converts hex color integer to normalized RGB values.
---
--- @param hex integer Hex color as integer (0xRRGGBB)
--- @return number,number,number Converted normalized RGB values
local function hex24_to_rgb(hex)
    assert(type(hex) == "number", "hex must be a number")
    
    -- Round float to integer if necessary
    hex = st_utils.round(hex)
    
    -- Validate range (0x000000 to 0xFFFFFF)
    assert(hex >= 0 and hex <= 0xFFFFFF, "hex must be in range 0x000000 to 0xFFFFFF")
    
    -- Extract RGB components
    local r8 = (hex >> 16) & 0xFF
    local g8 = (hex >> 8) & 0xFF
    local b8 = hex & 0xFF
    
    return rgb8_to_rgb(r8, g8, b8)
end

return {
    clamp_rgb8 = clamp_rgb8,
    clamp_rgb100 = clamp_rgb100,
    clamp_rgb = clamp_rgb,
    round_rgb = round_rgb,
    rgb_to_rgb8 = rgb_to_rgb8,
    rgb8_to_rgb = rgb8_to_rgb,
    rgb_to_rgb100 = rgb_to_rgb100,
    rgb100_to_rgb = rgb100_to_rgb,
    rgb_to_hex24 = rgb_to_hex24,
    hex24_to_rgb = hex24_to_rgb
}