local clamp_rgb = require 'color.format.rgb'.clamp_rgb
local clamp_hsv = require 'color.format.hsv'.clamp_hsv

--- @internal
--- Converts Red/Green/Blue to Hue/Saturation/Value
---
--- This function converts RGB color values to HSV (Hue, Saturation, Value) color space.
---
--- @param r number red in range [0,1]
--- @param g number green in range [0,1]
--- @param b number blue in range [0,1]
--- @return number hue Hue component in range [0,1] (0 = red, 1/3 = green, 2/3 = blue)
--- @return number saturation Saturation component in range [0,1] (0 = grayscale, 1 = fully saturated)
--- @return number value Value (brightness) component in range [0,1] (0 = black, 1 = full brightness)
---
--- @raise error if red, green, or blue are not numbers
---
--- @usage
--- local h, s, v = rgb_to_hsv(1, 0, 0)    -- Pure red: 0, 1, 1
--- local h, s, v = rgb_to_hsv(0, 1, 0)    -- Pure green: 0.333, 1, 1
--- local h, s, v = rgb_to_hsv(0, 0, 1)    -- Pure blue: 0.667, 1, 1
local function fn(r, g, b)
    assert(type(r) == "number", "red must be a number")
    assert(type(g) == "number", "green must be a number")
    assert(type(b) == "number", "blue must be a number")

    r, g, b = clamp_rgb(r, g, b)

    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local delta = max - min

    if delta <= 0 then
        return 0, 0, max
    end

    local s = delta / max
    local h

    if r >= max then
        h = (g - b) / delta
    elseif g >= max then
        h = 2 + (b - r) / delta
    else
        h = 4 + (r - g) / delta
    end

    h = (h / 6)

    return clamp_hsv(h, s, max)
end
return fn
