local clamp_rgb = require 'color.format.rgb'.clamp_rgb
local clamp_hsl = require 'color.format.hsl'.clamp_hsl

--- Converts RGB color values to HSL (Hue/Saturation/Lightness) color values.
---
--- This function implements correct, standard RGB to HSL conversion using normalized [0,1] ranges.
--- The SmartThings st_utils.rgb_to_hsl API is problematic:
--- - Inconsistent: expects 8-bit RGB input [0,255] while most color APIs use [0,1]
--- - Inconsistent: returns HSL in percentages [0,100] instead of normalized values
--- - This creates unnecessary format conversions and API confusion
---
--- This implementation provides consistent normalized ranges throughout the color pipeline.
---
--- @param red number Red component in the range [0,1] (normalized)
--- @param green number Green component in the range [0,1] (normalized)
--- @param blue number Blue component in the range [0,1] (normalized)
--- @return number, number, number HSL color values (hue, saturation, lightness)
---   all in the range [0,1] (normalized)
---
--- @raise error if red, green, or blue are not numbers
---
--- @usage
--- local h, s, l = rgb_to_hsl(1, 0, 0)    -- Pure red: 0, 1, 0.5
--- local h, s, l = rgb_to_hsl(0, 1, 0)    -- Pure green: 0.333, 1, 0.5
--- local h, s, l = rgb_to_hsl(0, 0, 1)    -- Pure blue: 0.667, 1, 0.5
local function fn(red, green, blue)
    assert(type(red) == "number", "red must be a number")
    assert(type(green) == "number", "green must be a number")
    assert(type(blue) == "number", "blue must be a number")
    red, green, blue = clamp_rgb(red, green, blue)
    local max = math.max(red, green, blue)
    local min = math.min(red, green, blue)
    local lightness = (max + min) / 2
    if max == min then
        -- Grayscale
        return 0, 0, lightness
    end
    local delta = max - min
    local saturation = delta / (1 - math.abs(2 * lightness - 1))
    local hue
    if max == red then
        hue = ((green - blue) / delta) % 6
    elseif max == green then
        hue = (blue - red) / delta + 2
    else
        hue = (red - green) / delta + 4
    end
    hue = hue / 6
    return clamp_hsl(hue, saturation, lightness)
end
return fn
