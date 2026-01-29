local st_utils = require 'st.utils'

--- Converts color temperature from Mired (micro reciprocal degrees) to Kelvin.
---
--- This is the inverse operation of kelvin_to_mirek. Mired values are converted
--- back to Kelvin by dividing 1,000,000 by the mired value.
---
--- @param mirek number Color temperature in Mired
--- @return number Color temperature in Kelvin, rounded to nearest integer
---
--- @raise error if mirek is not a number or is zero/negative
---
--- @usage
--- local kelvin = mirek_to_kelvin(333)  -- returns 3000 (warm white)
--- local kelvin = mirek_to_kelvin(154)  -- returns 6494 (approximately daylight white)
---
--- @see kelvin_to_mirek
local function mirek_to_kelvin(mirek)
    if type(mirek) ~= "number" or mirek <= 0 then
        error("mirek must be a positive number", 2)
    end

    return st_utils.round(1000000.0 / mirek)  -- kelvin = 1,000,000 / mirek (micro reciprocal degrees)
end

return mirek_to_kelvin