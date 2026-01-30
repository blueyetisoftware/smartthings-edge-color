#!/usr/bin/env lua
--- Code generation script for color conversion chain functions
--- This script generates all possible chain conversion functions based on
--- the available core conversions and format conversions.

local lfs = require 'lfs'  -- LuaFileSystem for directory operations

-- Define the color spaces and their formats
local SPACES = {
    rgb = { formats = {'rgb8', 'rgb16', 'rgb100'} },
    hsv = { formats = {'hsv', 'hdsv'} },
    hsl = { formats = {'hsl'} },
    cct = { formats = {'cct_kelvin', 'cct_mired'} },
    xyy = { formats = {'xyy'} }
}

-- Define the core conversion functions that exist (only RGB-centric)
local CORE_CONVERSIONS = {
    -- RGB to other spaces
    {'rgb', 'hsv'},
    {'rgb', 'hsl'},
    {'rgb', 'cct'},
    {'rgb', 'xyy'},

    -- Other spaces to RGB
    {'hsv', 'rgb'},
    {'hsl', 'rgb'},
    {'cct', 'rgb'},
    {'xyy', 'rgb'}
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

-- Generate all possible chain conversions
local function generate_chains()
    local chains = {}

    -- Get all spaces that have RGB conversions
    local rgb_connected_spaces = {}
    for _, conversion in ipairs(CORE_CONVERSIONS) do
        local from_space, to_space = conversion[1], conversion[2]
        if from_space ~= 'rgb' then
            rgb_connected_spaces[from_space] = true
        end
        if to_space ~= 'rgb' then
            rgb_connected_spaces[to_space] = true
        end
    end

    -- Generate chains for all format combinations
    for from_space, from_data in pairs(SPACES) do
        for _, from_fmt in ipairs(from_data.formats) do
            for to_space, to_data in pairs(SPACES) do
                for _, to_fmt in ipairs(to_data.formats) do
                    -- Skip identity conversions
                    if from_fmt ~= to_fmt then
                        table.insert(chains, {
                            from = from_fmt,
                            to = to_fmt,
                            from_space = from_space,
                            to_space = to_space
                        })
                    end
                end
            end
        end
    end

    return chains
end

-- Get format description for documentation
local function get_format_description(fmt)
    local descriptions = {
        rgb8 = "RGB8 color values (0-255)",
        rgb16 = "RGB16 color values (0-65535)",
        rgb100 = "RGB100 color values (0-100)",
        hsv = "HSV color values (hue/saturation/value in 0-1 range)",
        hdsv = "HDSV color values (hue in degrees 0-360, saturation/value in 0-1 range)",
        hsl = "HSL color values (hue/saturation/lightness in 0-1 range)",
        cct_kelvin = "correlated color temperature in Kelvin",
        cct_mired = "correlated color temperature in Mired",
        xyy = "CIE 1931 xyY color coordinates"
    }
    return descriptions[fmt] or fmt
end

-- Get type description for parameters
local function get_type_description(fmt)
    local integer_formats = {
        rgb8 = true,
        rgb16 = true,
        cct_kelvin = true,
        cct_mired = true
    }
    return integer_formats[fmt] and "integer" or "number"
end

-- Get range description for parameters
local function get_range_description(fmt)
    local ranges = {
        rgb8 = "[0,255]",
        rgb16 = "[0,65535]",
        rgb100 = "[0,100]",
        hsv = "[0,1]",
        hdsv = "[0,360] for hue, [0,1] for saturation/value",
        hsl = "[0,1]",
        cct_kelvin = "[1000,40000]",
        cct_mired = "[1,31000]",
        xyy = "[0,1]"
    }
    return ranges[fmt] or ""
end

-- Get parameter documentation
local function get_parameter_docs(fmt)
    local params = {}

    if fmt == 'cct_kelvin' then
        table.insert(params, "--- @param kelvin integer correlated color temperature in Kelvin, range [1000,40000]")
    elseif fmt == 'cct_mired' then
        table.insert(params, "--- @param mired integer correlated color temperature in Mired, range [1,31000]")
    elseif fmt == 'xyy' then
        table.insert(params, "--- @param x number CIE 1931 x coordinate, range [0,1]")
        table.insert(params, "--- @param y number CIE 1931 y coordinate, range [0,1]")
        table.insert(params, "--- @param Y number luminance, range [0,1]")
    elseif fmt == 'hsv' then
        table.insert(params, "--- @param hue number hue component, range [0,1]")
        table.insert(params, "--- @param saturation number saturation component, range [0,1]")
        table.insert(params, "--- @param value number value component, range [0,1]")
    elseif fmt == 'hdsv' then
        table.insert(params, "--- @param hue_degrees number hue component in degrees, range [0,360]")
        table.insert(params, "--- @param saturation number saturation component, range [0,1]")
        table.insert(params, "--- @param value number value component, range [0,1]")
    elseif fmt == 'hsl' then
        table.insert(params, "--- @param hue number hue component, range [0,1]")
        table.insert(params, "--- @param saturation number saturation component, range [0,1]")
        table.insert(params, "--- @param lightness number lightness component, range [0,1]")
    else
        -- RGB-based formats
        local type_desc = get_type_description(fmt)
        local range_desc = get_range_description(fmt)
        table.insert(params, string.format("--- @param red %s red component, %s", type_desc, range_desc))
        table.insert(params, string.format("--- @param green %s green component, %s", type_desc, range_desc))
        table.insert(params, string.format("--- @param blue %s blue component, %s", type_desc, range_desc))
    end

    return params
end

-- Get return value documentation
local function get_return_docs(fmt)
    local type_desc = get_type_description(fmt)
    local range_desc = get_range_description(fmt)

    if fmt == 'cct_kelvin' then
        return "--- @return integer correlated color temperature in Kelvin, range [1000,40000]"
    elseif fmt == 'cct_mired' then
        return "--- @return integer correlated color temperature in Mired, range [1,31000]"
    elseif fmt == 'xyy' then
        return "--- @return number, number, number CIE 1931 x coordinate, y coordinate, luminance, all range [0,1]"
    elseif fmt == 'hsv' then
        return "--- @return number, number, number hue, saturation, value components, all range [0,1]"
    elseif fmt == 'hdsv' then
        return "--- @return number, number, number hue in degrees, saturation, value components, ranges [0,360] and [0,1]"
    elseif fmt == 'hsl' then
        return "--- @return number, number, number hue, saturation, lightness components, all range [0,1]"
    else
        -- RGB-based formats
        return string.format("--- @return %s, %s, %s red, green, blue components, each %s",
            type_desc, type_desc, type_desc, range_desc)
    end
end

-- Get usage example
local function get_usage_example(from_fmt, to_fmt)
    local examples = {
        rgb8 = "--- @usage local r, g, b = rgb8_to_hsv(255, 0, 0)  -- Pure red",
        rgb16 = "--- @usage local r, g, b = rgb16_to_hsv(65535, 0, 0)  -- Pure red",
        rgb100 = "--- @usage local r, g, b = rgb100_to_hsv(100, 0, 0)  -- Pure red",
        hsv = "--- @usage local r, g, b = hsv_to_rgb8(0, 1, 1)  -- Pure red",
        hdsv = "--- @usage local r, g, b = hdsv_to_rgb8(0, 1, 1)  -- Pure red",
        hsl = "--- @usage local r, g, b = hsl_to_rgb8(0, 1, 0.5)  -- Pure red"
    }

    local key = from_fmt:match('^cct_') and 'cct_kelvin' or
                from_fmt:match('^rgb') and 'rgb8' or
                from_fmt

    return examples[key] or string.format("--- @usage local result = %s_to_%s(input)", from_fmt, to_fmt)
end

-- Get detailed explanation for a conversion type
local function get_conversion_explanation(from_fmt, to_fmt)
    -- xyY conversions
    if to_fmt == 'xyy' or from_fmt == 'xyy' then
        return "--- Converts between RGB and CIE 1931 xyY color space, where x,y are chromaticity"
        .. "\n--- coordinates in [0,1] and Y represents luminance in [0,1]. This uses the standard"
        .. "\n--- sRGB color space primaries for the transformation."
    end

    -- CCT conversions
    if to_fmt:match('^cct_') or from_fmt:match('^cct_') then
        return "--- Converts between RGB and correlated color temperature (CCT) using Neil Bartlett's"
        .. "\n--- approximation algorithm. CCT represents the color temperature of a blackbody radiator"
        .. "\n--- in Kelvin (or Mired for reciprocal scale), approximating the warmth of light sources."
    end

    -- HSV conversions
    if to_fmt == 'hsv' or from_fmt == 'hsv' then
        return "--- Converts between RGB and HSV (Hue, Saturation, Value) color space, where:"
        .. "\n--- - Hue represents color angle (0=red, 1/3=green, 2/3=blue)"
        .. "\n--- - Saturation represents color purity (0=grayscale, 1=fully saturated)"
        .. "\n--- - Value represents brightness (0=black, 1=full brightness)"
    end

    -- HDSV conversions
    if to_fmt == 'hdsv' or from_fmt == 'hdsv' then
        return "--- Converts between RGB and HDSV color space (Hue in Degrees, Saturation, Value), where:"
        .. "\n--- - Hue represents color angle in degrees (0°=red, 120°=green, 240°=blue)"
        .. "\n--- - Saturation represents color purity (0=grayscale, 1=fully saturated)"
        .. "\n--- - Value represents brightness (0=black, 1=full brightness)"
    end

    -- HSL conversions
    if to_fmt == 'hsl' or from_fmt == 'hsl' then
        return "--- Converts between RGB and HSL (Hue, Saturation, Lightness) color space, where:"
        .. "\n--- - Hue represents color angle (0=red, 1/3=green, 2/3=blue)"
        .. "\n--- - Saturation represents color purity (0=grayscale, 1=fully saturated)"
        .. "\n--- - Lightness represents perceived brightness (0=black, 0.5=normal, 1=white)"
    end

    -- RGB format conversions
    if (from_fmt:match('^rgb') and to_fmt:match('^rgb')) then
        local from_bits = from_fmt:match('rgb(%d+)')
        local to_bits = to_fmt:match('rgb(%d+)')
        if from_bits and to_bits then
            return string.format("--- Converts between RGB color formats: %s-bit (%s range) to %s-bit (%s range).",
                from_bits, from_bits == "8" and "0-255" or from_bits == "16" and "0-65535" or "0-100",
                to_bits, to_bits == "8" and "0-255" or to_bits == "16" and "0-65535" or "0-100")
        end
    end

    return nil  -- No special explanation needed
end

-- Generate documentation for a conversion function
local function generate_docs(chain)
    local from_fmt = chain.from
    local to_fmt = chain.to

    local docs = {}

    -- Function description
    local from_desc = get_format_description(from_fmt)
    local to_desc = get_format_description(to_fmt)
    table.insert(docs, string.format("--- Converts %s to %s.", from_desc, to_desc))
    table.insert(docs, "---")

    -- Add detailed explanation based on conversion type
    local explanation = get_conversion_explanation(from_fmt, to_fmt)
    if explanation then
        table.insert(docs, explanation)
        table.insert(docs, "---")
    end

    table.insert(docs, string.format("--- This function converts %s to %s by routing through RGB space.", from_desc, to_desc))
    table.insert(docs, "---")

    -- Parameters
    local params = get_parameter_docs(from_fmt)
    for _, param in ipairs(params) do
        table.insert(docs, param)
    end

    -- Return values
    local returns = get_return_docs(to_fmt)
    table.insert(docs, returns)

    -- Usage example
    local example = get_usage_example(from_fmt, to_fmt)
    table.insert(docs, example)

    return table.concat(docs, '\n')
end

-- Generate the Lua code for a chain function
local function generate_function_code(chain)
    local from_fmt = chain.from
    local to_fmt = chain.to

    -- Build the conversion chain
    local conversions = {}

    -- Handle format conversions first
    if FORMAT_FUNCTIONS[from_fmt] then
        local format_module
        if from_fmt:match('^rgb') then
            format_module = 'rgb'
        elseif from_fmt:match('^hdsv') or from_fmt:match('^hsv') then
            format_module = 'hue'
        elseif from_fmt:match('^cct_') then
            format_module = 'cct'
        elseif from_fmt == 'xyy' then
            format_module = 'xyy'
        end
        if format_module then
            table.insert(conversions, string.format("require 'color.format.%s'.%s",
                format_module, FORMAT_FUNCTIONS[from_fmt].from))
        end
    end

    -- Add core conversion
    local from_space = chain.from_space
    local to_space = chain.to_space

    if from_space ~= 'rgb' and to_space == 'rgb' then
        -- From other space to RGB
        table.insert(conversions, string.format("require 'color.%s_to_rgb'", from_space))
    elseif from_space == 'rgb' and to_space ~= 'rgb' then
        -- From RGB to other space
        table.insert(conversions, string.format("require 'color.rgb_to_%s'", to_space))
    elseif from_space ~= 'rgb' and to_space ~= 'rgb' then
        -- Between two non-RGB spaces: route through RGB
        table.insert(conversions, string.format("require 'color.%s_to_rgb'", from_space))
        table.insert(conversions, string.format("require 'color.rgb_to_%s'", to_space))
    end

    -- Handle output format conversion
    if FORMAT_FUNCTIONS[to_fmt] then
        local format_module
        if to_fmt:match('^rgb') then
            format_module = 'rgb'
        elseif to_fmt:match('^hdsv') or to_fmt:match('^hsv') then
            format_module = 'hue'
        elseif to_fmt:match('^cct_') then
            format_module = 'cct'
        elseif to_fmt == 'xyy' then
            format_module = 'xyy'
        end
        if format_module then
            table.insert(conversions, string.format("require 'color.format.%s'.%s",
                format_module, FORMAT_FUNCTIONS[to_fmt].to))
        end
    end

    -- Build function body
    -- Determine parameter names based on input format
    local param_names
    if from_fmt == 'cct_kelvin' then
        param_names = 'kelvin'
    elseif from_fmt == 'cct_mired' then
        param_names = 'mired'
    elseif from_fmt == 'xyy' then
        param_names = 'x, y, Y'
    elseif from_fmt == 'hsv' then
        param_names = 'hue, saturation, value'
    elseif from_fmt == 'hdsv' then
        param_names = 'hue_degrees, saturation, value'
    elseif from_fmt == 'hsl' then
        param_names = 'hue, saturation, lightness'
    else
        param_names = 'red, green, blue'
    end

    local body = {}

    -- Add requires at the top
    local requires = {}
    for i, conversion in ipairs(conversions) do
        local var_name = string.format("conv%d", i)
        table.insert(requires, string.format("local %s = %s", var_name, conversion))
    end
    table.insert(body, table.concat(requires, '\n'))

    table.insert(body, "")

    -- Function definition
    table.insert(body, string.format("local function fn(%s)", param_names))

    -- Apply conversions in order
    local params = param_names
    for i, _ in ipairs(conversions) do
        local var_name = string.format("conv%d", i)
        params = string.format("%s(%s)", var_name, params)
    end

    table.insert(body, string.format("    return %s", params))
    table.insert(body, "end")
    table.insert(body, "")
    table.insert(body, "return fn")

    return table.concat(body, '\n')
end

-- Main generation function
local function main()
    if arg[1] ~= '--generate' then
        print("Usage: lua generate_chains.lua --generate")
        print("This will generate all chain conversion functions in the color/ directory")
        return
    end

    local chains = generate_chains()
    print(string.format("Generating %d chain conversion functions...", #chains))

    -- Create color directory if it doesn't exist
    lfs.mkdir('color')

    for _, chain in ipairs(chains) do
        local filename = string.format("color/%s_to_%s.lua", chain.from, chain.to)
        local docs = generate_docs(chain)
        local code = generate_function_code(chain)

        local file_content = string.format("%s\n%s", docs, code)

        local file = io.open(filename, 'w')
        if file then
            file:write(file_content)
            file:close()
            print(string.format("Generated %s", filename))
        else
            print(string.format("Error: Could not write %s", filename))
        end
    end

    print("Generation complete!")
end

main()