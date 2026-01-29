local st_utils = require 'st.utils'

--- Converts color temperature from Kelvin to Mired (micro reciprocal degrees).
---
--- Mired is a unit used in lighting to express color temperature. It is defined
--- as 1,000,000 divided by the color temperature in Kelvin. Lower mired values
--- correspond to warmer (lower temperature) light, while higher mired values
--- correspond to cooler (higher temperature) light.
---
--- @param kelvin number Color temperature in Kelvin
--- @return number Color temperature in Mired, rounded to nearest integer
---
--- @raise error if kelvin is not a number or is zero/negative
---
--- @usage
--- local mired = kelvin_to_mirek(3000)  -- returns 333 (warm white)
--- local mired = kelvin_to_mirek(6500)  -- returns 154 (daylight white)
---
--- @see mirek_to_kelvin
local function kelvin_to_mirek(kelvin)
    if type(kelvin) ~= "number" or kelvin <= 0 then
        error("kelvin must be a positive number", 2)
    end

    return st_utils.round(1000000.0 / kelvin)
end

return kelvin_to_mirek