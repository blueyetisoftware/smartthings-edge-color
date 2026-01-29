local st_utils = require 'st.utils'
local cct_to_rgb = require 'color.cct_to_rgb'

--- Converts RGB color values to correlated color temperature (CCT) in Kelvin.
---
--- This function uses a binary search algorithm to find the color temperature
--- that produces RGB values closest to the input RGB. It iteratively narrows
--- down the temperature range until the desired precision is achieved.
---
--- The algorithm compares the blue-to-red ratio of the input RGB with ratios
--- from the CCT to RGB conversion, converging on the matching temperature.
---
--- @param r number Red component in range [0,1]
--- @param g number Green component in range [0,1]
--- @param b number Blue component in range [0,1]
--- @return number Color temperature in Kelvin, rounded to nearest integer
---
--- @raise error if r, g, or b are not numbers
---
--- @usage
--- local cct = rgb_to_cct(1.0, 0.7, 0.4)  -- Approximately 3000K (warm white)
--- local cct = rgb_to_cct(0.8, 0.9, 1.0)  -- Approximately 10000K (cool white)
local function rgb_to_cct(r, g, b)
    if type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" then
        error("r, g, b must be numbers", 2)
    end

    local ratio = b / r
    local cct
    local epsilon = 0.4  -- convergence threshold for binary search (reasonable precision for temperature)
    local min = 1000
    local max = 40000

    while max - min > epsilon do
        cct = (max + min) / 2
        local r_temp, _, b_temp = cct_to_rgb(cct)
        if b_temp / r_temp >= ratio then
            max = cct
        else
            min = cct
        end
    end

    return st_utils.round(cct)
end

return rgb_to_cct