local st_utils = require 'st.utils'
local Format = require 'color.format'
local cct_to_rgb = require 'color.cct_to_rgb'

--- Fast approximation using blue/red ratio (ignores green for performance)
--- Based on Neil Bartlett's 2015 blackbody approximation algorithm
local function rgb_to_cct_fast(r, g, b)
    local ratio = b / r
    local cct
    local epsilon = 0.4  -- convergence threshold for binary search
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

--- Accurate algorithm using full RGB distance comparison
local function rgb_to_cct_accurate(r, g, b)
    local epsilon = 0.001  -- RGB distance threshold for convergence
    local min = 1000
    local max = 40000
    local best_cct = 1000
    local best_distance = math.huge

    -- First, do a coarse search to find the approximate range
    for temp = min, max, 100 do
        local r_temp, g_temp, b_temp = cct_to_rgb(temp)
        local distance = math.sqrt((r - r_temp)^2 + (g - g_temp)^2 + (b - b_temp)^2)
        if distance < best_distance then
            best_distance = distance
            best_cct = temp
        end
    end

    -- Refine with ternary search around the best candidate
    min = math.max(1000, best_cct - 200)
    max = math.min(40000, best_cct + 200)

    while max - min > 1 do
        local cct1 = min + (max - min) / 3
        local cct2 = max - (max - min) / 3

        local r1, g1, b1 = cct_to_rgb(cct1)
        local r2, g2, b2 = cct_to_rgb(cct2)

        local dist1 = math.sqrt((r - r1)^2 + (g - g1)^2 + (b - b1)^2)
        local dist2 = math.sqrt((r - r2)^2 + (g - g2)^2 + (b - b2)^2)

        if dist1 < dist2 then
            max = cct2
        else
            min = cct1
        end
    end

    return st_utils.round((min + max) / 2)
end

--- Converts RGB color values to correlated color temperature (CCT) in Kelvin.
---
--- By default, this function uses a fast approximation algorithm that is ~20x faster
--- but slightly less accurate than the precise algorithm. The fast algorithm uses
--- only the blue/red ratio for estimation, which is a common simplification based
--- on Neil Bartlett's 2015 blackbody approximation.
---
--- @param r number Red component in range [0,1]
--- @param g number Green component in range [0,1]
--- @param b number Blue component in range [0,1]
--- @param accurate boolean|nil If true, uses the accurate algorithm with full RGB
---     distance comparison. If false or nil, uses the fast approximation (default).
--- @return number Color temperature in Kelvin, rounded to nearest integer
---
--- @raise error if r, g, or b are not numbers
---
--- @usage
--- -- Fast approximation (default, ~20x faster)
--- local cct = rgb_to_cct(1.0, 0.7, 0.4)  -- Approximately 2906K
---
--- -- Accurate calculation (slower but more precise)
--- local cct = rgb_to_cct(1.0, 0.7, 0.4, true)  -- Approximately 2913K
local function rgb_to_cct(r, g, b, accurate)
    assert(type(r) == "number" and type(g) == "number" and type(b) == "number", "r, g, b must be numbers")
    r, g, b = Format.clampRGB(r, g, b)

    if accurate == true then
        return rgb_to_cct_accurate(r, g, b)
    else
        return rgb_to_cct_fast(r, g, b)
    end
end

return rgb_to_cct