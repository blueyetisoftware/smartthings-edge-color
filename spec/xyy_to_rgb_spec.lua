--- Test specifications for xyy_to_rgb conversion

local color = require 'color'

describe('xyy_to_rgb', function()

    it('converts test case 1', function()
        local r, g, b = color.xyy_to_rgb(0.3127, 0.329, 1.0)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 2', function()
        local r, g, b = color.xyy_to_rgb(0.3333, 0.3333, 1.0)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 3', function()
        local r, g, b = color.xyy_to_rgb(0.64, 0.33, 1.0)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 4', function()
        local r, g, b = color.xyy_to_rgb(0.3, 0.6, 1.0)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 5', function()
        local r, g, b = color.xyy_to_rgb(0.15, 0.06, 1.0)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 6', function()
        local r, g, b = color.xyy_to_rgb(0.3127, 0.329, 0.5)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 7', function()
        local r, g, b = color.xyy_to_rgb(0.2, 0.4, 0.8)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 8', function()
        local r, g, b = color.xyy_to_rgb(0.1, 0.2, 0.3)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 9', function()
        local r, g, b = color.xyy_to_rgb(0.5, 0.3, 0.9)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 10', function()
        local r, g, b = color.xyy_to_rgb(0.4, 0.5, 0.1)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

end)