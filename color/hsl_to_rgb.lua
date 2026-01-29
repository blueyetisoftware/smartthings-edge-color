local Clamp = require 'color.clamp'

--- Converts HSL (Hue/Saturation/Lightness) color values to RGB color values.
---
--- This function implements standard HSL to RGB conversion. Note that this differs
--- from st_utils.hsl_to_rgb which has an API inconsistency (expects HSL in percentages
--- [0,100] and returns 8-bit RGB [0,255]) and a bug where it returns white for all
--- achromatic colors (saturation = 0) regardless of lightness.
---
--- @param hue number Hue component (any real number, circular - wraps every 1.0, 0 = red, 1 = red again)
--- @param saturation number Saturation component in the range [0,1] (normalized)
--- @param lightness number|nil Lightness component in the range [0,1] (normalized), defaults to 0.5 if nil
--- @return number, number, number RGB color values (red, green, blue) in the range [0,1]
---
--- @raise error if hue or saturation are not numbers
---
--- @usage
--- local r, g, b = hsl_to_rgb(0, 1, 0.5)    -- Pure red: 1, 0, 0
--- local r, g, b = hsl_to_rgb(0.333, 1, 0.5)  -- Pure green: 0, 1, 0
--- local r, g, b = hsl_to_rgb(0.667, 1, 0.5)  -- Pure blue: 0, 0, 1
local function fn(hue, saturation, lightness)
    assert(type(hue) == "number", "hue must be a number")
    assert(type(saturation) == "number", "saturation must be a number")
    assert(lightness == nil or type(lightness) == "number", "lightness must be a number or nil")
    hue = Clamp.clampHue(hue)
    saturation = Clamp.clampF(saturation)
    lightness = Clamp.clampF(lightness or 0.5)
    -- Handle grayscale case
    if saturation <= 0 then
        return lightness, lightness, lightness
    end
    -- Standard HSL to RGB conversion
    local chroma = (1 - math.abs(2 * lightness - 1)) * saturation
    local hue_prime = hue * 6
    local x = chroma * (1 - math.abs(hue_prime % 2 - 1))
    local m = lightness - chroma / 2
    local r, g, b
    if hue_prime < 1 then
        r, g, b = chroma, x, 0
    elseif hue_prime < 2 then
        r, g, b = x, chroma, 0
    elseif hue_prime < 3 then
        r, g, b = 0, chroma, x
    elseif hue_prime < 4 then
        r, g, b = 0, x, chroma
    elseif hue_prime < 5 then
        r, g, b = x, 0, chroma
    else
        r, g, b = chroma, 0, x
    end
    return r + m, g + m, b + m
end
return fn
