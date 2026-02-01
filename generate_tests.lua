#!/usr/bin/env lua
--- Test generation script for color conversion chain functions
--- This script generates test files for all chain conversion functions

local lfs = require 'lfs'  -- LuaFileSystem for directory operations

-- Define the color spaces and their formats (same as in generate_chains.lua)
local SPACES = {
    rgb = { formats = {'rgb8', 'hex24', 'rgb100'}, normalized = 'rgb' },
    hsv = { formats = {'hsv', 'hsv360'}, normalized = 'hsv' },
    hsl = { formats = {'hsl', 'hsl360'}, normalized = 'hsl' },
    cct = { formats = {'cctk', 'cctm'}, normalized = 'cctk' },
    xyy = { formats = {'xyy'}, normalized = 'xyy' }
}

-- Generate all possible conversion pairs (same as in generate_chains.lua)
local function generate_all_pairs()
    local spaces_list = {}
    for space in pairs(SPACES) do
        table.insert(spaces_list, space)
    end
    table.sort(spaces_list)  -- For deterministic order
    local pairs = {}
    for i = 1, #spaces_list - 1 do
        for j = i + 1, #spaces_list do
            table.insert(pairs, {spaces_list[i], spaces_list[j]})
        end
    end
    return pairs
end

local CONVERSION_PAIRS = generate_all_pairs()

-- Get conversions for a module
local function get_module_conversions(module_name)
    local modules = {}

    for _, pair in ipairs(CONVERSION_PAIRS) do
        local from_space, to_space = pair[1], pair[2]
        local name1 = from_space .. '_' .. to_space
        local name2 = to_space .. '_' .. from_space

        -- Get all format combinations for this conversion pair
        local conversions = {}
        local from_formats = SPACES[from_space].formats
        local to_formats = SPACES[to_space].formats

        for _, from_fmt in ipairs(from_formats) do
            for _, to_fmt in ipairs(to_formats) do
                table.insert(conversions, {
                    from = from_fmt,
                    to = to_fmt,
                    from_space = from_space,
                    to_space = to_space
                })
            end
        end

        -- Add normalized pass-through functions (only for RGB-centric pairs)
        if from_space == 'rgb' or to_space == 'rgb' then
            table.insert(conversions, {
                from = SPACES[from_space].normalized,
                to = SPACES[to_space].normalized,
                from_space = from_space,
                to_space = to_space
            })
            table.insert(conversions, {
                from = SPACES[to_space].normalized,
                to = SPACES[from_space].normalized,
                from_space = to_space,
                to_space = from_space
            })
        end

        modules[name1] = conversions
        -- Also populate the reverse direction with the same conversions
        -- (since the module contains bidirectional conversions)
        modules[name2] = conversions
    end

    return modules[module_name] or {}
end

-- Define test data for different color spaces
local TEST_DATA = {
    rgb = {
        {0, 0, 0},        -- Black
        {1, 1, 1},        -- White
        {1, 0, 0},        -- Red
        {0, 1, 0},        -- Green
        {0, 0, 1},        -- Blue
        {1, 1, 0},        -- Yellow
        {1, 0, 1},        -- Magenta
        {0, 1, 1},        -- Cyan
        {0.5, 0.5, 0.5},  -- Gray
        {0.2, 0.7, 0.9}   -- Random color
    },
    hsv = {
        {0, 0, 0},        -- Black
        {0, 0, 1},        -- White
        {0, 1, 1},        -- Red
        {0.333, 1, 1},    -- Green
        {0.667, 1, 1},    -- Blue
        {0.167, 1, 1},    -- Yellow
        {0.833, 1, 1},    -- Magenta
        {0.5, 1, 1},      -- Cyan
        {0, 0, 0.5},      -- Gray
        {0.1, 0.8, 0.6}   -- Random color
    },
    hsl = {
        {0, 0, 0},        -- Black
        {0, 0, 1},        -- White
        {0, 1, 0.5},      -- Red
        {0.333, 1, 0.5},  -- Green
        {0.667, 1, 0.5},  -- Blue
        {0.167, 1, 0.5},  -- Yellow
        {0.833, 1, 0.5},  -- Magenta
        {0.5, 1, 0.5},    -- Cyan
        {0, 0, 0.5},      -- Gray
        {0.2, 0.9, 0.4}   -- Random color
    },
    cct = {
        1000, 1500, 2000, 2500, 3000, 3500, 4000, 5000, 6500, 10000
    },
    xyy = {
        {0.3127, 0.3290, 1.0},    -- D65 white
        {0.3333, 0.3333, 1.0},    -- Equal energy white
        {0.6400, 0.3300, 1.0},    -- Red primary
        {0.3000, 0.6000, 1.0},    -- Green primary
        {0.1500, 0.0600, 1.0},    -- Blue primary
        {0.3127, 0.3290, 0.5},    -- D65 at half brightness
        {0.2000, 0.4000, 0.8},    -- Random point
        {0.1000, 0.2000, 0.3},    -- Another random point
        {0.5000, 0.3000, 0.9},    -- High luminance
        {0.4000, 0.5000, 0.1}     -- Low luminance
    }
}

-- Format conversion functions for test data
local FORMAT_CONVERTERS = {
    rgb8 = {
        to = function(r, g, b)
            return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)
        end,
        from = function(r, g, b) return r / 255, g / 255, b / 255 end
    },
    rgb100 = {
        to = function(r, g, b)
            return math.floor(r * 100 + 0.5), math.floor(g * 100 + 0.5), math.floor(b * 100 + 0.5)
        end,
        from = function(r, g, b) return r / 100, g / 100, b / 100 end
    },
    hsv360 = {
        to = function(h, s, v) return h * 360, s, v end,
        from = function(h, s, v) return h / 360, s, v end
    },
    hsl360 = {
        to = function(h, s, l) return h * 360, s, l end,
        from = function(h, s, l) return h / 360, s, l end
    },
    cctm = {
        to = function(k) return math.floor(1000000 / k + 0.5) end,
        from = function(m) return 1000000 / m end
    }
}

-- Generate test code for a chain conversion
-- Generate test code for a module
local function generate_test_code(module_name)
    local conversions = get_module_conversions(module_name)

    local lines = {}

    table.insert(lines, string.format("describe('%s conversions', function()", module_name:gsub('_', ' ↔ ')))
    table.insert(lines, "")

    -- Generate test cases for each conversion
    for _, conv in ipairs(conversions) do
        local from_fmt, to_fmt = conv.from, conv.to
        local func_name = string.format("%s_to_%s", from_fmt, to_fmt)

        table.insert(lines, string.format("    describe('%s', function()", func_name))
        table.insert(lines, "")

        -- Get appropriate test data for the input format
        local test_data = TEST_DATA[conv.from_space]
        if FORMAT_CONVERTERS[from_fmt] and FORMAT_CONVERTERS[from_fmt].to and from_fmt ~= 'hex24' then
            -- Convert test data to the specific format
            test_data = {}
            for _, input in ipairs(TEST_DATA[conv.from_space]) do
                if type(input) == 'table' then
                    table.insert(test_data, {FORMAT_CONVERTERS[from_fmt].to(table.unpack(input))})
                else
                    table.insert(test_data, FORMAT_CONVERTERS[from_fmt].to(input))
                end
            end
        elseif from_fmt == conv.from_space then
            -- This is a normalized function, use raw test data
            test_data = TEST_DATA[conv.from_space]
        end

        -- Generate individual test cases
        for i, input in ipairs(test_data) do
            local input_str
            if type(input) == 'table' then
                input_str = table.concat(input, ', ')
            else
                input_str = tostring(input)
            end

            table.insert(lines, string.format("        it('converts test case %d', function()", i))

            -- Generate the function call and assertions based on output format
            local multi_output = to_fmt == 'xyy' or to_fmt:match('^rgb') or
                                to_fmt == 'hsv' or to_fmt == 'hdsv' or to_fmt == 'hsl'
            if multi_output then
                local result_str = string.format("            local result = {convert.%s(%s)}",
                                                func_name, input_str)
                table.insert(lines, result_str)
                table.insert(lines, "")
                table.insert(lines, "            -- Verify results are not nil")
                table.insert(lines, "            assert.is_not_nil(result[1])")
                table.insert(lines, "            assert.is_not_nil(result[2])")
                table.insert(lines, "            assert.is_not_nil(result[3])")
                table.insert(lines, "            assert.is_number(result[1])")
                table.insert(lines, "            assert.is_number(result[2])")
                table.insert(lines, "            assert.is_number(result[3])")
                -- Add range validation based on output format
                if to_fmt == 'xyy' then
                    table.insert(lines, "            -- xyY should have x,y in 0-1 range, Y >= 0")
                    table.insert(lines, "            assert.is_true(result[1] >= 0 and result[1] <= 1)")
                    table.insert(lines, "            assert.is_true(result[2] >= 0 and result[2] <= 1)")
                    table.insert(lines, "            assert.is_true(result[3] >= 0)")
                elseif to_fmt == 'rgb8' then
                    table.insert(lines, "            -- RGB8 should be integers in 0-255 range")
                    table.insert(lines, "            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and")
                    table.insert(lines, "                result[1] <= 255)")
                    table.insert(lines, "            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and")
                    table.insert(lines, "                result[2] <= 255)")
                    table.insert(lines, "            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and")
                    table.insert(lines, "                result[3] <= 255)")
                elseif to_fmt == 'rgb100' then
                    table.insert(lines, "            -- RGB100 should be in 0-100 range")
                    table.insert(lines, "            assert.is_true(result[1] >= 0 and result[1] <= 100)")
                    table.insert(lines, "            assert.is_true(result[2] >= 0 and result[2] <= 100)")
                    table.insert(lines, "            assert.is_true(result[3] >= 0 and result[3] <= 100)")
                elseif to_fmt:match('^rgb') then
                    table.insert(lines, "            -- RGB should be in 0-1 range")
                    table.insert(lines, "            assert.is_true(result[1] >= 0 and result[1] <= 1)")
                    table.insert(lines, "            assert.is_true(result[2] >= 0 and result[2] <= 1)")
                    table.insert(lines, "            assert.is_true(result[3] >= 0 and result[3] <= 1)")
                elseif to_fmt == 'hsv' or to_fmt == 'hsl' then
                    table.insert(lines, string.format("            -- %s should have H in 0-1, S,V/L in",
                        to_fmt:upper()) .. " 0-1 range")
                    table.insert(lines, "            assert.is_true(result[1] >= 0 and result[1] <= 1)")
                    table.insert(lines, "            assert.is_true(result[2] >= 0 and result[2] <= 1)")
                    table.insert(lines, "            assert.is_true(result[3] >= 0 and result[3] <= 1)")
                end
            elseif to_fmt:match('^cct') then
                table.insert(lines, string.format("            local result = convert.%s(%s)",
                                                 func_name, input_str))
                table.insert(lines, "")
                table.insert(lines, "            -- Verify result is not nil")
                table.insert(lines, "            assert.is_not_nil(result)")
                table.insert(lines, "            assert.is_number(result)")
                table.insert(lines, "            -- CCT should be positive")
                table.insert(lines, "            assert.is_true(result > 0)")
            end

            table.insert(lines, "        end)")
            table.insert(lines, "")
        end

        table.insert(lines, "    end)")
        table.insert(lines, "")
    end

    table.insert(lines, "end)")

    return table.concat(lines, '\n')
end

-- Generate the full test file content
local function generate_test_file(module_name)
    local lines = {}

    -- Header
    table.insert(lines, string.format("--- Test specifications for %s conversion module", module_name:gsub('_', ' ↔ ')))
    table.insert(lines, "")
    table.insert(lines, "local convert = require 'color.convert." .. module_name .. "'")
    table.insert(lines, "")

    -- Test code
    table.insert(lines, generate_test_code(module_name))

    return table.concat(lines, '\n')
end

-- Main generation function
-- Main generation function
local function main()
    if arg[1] ~= '--generate' then
        print("Usage: lua generate_tests.lua --generate")
        print("This will generate test files for all grouped conversion modules in the spec/convert/ directory")
        return
    end

    -- Get all conversion modules that exist
    local modules = {}
    local conversions_dir = 'color/convert'
    for file in lfs.dir(conversions_dir) do
        if file:match('%.lua$') then
            local module_name = file:match('^(.-)%.lua$')
            if module_name then
                table.insert(modules, module_name)
            end
        end
    end

    print(string.format("Generating %d test files for conversion modules...", #modules))

    -- Create spec directories if they don't exist
    lfs.mkdir('spec')
    lfs.mkdir('spec/convert')

    for _, module_name in ipairs(modules) do
        local filename = string.format("spec/convert/%s_spec.lua", module_name)
        local content = generate_test_file(module_name)

        local file = io.open(filename, 'w')
        if file then
            file:write(content)
            file:close()
            print(string.format("Generated %s", filename))
        else
            print(string.format("Error: Could not write %s", filename))
        end
    end

    print("Test generation complete!")
end

main()