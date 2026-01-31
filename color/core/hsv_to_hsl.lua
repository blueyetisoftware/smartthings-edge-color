--- Converts HSV (Hue/Saturation/Value) color values directly to HSL (Hue/Saturation/Lightness).
---
--- This function provides direct HSV to HSL conversion without going through RGB,
--- which is more efficient since H and S are identical between the two spaces.
---
--- Relationship between HSV Value and HSL Lightness:
--- - For achromatic colors (S=0): L = V (identical)
--- - For chromatic colors (S>0): L = V × (1 - S/2)
---   Lightness is always ≤ Value, with maximum difference at full saturation (L = V/2)
---
--- @param hue number Hue component (any real number, circular - wraps every 1.0)
--- @param saturation number Saturation component in the range [0,1]
--- @param value number Value component in the range [0,1]
--- @return number,number,number HSL color values (hue, saturation, lightness)
local function hsv_to_hsl(hue, saturation, value)
    -- Hue is identical between HSV and HSL
    local h = hue

    -- Handle achromatic colors (no saturation)
    if saturation == 0 then
        return h, 0, value  -- Lightness = Value when S = 0
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
    s = math.max(0, math.min(1, s))

    return h, s, lightness
end

return hsv_to_hsl