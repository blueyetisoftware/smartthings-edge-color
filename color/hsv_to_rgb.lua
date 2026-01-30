local clampHFF = require 'color.format.hue'.clampHFF

--- Converts HSV (Hue/Saturation/Value) color values to RGB color values.
---
--- This function provides proper HSV to RGB conversion including the Value component.
--- For compatibility with SmartThings Edge, when only hue and saturation are provided,
--- it defaults to value=1.0 (full brightness) matching st_utils.hsv_to_rgb behavior.
---
--- @param hue number Hue component (any real number, circular - wraps every 1.0)
--- @param saturation number Saturation component in the range [0,1] (normalized)
--- @param value number|nil Value/Brightness component in the range [0,1] (normalized), defaults to 1.0
--- @return number, number, number RGB color values (red, green, blue) in the range [0,1]
---
--- @raise error if hue, saturation, or value are not numbers
---
--- @usage
--- local r, g, b = hsv_to_rgb(0, 1, 1)    -- Pure red at full brightness: 1, 0, 0
--- local r, g, b = hsv_to_rgb(0, 1, 0.5)  -- Dark red: 0.5, 0, 0
--- local r, g, b = hsv_to_rgb(0, 1)       -- Pure red (value defaults to 1.0): 1, 0, 0
--- local r, g, b = hsv_to_rgb(0.333, 1, 1)  -- Pure green: 0, 1, 0
--- local r, g, b = hsv_to_rgb(0.667, 1, 1)  -- Pure blue: 0, 0, 1
local function fn(hue, saturation, value)
    assert(type(hue) == "number", "hue must be a number")
    assert(type(saturation) == "number", "saturation must be a number")
    assert(value == nil or type(value) == "number", "value must be a number or nil")

    hue, saturation, value = clampHFF(hue, saturation, value or 1.0)

    -- Implement proper HSV to RGB with value scaling
    local r, g, b

    if saturation <= 0 then
        r, g, b = value, value, value
    else
        local region = math.floor(6 * hue)
        local remainder = 6 * hue - region

        local p = value * (1 - saturation)
        local q = value * (1 - saturation * remainder)
        local t = value * (1 - saturation * (1 - remainder))

        if region == 0 then
            r, g, b = value, t, p
        elseif region == 1 then
            r, g, b = q, value, p
        elseif region == 2 then
            r, g, b = p, value, t
        elseif region == 3 then
            r, g, b = p, q, value
        elseif region == 4 then
            r, g, b = t, p, value
        else
            r, g, b = value, p, q
        end
    end

    return r, g, b
end
return fn
