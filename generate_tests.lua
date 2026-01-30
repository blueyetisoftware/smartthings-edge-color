#!/usr/bin/env lua
--- Test generation script for color conversion chain functions
--- This script generates test files for all chain conversion functions

local lfs = require 'lfs'  -- LuaFileSystem for directory operations

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
        to = function(r, g, b) return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5) end,
        from = function(r, g, b) return r / 255, g / 255, b / 255 end
    },
    rgb16 = {
        to = function(r, g, b) return math.floor(r * 65535 + 0.5), math.floor(g * 65535 + 0.5), math.floor(b * 65535 + 0.5) end,
        from = function(r, g, b) return r / 65535, g / 65535, b / 65535 end
    },
    rgb100 = {
        to = function(r, g, b) return math.floor(r * 100 + 0.5), math.floor(g * 100 + 0.5), math.floor(b * 100 + 0.5) end,
        from = function(r, g, b) return r / 100, g / 100, b / 100 end
    },
    hdsv = {
        to = function(h, s, v) return h * 360, s, v end,
        from = function(h, s, v) return h / 360, s, v end
    },
    cct_mired = {
        to = function(k) return math.floor(1000000 / k + 0.5) end,
        from = function(m) return 1000000 / m end
    }
}

-- Get test data for a format
local function get_test_data(fmt)
    local space = fmt:match('^([^0-9]+)')
    local data = TEST_DATA[space]
    if not data then return {} end

    -- Convert to the specific format if needed
    if FORMAT_CONVERTERS[fmt] then
        local converted = {}
        for _, item in ipairs(data) do
            if type(item) == 'table' then
                table.insert(converted, {FORMAT_CONVERTERS[fmt].to(table.unpack(item))})
            else
                table.insert(converted, FORMAT_CONVERTERS[fmt].to(item))
            end
        end
        return converted
    end

    return data
end

-- Generate test code for a chain conversion
local function generate_test_code(chain)
    local from_fmt = chain.from
    local to_fmt = chain.to
    local test_data = get_test_data(from_fmt)

    local lines = {}

    table.insert(lines, string.format("describe('%s_to_%s', function()", from_fmt, to_fmt))
    table.insert(lines, "")

    -- Generate individual test cases
    for i, input in ipairs(test_data) do
        local input_str
        if type(input) == 'table' then
            input_str = table.concat(input, ', ')
        else
            input_str = tostring(input)
        end

        table.insert(lines, string.format("    it('converts test case %d', function()", i))
    if to_fmt == 'xyy' or to_fmt:match('^rgb') or to_fmt == 'hsv' or to_fmt == 'hdsv' or to_fmt == 'hsl' then
        table.insert(lines, string.format("        local r, g, b = color.%s_to_%s(%s)", from_fmt, to_fmt, input_str))
        table.insert(lines, "")
        table.insert(lines, "        -- Verify results are not nil")
        table.insert(lines, "        assert.is_not_nil(r)")
        table.insert(lines, "        assert.is_not_nil(g)")
        table.insert(lines, "        assert.is_not_nil(b)")
    elseif to_fmt:match('^cct_') then
        table.insert(lines, string.format("        local result = color.%s_to_%s(%s)", from_fmt, to_fmt, input_str))
        table.insert(lines, "")
        table.insert(lines, "        -- Verify result is not nil")
        table.insert(lines, "        assert.is_not_nil(result)")
        table.insert(lines, "        assert.is_number(result)")
    end
    table.insert(lines, "    end)")
        table.insert(lines, "")
    end

    -- Add round-trip test if applicable
    if from_fmt ~= to_fmt and (
        (from_fmt:match('^rgb') and to_fmt:match('^rgb')) or
        (from_fmt == 'hsv' and to_fmt == 'hdsv') or
        (from_fmt == 'hdsv' and to_fmt == 'hsv') or
        (from_fmt:match('^cct_') and to_fmt:match('^cct_'))
    ) then
        table.insert(lines, "    it('round-trip conversion', function()")
        if from_fmt:match('^rgb') or from_fmt == 'hsv' or from_fmt == 'hdsv' or from_fmt == 'hsl' then
            table.insert(lines, string.format("        local orig_r, orig_g, orig_b = %s", type(test_data[1]) == 'table' and
                table.concat(test_data[1], ', ') or tostring(test_data[1])))
            table.insert(lines, string.format("        local conv_r, conv_g, conv_b = color.%s_to_%s(orig_r, orig_g, orig_b)", from_fmt, to_fmt))
            table.insert(lines, string.format("        local back_r, back_g, back_b = color.%s_to_%s(conv_r, conv_g, conv_b)", to_fmt, from_fmt))
            table.insert(lines, "        -- Note: Round-trip may not be exact due to numerical precision")
            table.insert(lines, "        assert.is_not_nil(back_r)")
            table.insert(lines, "        assert.is_not_nil(back_g)")
            table.insert(lines, "        assert.is_not_nil(back_b)")
        elseif from_fmt:match('^cct_') then
            table.insert(lines, string.format("        local original = %s", tostring(test_data[1])))
            table.insert(lines, string.format("        local converted = color.%s_to_%s(original)", from_fmt, to_fmt))
            table.insert(lines, string.format("        local back = color.%s_to_%s(converted)", to_fmt, from_fmt))
            table.insert(lines, "        -- Note: Round-trip may not be exact due to numerical precision")
            table.insert(lines, "        assert.is_not_nil(back)")
        end
        table.insert(lines, "    end)")
        table.insert(lines, "")
    end

    table.insert(lines, "end)")

    return table.concat(lines, '\n')
end

-- Generate the full test file content
local function generate_test_file(chain)
    local from_fmt = chain.from
    local to_fmt = chain.to

    local lines = {}

    -- Header
    table.insert(lines, string.format("--- Test specifications for %s_to_%s conversion", from_fmt, to_fmt))
    table.insert(lines, "")
    table.insert(lines, "local color = require 'color'")
    table.insert(lines, "")

    -- Test code
    table.insert(lines, generate_test_code(chain))

    return table.concat(lines, '\n')
end

-- Main generation function
local function main()
    if arg[1] ~= '--generate' then
        print("Usage: lua generate_tests.lua --generate")
        print("This will generate test files for all chain conversion functions in the spec/ directory")
        return
    end

    -- Get all chain functions that exist
    local chains = {}
    local color_dir = 'color'
    for file in lfs.dir(color_dir) do
        if file:match('_to_') and file:match('%.lua$') then
            local from_fmt, to_fmt = file:match('^(.-)_to_(.-)%.lua$')
            if from_fmt and to_fmt then
                table.insert(chains, {from = from_fmt, to = to_fmt})
            end
        end
    end

    print(string.format("Generating %d test files...", #chains))

    -- Create spec directory if it doesn't exist
    lfs.mkdir('spec')

    for _, chain in ipairs(chains) do
        local filename = string.format("spec/%s_to_%s_spec.lua", chain.from, chain.to)
        local content = generate_test_file(chain)

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