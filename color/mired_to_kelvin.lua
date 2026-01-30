local st_utils = require 'st.utils'

--- Converts color temperature from Mired (micro reciprocal degrees) to Kelvin.
---
--- This is the inverse operation of kelvin_to_mired. Mired values are converted
--- back to Kelvin by dividing 1,000,000 by the mired value.
---
--- @param mired number Color temperature in Mired
--- @return number Color temperature in Kelvin, rounded to nearest integer
---
--- @raise error if mired is not a number or is zero/negative
---
--- @usage
--- local kelvin = mired_to_kelvin(333)  -- returns 3000 (warm white)
--- local kelvin = mired_to_kelvin(154)  -- returns 6494 (approximately daylight white)
---
--- @see kelvin_to_mired
local function mired_to_kelvin(mired)
    assert(type(mired) == "number" and mired > 0, "mired must be a positive number")

    return st_utils.round(1000000.0 / mired)  -- kelvin = 1,000,000 / mired (micro reciprocal degrees)
end

return mired_to_kelvin