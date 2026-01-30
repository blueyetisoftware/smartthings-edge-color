#!/usr/bin/env lua
--- Code generation script for grouped color conversion modules
--- This script generates grouped conversion modules based on conversion pairs,
--- with all format variants in each module.

local lfs = require 'lfs'  -- LuaFileSystem for directory operations

-- Define the color spaces and their formats
local SPACES = {
    rgb = { formats = {'rgb8', 'hex24', 'rgb100'} },
    hsv = { formats = {'hsv', 'hsv360'} },
    hsl = { formats = {'hsl', 'hsl360'} },
    cct = { formats = {'cctk', 'cctm'} },
    xyy = { formats = {'xyy'} }
}

-- Define conversion pairs to generate modules for
local CONVERSION_PAIRS = {
    {'rgb', 'hsv'},
    {'rgb', 'hsl'},
    {'rgb', 'cct'},
    {'rgb', 'xyy'},
    {'hsv', 'hsl'},
    {'cct', 'xyy'}
}

-- Format conversion functions
local FORMAT_FUNCTIONS = {
    rgb8 = { to = 'to_rgb8', from = 'from_rgb8' },
    hex24 = { to = 'to_hex24', from = 'from_hex24' },
    rgb100 = { to = 'to_rgb100', from = 'from_rgb100' },
    hsv360 = { to = 'to_hsv360', from = 'from_hsv360' },
    hsl360 = { to = 'to_hsl360', from = 'from_hsl360' },
    cctk = { to = 'to_kelvin', from = 'to_mired' },
    cctm = { to = 'to_mired', from = 'to_kelvin' }
}

-- Generate grouped conversion modules
local function generate_conversion_modules()
    local modules = {}

    for _, pair in ipairs(CONVERSION_PAIRS) do
        local from_space, to_space = pair[1], pair[2]
        local module_name = from_space .. '_' .. to_space

        -- Get all format combinations for this conversion pair
        local conversions = {}
        local from_formats = SPACES[from_space].formats
        local to_formats = SPACES[to_space].formats

        -- Generate conversions from first space formats to second space formats
        for _, from_fmt in ipairs(from_formats) do
            for _, to_fmt in ipairs(to_formats) do
                if from_fmt ~= to_fmt then  -- Skip identity conversions
                    table.insert(conversions, {
                        from = from_fmt,
                        to = to_fmt,
                        from_space = from_space,
                        to_space = to_space
                    })
                end
            end
        end

        -- Generate conversions from second space formats to first space formats
        for _, from_fmt in ipairs(to_formats) do
            for _, to_fmt in ipairs(from_formats) do
                if from_fmt ~= to_fmt then  -- Skip identity conversions
                    table.insert(conversions, {
                        from = from_fmt,
                        to = to_fmt,
                        from_space = to_space,
                        to_space = from_space
                    })
                end
            end
        end

        modules[module_name] = conversions
    end

    return modules
end

-- Generate the Lua code for a grouped conversion module
local function generate_module_code(module_name, conversions)
    local lines = {}

    -- Header with detailed documentation
    local title = module_name:gsub('_', ' ↔ '):gsub('(%w+)', function(s) return s:sub(1,1):upper() .. s:sub(2) end)
    table.insert(lines, string.format("--- %s conversion module", title))
    table.insert(lines, "--- Contains all format variants for this conversion pair")
    table.insert(lines, "---")
    table.insert(lines, "--- This module provides industry-standard color space conversions following")
    table.insert(lines, "--- established algorithms and best practices for computer graphics.")
    
    -- Add specific documentation based on conversion type
    if module_name == "rgb_cct" then
        table.insert(lines, "---")
        table.insert(lines, "--- RGB ↔ CCT conversions use optimized lookup table interpolation")
        table.insert(lines, "--- with golden section search for accurate color temperature calculation.")
        table.insert(lines, "--- Provides high accuracy across the full 1000K-30000K range.")
        table.insert(lines, "---")
        table.insert(lines, "--- Standards: CIE 1931 color space, correlated color temperature")
        table.insert(lines, "--- Algorithm: Lookup table interpolation + golden section search")
        table.insert(lines, "--- Accuracy: < 10K error across standard illuminant range")
    elseif module_name == "rgb_xyy" then
        table.insert(lines, "---")
        table.insert(lines, "--- RGB ↔ xyY conversions use the sRGB color space primaries and")
        table.insert(lines, "--- standard CIE 1931 color matching functions.")
        table.insert(lines, "---")
        table.insert(lines, "--- Standards: CIE 1931, sRGB (IEC 61966-2-1)")
        table.insert(lines, "--- Algorithm: Linear transformation with proper gamma correction")
    elseif module_name == "rgb_hsv" then
        table.insert(lines, "---")
        table.insert(lines, "--- RGB ↔ HSV conversions follow the standard computer graphics")
        table.insert(lines, "--- algorithm with proper handling of achromatic colors.")
        table.insert(lines, "---")
        table.insert(lines, "--- Standards: Computer graphics standard (Foley et al.)")
        table.insert(lines, "--- Algorithm: Component-wise maximum/minimum calculations")
    elseif module_name == "rgb_hsl" then
        table.insert(lines, "---")
        table.insert(lines, "--- RGB ↔ HSL conversions use the standard lightness calculation")
        table.insert(lines, "--- with proper handling of saturation and lightness components.")
        table.insert(lines, "---")
        table.insert(lines, "--- Standards: CSS Color Module Level 4, W3C specification")
        table.insert(lines, "--- Algorithm: Lightness = (max + min)/2, Saturation varies by lightness")
    elseif module_name == "hsv_hsl" then
        table.insert(lines, "---")
        table.insert(lines, "--- HSV ↔ HSL conversions use direct mathematical relationships")
        table.insert(lines, "--- avoiding RGB intermediate steps for optimal performance.")
        table.insert(lines, "---")
        table.insert(lines, "--- Formulas: L = V × (1 - S/2), V = L + S × min(L, 1-L)")
        table.insert(lines, "--- Algorithm: Direct component transformation (H identical, S/V adjusted)")
    elseif module_name == "cct_xyy" then
        table.insert(lines, "---")
        table.insert(lines, "--- CCT ↔ xyY conversions use the CIE daylight illuminant series")
        table.insert(lines, "--- approximation for correlated color temperature calculations.")
        table.insert(lines, "---")
        table.insert(lines, "--- Standards: CIE daylight illuminants, Planckian locus approximation")
        table.insert(lines, "--- Algorithm: Polynomial approximation of daylight chromaticity")
    end
    
    table.insert(lines, "")

    -- Requires
    local requires = {}
    local core_conversions = {}

    for _, conv in ipairs(conversions) do
        local from_space, to_space = conv.from_space, conv.to_space

        -- Add core conversion requires
        if from_space == 'hsv' and to_space == 'hsl' then
            -- Direct HSV to HSL conversion
            local core_key = "hsv_to_hsl"
            if not core_conversions[core_key] then
                table.insert(requires, string.format("local %s = require 'color.core.%s'", core_key, core_key))
                core_conversions[core_key] = true
            end
        elseif from_space == 'hsl' and to_space == 'hsv' then
            -- Direct HSL to HSV conversion
            local core_key = "hsl_to_hsv"
            if not core_conversions[core_key] then
                table.insert(requires, string.format("local %s = require 'color.core.%s'", core_key, core_key))
                core_conversions[core_key] = true
            end
        else
            -- Standard conversion through RGB
            if from_space ~= 'rgb' then
                local core_key = string.format("%s_to_rgb", from_space)
                if not core_conversions[core_key] then
                    table.insert(requires, string.format("local %s = require 'color.core.%s'", core_key, core_key))
                    core_conversions[core_key] = true
                end
            end
            if to_space ~= 'rgb' then
                local core_key = string.format("rgb_to_%s", to_space)
                if not core_conversions[core_key] then
                    table.insert(requires, string.format("local %s = require 'color.core.%s'", core_key, core_key))
                    core_conversions[core_key] = true
                end
            end
        end

        -- Add pass-through requires for normalized conversions (only for RGB-centric pairs)
        if from_space == 'rgb' or to_space == 'rgb' then
            local from_to_to = string.format("%s_to_%s", from_space, to_space)
            if not core_conversions[from_to_to] then
                table.insert(requires, string.format("local %s = require 'color.core.%s'", from_to_to, from_to_to))
                core_conversions[from_to_to] = true
            end
            local to_to_from = string.format("%s_to_%s", to_space, from_space)
            if not core_conversions[to_to_from] then
                table.insert(requires, string.format("local %s = require 'color.core.%s'", to_to_from, to_to_from))
                core_conversions[to_to_from] = true
            end
        end

        -- Add format conversion requires
        if FORMAT_FUNCTIONS[conv.from] then
            local fmt_module
            if conv.from:match('^rgb') or conv.from:match('^hex') then
                fmt_module = 'rgb'
            elseif conv.from:match('^hsv360') then
                fmt_module = 'hsv'
            elseif conv.from:match('^hsl360') then
                fmt_module = 'hsl'
            elseif conv.from:match('^cct') then
                fmt_module = 'cct'
            end
            local fmt_key = string.format("from_%s", conv.from)
            if not core_conversions[fmt_key] then
                table.insert(requires, string.format("local %s = require 'color.format.%s'.%s",
                    fmt_key, fmt_module, FORMAT_FUNCTIONS[conv.from].from))
                core_conversions[fmt_key] = true
            end
        end

        if FORMAT_FUNCTIONS[conv.to] then
            local fmt_module
            if conv.to:match('^rgb') or conv.to:match('^hex') then
                fmt_module = 'rgb'
            elseif conv.to:match('^hsv360') then
                fmt_module = 'hsv'
            elseif conv.to:match('^hsl360') then
                fmt_module = 'hsl'
            elseif conv.to:match('^cct') then
                fmt_module = 'cct'
            end
            local fmt_key = string.format("to_%s", conv.to)
            if not core_conversions[fmt_key] then
                table.insert(requires, string.format("local %s = require 'color.format.%s'.%s",
                    fmt_key, fmt_module, FORMAT_FUNCTIONS[conv.to].to))
                core_conversions[fmt_key] = true
            end
        end
    end

    -- Add requires to output
    for _, req in ipairs(requires) do
        table.insert(lines, req)
    end
    table.insert(lines, "")

    -- Module table
    table.insert(lines, "local M = {}")
    table.insert(lines, "")

    -- Generate functions for each conversion
    for _, conv in ipairs(conversions) do
        local func_name = string.format("%s_to_%s", conv.from, conv.to)
        local from_space, to_space = conv.from_space, conv.to_space

        table.insert(lines, string.format("-- %s to %s", conv.from:gsub('_', ' '), conv.to:gsub('_', ' ')))
        table.insert(lines, string.format("function M.%s(", func_name))

        -- Function parameters
        local params = {}
        if conv.from == 'cctk' then
            table.insert(params, "kelvin")
        elseif conv.from == 'cctm' then
            table.insert(params, "mired")
        elseif conv.from == 'xyy' then
            table.insert(params, "x, y, Y")
        elseif conv.from == 'hsv' then
            table.insert(params, "hue, saturation, value")
        elseif conv.from == 'hsv360' then
            table.insert(params, "hue_degrees, saturation, value")
        elseif conv.from == 'hsl' then
            table.insert(params, "hue, saturation, lightness")
        elseif conv.from == 'hsl360' then
            table.insert(params, "hue_degrees, saturation, lightness")
        else
            table.insert(params, "red, green, blue")
        end

        table.insert(lines, string.format("    %s", table.concat(params, ', ')))
        table.insert(lines, ")")

        -- Function body
        local call_chain = {}

        -- Input format conversion
        if FORMAT_FUNCTIONS[conv.from] then
            table.insert(call_chain, string.format("from_%s(%s)", conv.from, table.concat(params, ', ')))
        else
            table.insert(call_chain, table.concat(params, ', '))
        end

        -- Core conversion
        if from_space == 'hsv' and to_space == 'hsl' then
            -- Direct HSV to HSL conversion
            table.insert(call_chain, string.format("hsv_to_hsl(%s)", call_chain[#call_chain]))
        elseif from_space == 'hsl' and to_space == 'hsv' then
            -- Direct HSL to HSV conversion
            table.insert(call_chain, string.format("hsl_to_hsv(%s)", call_chain[#call_chain]))
        else
            -- Standard conversion through RGB
            if from_space ~= 'rgb' then
                -- Convert from source space to RGB
                local from_to_rgb = string.format("%s_to_rgb", from_space)
                table.insert(call_chain, string.format("%s(%s)", from_to_rgb, call_chain[#call_chain]))
            end
            
            if to_space ~= 'rgb' then
                -- Convert from RGB to target space
                local rgb_to_to = string.format("rgb_to_%s", to_space)
                table.insert(call_chain, string.format("%s(%s)", rgb_to_to, call_chain[#call_chain]))
            end
        end

        -- Output format conversion
        if FORMAT_FUNCTIONS[conv.to] then
            table.insert(call_chain, string.format("to_%s(%s)", conv.to, call_chain[#call_chain]))
        end

        table.insert(lines, string.format("    return %s", call_chain[#call_chain]))
        table.insert(lines, "end")
        table.insert(lines, "")
    end

    -- Add normalized pass-through functions for discoverability (only for RGB-centric pairs)
    local from_space, to_space = module_name:match('^([^_]+)_(.+)$')
    if from_space == 'rgb' or to_space == 'rgb' then
        table.insert(lines, string.format("-- %s to %s (normalized pass-through)", from_space, to_space))
        table.insert(lines, string.format("function M.%s_to_%s(", from_space, to_space))
        if from_space == 'rgb' then
            table.insert(lines, "    red, green, blue")
        elseif from_space == 'hsv' then
            table.insert(lines, "    hue, saturation, value")
        elseif from_space == 'hsl' then
            table.insert(lines, "    hue, saturation, lightness")
        elseif from_space == 'cct' then
            table.insert(lines, "    kelvin")
        elseif from_space == 'xyy' then
            table.insert(lines, "    x, y, Y")
        end
        table.insert(lines, ")")
        table.insert(lines, string.format("    return %s_to_%s(%s)", from_space, to_space, 
            from_space == 'rgb' and "red, green, blue" or
            from_space == 'hsv' and "hue, saturation, value" or
            from_space == 'hsl' and "hue, saturation, lightness" or
            from_space == 'cct' and "kelvin" or
            from_space == 'xyy' and "x, y, Y"))
        table.insert(lines, "end")
        table.insert(lines, "")

        table.insert(lines, string.format("-- %s to %s (normalized pass-through)", to_space, from_space))
        table.insert(lines, string.format("function M.%s_to_%s(", to_space, from_space))
        if to_space == 'rgb' then
            table.insert(lines, "    red, green, blue")
        elseif to_space == 'hsv' then
            table.insert(lines, "    hue, saturation, value")
        elseif to_space == 'hsl' then
            table.insert(lines, "    hue, saturation, lightness")
        elseif to_space == 'cct' then
            table.insert(lines, "    kelvin")
        elseif to_space == 'xyy' then
            table.insert(lines, "    x, y, Y")
        end
        table.insert(lines, ")")
        table.insert(lines, string.format("    return %s_to_%s(%s)", to_space, from_space,
            to_space == 'rgb' and "red, green, blue" or
            to_space == 'hsv' and "hue, saturation, value" or
            to_space == 'hsl' and "hue, saturation, lightness" or
            to_space == 'cct' and "kelvin" or
            to_space == 'xyy' and "x, y, Y"))
        table.insert(lines, "end")
        table.insert(lines, "")
    end

    table.insert(lines, "return M")

    return table.concat(lines, '\n')
end

-- Main generation function
local function main()
    if arg[1] ~= '--generate' then
        print("Usage: lua generate_chains.lua --generate")
        print("This will generate grouped conversion modules in the color/conversions/ directory")
        return
    end

    local modules = generate_conversion_modules()

    -- Create directories
    lfs.mkdir('color')
    lfs.mkdir('color/conversions')

    local total_conversions = 0
    for module_name, conversions in pairs(modules) do
        total_conversions = total_conversions + #conversions
    end

    print(string.format("Generating %d grouped conversion modules with %d total conversions...",
        #CONVERSION_PAIRS, total_conversions))

    for module_name, conversions in pairs(modules) do
        local filename = string.format("color/conversions/%s.lua", module_name)
        local code = generate_module_code(module_name, conversions)

        local file = io.open(filename, 'w')
        if file then
            file:write(code)
            file:close()
            print(string.format("Generated %s (%d conversions)", filename, #conversions))
        else
            print(string.format("Error: Could not write %s", filename))
        end
    end

    print("Generation complete!")
end

main()