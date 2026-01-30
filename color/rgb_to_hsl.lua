local Clamp = require 'color.clamp'

--- Converts RGB color values to HSL (Hue/Saturation/Lightness) color values.
---
--- This function implements standard RGB to HSL conversion. Note that this differs
--- from st_utils.rgb_to_hsl which expects 8-bit RGB input [0,255] and returns HSL
--- in percentage format [0,100], while our implementation uses normalized [0,1] ranges
--- for consistency with the rest of the library.
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
    red, green, blue = Clamp.clampF(red, green, blue)
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
    return hue, saturation, lightness
end
return fn
