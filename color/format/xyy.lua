--- xyY color space format utilities
---
--- This module provides clamping functions for CIE xyY color values.

local st_utils = require 'st.utils'

--- Clamps xyY values to normalized range [0, 1].
---
--- Note: This currently only clamps individual components to [0,1].
--- Future enhancement could add gamut checking (x + y ≤ 1).
---
--- @param x number x chromaticity coordinate
--- @param y number y chromaticity coordinate
--- @param Y number Y luminance value (defaults to 1 if nil)
--- @return number,number,number Clamped xyY values
local function clampXYY(x, y, Y)
    Y = Y or 1
    return st_utils.clamp_value(x, 0, 1),
           st_utils.clamp_value(y, 0, 1),
           st_utils.clamp_value(Y, 0, 1)
end

return {
    clampXYY = clampXYY
}