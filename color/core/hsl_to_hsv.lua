--- @internal
--- Converts HSL (Hue/Saturation/Lightness) color values directly to HSV (Hue/Saturation/Value).
---
--- This function provides direct HSL to HSV conversion without going through RGB,
--- which is more efficient since hue is identical between the two spaces.
---
--- Key differences between HSL and HSV:
--- - Hue (H): Identical between HSL and HSV
--- - Saturation (S): Different definitions - HSL saturation is relative to lightness,
---   HSV saturation is relative to value. Saturation must be recalculated.
--- - Brightness: HSL uses Lightness (L), HSV uses Value (V)
---
--- Relationship between HSL Lightness and HSV Value:
--- - For achromatic colors (S=0): V = L (identical)
--- - For chromatic colors (S>0): V = L + S × min(L, 1-L)
---   Value is always ≥ Lightness, with maximum difference at L=0.5 with high saturation
---
local st_utils = require 'st.utils'

--- @param hue number Hue component (any real number, circular - wraps every 1.0)
--- @param saturation number HSL saturation component in the range [0,1]
--- @param lightness number Lightness component in the range [0,1]
--- @return number,number,number HSV color values (hue, saturation, value)
local function hsl_to_hsv(hue, saturation, lightness)
    -- Handle achromatic colors (no saturation)
    if saturation == 0 then
        return hue, 0, lightness  -- Value = Lightness when S = 0
    end

    -- Calculate value
    -- V = L + S * min(L, 1-L)
    local value = lightness + saturation * math.min(lightness, 1 - lightness)

    -- Calculate HSV saturation
    -- S_HSV = 2 * (1 - L/V) if V != 0
    local s
    if value == 0 then
        s = 0  -- Avoid division by zero
    else
        s = 2 * (1 - lightness / value)
    end

    -- Clamp to valid range
    s = st_utils.clamp_value(s, 0, 1)

    return hue, s, value
end

return hsl_to_hsv