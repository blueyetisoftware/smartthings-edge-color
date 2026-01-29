--- Converts normalized values [0,1] to degree values [0,360).
---
--- This function scales floating-point color components in the range [0,1] to
--- degree values in the range [0,360) by multiplying by 360. Values outside
--- [0,1] are wrapped circularly (e.g., 1.1 = 396°, -0.1 = 324°).
--- Note: The output range is [0,360), meaning 1.0 maps to 0° due to circular wrapping.
---
--- @param value number Normalized value to convert (any real number, circular)
--- @return number The degree value in range [0,360)
---
--- @raise error if value is nil or not a number
---
--- @usage
--- local hue = to_degrees(0.5)       -- returns 180
--- local wrapped = to_degrees(-0.1)  -- returns 324 (equivalent to -36°)
--- local wrapped2 = to_degrees(1.1)  -- returns 396 (equivalent to 36°)
---
--- @see from_degrees
local function to_degrees(value)
    assert(type(value) == "number", "value must be a number")
    -- Circular wrapping: any real number is valid for normalized values
    return (value % 1) * 360.0
end

return to_degrees