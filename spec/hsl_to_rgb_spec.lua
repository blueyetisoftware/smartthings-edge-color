--- Test specifications for hsl_to_rgb conversion

local color = require 'color'

describe('hsl_to_rgb', function()

    it('converts test case 1', function()
        local r, g, b = color.hsl_to_rgb(0, 0, 0)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 2', function()
        local r, g, b = color.hsl_to_rgb(0, 0, 1)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 3', function()
        local r, g, b = color.hsl_to_rgb(0, 1, 0.5)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 4', function()
        local r, g, b = color.hsl_to_rgb(0.333, 1, 0.5)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 5', function()
        local r, g, b = color.hsl_to_rgb(0.667, 1, 0.5)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 6', function()
        local r, g, b = color.hsl_to_rgb(0.167, 1, 0.5)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 7', function()
        local r, g, b = color.hsl_to_rgb(0.833, 1, 0.5)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 8', function()
        local r, g, b = color.hsl_to_rgb(0.5, 1, 0.5)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 9', function()
        local r, g, b = color.hsl_to_rgb(0, 0, 0.5)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 10', function()
        local r, g, b = color.hsl_to_rgb(0.2, 0.9, 0.4)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

end)