--- @internal
--- Converts HSV (Hue/Saturation/Value) color values directly to HSL (Hue/Saturation/Lightness).
---
--- This function provides direct HSV to HSL conversion without going through RGB,
--- which is more efficient since hue is identical between the two spaces.
---
--- Key differences between HSV and HSL:
--- - Hue (H): Identical between HSV and HSL
--- - Saturation (S): Different definitions - HSV saturation is relative to value,
---   HSL saturation is relative to lightness. Saturation must be recalculated.
--- - Brightness: HSV uses Value (V), HSL uses Lightness (L)
---
--- Relationship between HSV Value and HSL Lightness:
--- - For achromatic colors (S=0): L = V (identical)
--- - For chromatic colors (S>0): L = V × (1 - S/2)
---   Lightness is always ≤ Value, with maximum difference at full saturation (L = V/2)
---
local st_utils = require 'st.utils'

--- @param hue number Hue component (any real number, circular - wraps every 1.0)
--- @param saturation number HSV saturation component in the range [0,1]
--- @param value number Value component in the range [0,1]
--- @return number,number,number HSL color values (hue, saturation, lightness)
local function hsv_to_hsl(hue, saturation, value)
    -- Handle achromatic colors (no saturation)
    if saturation == 0 then
        return hue, 0, value  -- Lightness = Value when S = 0
    end

    -- Calculate lightness
    local lightness = value * (1 - saturation / 2)

    -- Calculate HSL saturation
    -- S_HSL = (V * S) / (1 - |2L - 1|)
    local denominator = 1 - math.abs(2 * lightness - 1)
    local s
    if denominator == 0 then
        s = 0  -- Avoid division by zero
    else
        s = (value * saturation) / denominator
    end

    -- Clamp to valid range
    s = st_utils.clamp_value(s, 0, 1)

    return hue, s, lightness
end

return hsv_to_hsl