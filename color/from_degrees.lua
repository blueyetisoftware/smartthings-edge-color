--- Converts degree values to normalized values [0,1].
---
--- This function scales degree-based color components (typically hue) to
--- floating-point values in the range [0,1) by dividing by 360. Values outside
--- [0,360] are wrapped circularly (e.g., 390° = 30°, -30° = 330°).
--- Note: The output range is [0,1), meaning 360° maps to 0.0 due to circular wrapping.
---
--- @param degrees number Degree value to convert (any real number, circular)
--- @return number The normalized value in range [0,1)
---
--- @raise error if degrees is nil or not a number
---
--- @usage
--- local hue = from_degrees(180)     -- returns 0.5
--- local wrapped = from_degrees(-30) -- returns 0.833 (330°)
--- local wrapped2 = from_degrees(390) -- returns 0.083 (30°)
---
--- @see to_degrees
local function from_degrees(degrees)
    assert(type(degrees) == "number", "degrees must be a number")
    -- Circular wrapping: any real number is valid for degrees
    return (degrees % 360) / 360.0
end

return from_degrees