local st_utils = require 'st.utils'
local clamp_rgb = require 'color.format.rgb'.clamp_rgb
local cct_to_rgb = require 'color.core.cct_to_rgb'

-- Lookup table for ratio-based CCT approximation (78 entries, ~600 bytes)
local RATIO_LOOKUP = {}
do
    for cct = 1000, 30000, 400 do  -- Adjusted step size for new range
        local r, _, b = cct_to_rgb(cct)
        RATIO_LOOKUP[#RATIO_LOOKUP + 1] = {ratio = b / r, cct = cct}
    end
end

--- Accurate algorithm using full RGB distance comparison with golden section search
local function rgb_to_cct_distance(r, g, b)
    local min = 1
    local max = 30000
    local best_cct = 1000
    local best_distance = math.huge
    local epsilon = 0.1  -- convergence threshold

    -- Coarse search with larger step size (151 iterations vs 301)
    for temp = min, max, 200 do
        local r_temp, g_temp, b_temp = cct_to_rgb(temp)
        local distance = (r - r_temp)^2 + (g - g_temp)^2 + (b - b_temp)^2  -- squared distance, avoid sqrt
        if distance < best_distance then
            best_distance = distance
            best_cct = temp
        end
    end

    -- Refine with golden section search around the best candidate
    min = math.max(1, best_cct - 300)
    max = math.min(30000, best_cct + 300)

    local golden_ratio = (math.sqrt(5) - 1) / 2  -- ~0.618

    while max - min > epsilon do
        local cct1 = max - golden_ratio * (max - min)
        local cct2 = min + golden_ratio * (max - min)

        local r1, g1, b1 = cct_to_rgb(cct1)
        local r2, g2, b2 = cct_to_rgb(cct2)

        local dist1 = (r - r1)^2 + (g - g1)^2 + (b - b1)^2
        local dist2 = (r - r2)^2 + (g - g2)^2 + (b - b2)^2

        if dist1 < dist2 then
            max = cct2
        else
            min = cct1
        end
    end

    return st_utils.round((min + max) / 2)
end

--- Fast approximation using blue/red ratio with lookup table interpolation
--- Based on Neil Bartlett's 2015 blackbody approximation algorithm
local function rgb_to_cct_ratio(r, _g, b)
    -- Handle edge case where red component is zero (ratio undefined)
    -- Use reasonable defaults based on color characteristics
    if r == 0 then
        if b > 0 then
            return 30000  -- Colors with no red but some blue are very cool
        else
            return 2251   -- Pure green approximation (closest Planckian point)
        end
    end

    local ratio = b / r

    -- Handle remaining edge cases
    if ratio <= RATIO_LOOKUP[1].ratio then
        return 1  -- Minimum CCT
    elseif ratio >= RATIO_LOOKUP[#RATIO_LOOKUP].ratio then
        return 30000  -- Maximum CCT
    end

    -- Find bracketing entries in lookup table
    for i = 1, #RATIO_LOOKUP - 1 do
        if ratio >= RATIO_LOOKUP[i].ratio and ratio <= RATIO_LOOKUP[i + 1].ratio then
            local lower, upper = RATIO_LOOKUP[i], RATIO_LOOKUP[i + 1]
            -- Linear interpolation between bracketing points
            local ratio_range = upper.ratio - lower.ratio
            local cct_range = upper.cct - lower.cct
            local ratio_pos = (ratio - lower.ratio) / ratio_range
            local interpolated_cct = lower.cct + ratio_pos * cct_range

            return st_utils.round(interpolated_cct)
        end
    end

    -- Fallback to binary search (handles any remaining edge cases)
    local cct
    local epsilon = 0.4
    local min = 1
    local max = 30000

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

--- Converts RGB color values to correlated color temperature (CCT) in Kelvin.
---
--- ⚠️  IMPORTANT: Uses FAST algorithm by DEFAULT for performance.
--- The fast approximation is ~200x faster and suitable for most driver use cases.
--- Only use accurate=true when precision is absolutely critical.
---
--- By default, this function uses a fast approximation algorithm that is ~200x faster
--- but slightly less accurate than the precise algorithm. The fast algorithm uses
--- only the blue/red ratio for estimation, which is a common simplification based
--- on Neil Bartlett's 2015 blackbody approximation.
---
--- @param r number Red component in range [0,1]
--- @param g number Green component in range [0,1]
--- @param b number Blue component in range [0,1]
--- @param accurate boolean|nil If true, uses the accurate algorithm with full RGB
---     distance comparison (~200x slower). If false or nil, uses the fast ratio
---     approximation (default - RECOMMENDED for drivers).
--- @return number Color temperature in Kelvin, rounded to nearest integer
---
--- @raise error if r, g, or b are not numbers
---
--- @usage
--- -- ✅ RECOMMENDED: Fast approximation (default, ~200x faster)
--- local cct = rgb_to_cct(1.0, 0.7, 0.4)  -- Approximately 2906K
---
--- -- ⚠️  Use accurate only when precision is critical
--- local cct = rgb_to_cct(1.0, 0.7, 0.4, true)  -- Approximately 2913K (200x slower)
local function rgb_to_cct(r, g, b, accurate)
    assert(type(r) == "number" and type(g) == "number" and type(b) == "number", "r, g, b must be numbers")
    r, g, b = clamp_rgb(r, g, b)

    if accurate == true then
        return rgb_to_cct_distance(r, g, b)
    else
        return rgb_to_cct_ratio(r, g, b)
    end
end

return rgb_to_cct