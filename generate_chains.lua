#!/usr/bin/env lua
--- Code generation script for grouped color conversion modules
--- This script generates grouped conversion modules based on conversion pairs,
--- with all format variants in each module.

local lfs = require 'lfs'  -- LuaFileSystem for directory operations

-- Define the color spaces and their formats
local SPACES = {
    rgb = { formats = {'rgb8', 'rgb16', 'rgb100'} },
    hsv = { formats = {'hsv', 'hdsv'} },
    hsl = { formats = {'hsl'} },
    cct = { formats = {'cct_kelvin', 'cct_mired'} },
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
    rgb16 = { to = 'to_rgb16', from = 'from_rgb16' },
    rgb100 = { to = 'to_rgb100', from = 'from_rgb100' },
    hdsv = { to = 'to_hdff', from = 'from_hdff' },
    cct_mired = { to = 'to_mired', from = 'to_kelvin' },
    cct_kelvin = { to = 'to_kelvin', from = 'to_mired' }
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

        modules[module_name] = conversions
    end

    return modules
end

-- Generate the Lua code for a grouped conversion module
local function generate_module_code(module_name, conversions)
    local lines = {}

    -- Header
    table.insert(lines, string.format("--- %s conversion module", module_name:gsub('_', ' ↔ '):gsub('(%w+)', function(s) return s:sub(1,1):upper() .. s:sub(2) end)))
    table.insert(lines, "--- Contains all format variants for this conversion pair")
    table.insert(lines, "")

    -- Requires
    local requires = {}
    local core_conversions = {}

    for _, conv in ipairs(conversions) do
        local from_space, to_space = conv.from_space, conv.to_space

        -- Add core conversion requires (all conversions go through RGB)
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
            local fmt_module = conv.from:match('^([^0-9_]+)')
            if fmt_module == 'cct' then fmt_module = 'cct'
            elseif fmt_module == 'rgb' then fmt_module = 'rgb'
            elseif fmt_module == 'hdsv' then fmt_module = 'hue'
            end
            local fmt_key = string.format("from_%s", conv.from)
            if not core_conversions[fmt_key] then
                table.insert(requires, string.format("local %s = require 'color.format.%s'.%s",
                    fmt_key, fmt_module, FORMAT_FUNCTIONS[conv.from].from))
                core_conversions[fmt_key] = true
            end
        end

        if FORMAT_FUNCTIONS[conv.to] then
            local fmt_module = conv.to:match('^([^0-9_]+)')
            if fmt_module == 'cct' then fmt_module = 'cct'
            elseif fmt_module == 'rgb' then fmt_module = 'rgb'
            elseif fmt_module == 'hdsv' then fmt_module = 'hue'
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
        if conv.from == 'cct_kelvin' then
            table.insert(params, "kelvin")
        elseif conv.from == 'cct_mired' then
            table.insert(params, "mired")
        elseif conv.from == 'xyy' then
            table.insert(params, "x, y, Y")
        elseif conv.from == 'hsv' then
            table.insert(params, "hue, saturation, value")
        elseif conv.from == 'hdsv' then
            table.insert(params, "hue_degrees, saturation, value")
        elseif conv.from == 'hsl' then
            table.insert(params, "hue, saturation, lightness")
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

        -- Core conversion through RGB
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