--- Test specifications for rgb_to_hsv conversion

local color = require 'color'

describe('rgb_to_hsv', function()

    it('converts test case 1', function()
        local r, g, b = color.rgb_to_hsv(0, 0, 0)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 2', function()
        local r, g, b = color.rgb_to_hsv(1, 1, 1)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 3', function()
        local r, g, b = color.rgb_to_hsv(1, 0, 0)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 4', function()
        local r, g, b = color.rgb_to_hsv(0, 1, 0)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 5', function()
        local r, g, b = color.rgb_to_hsv(0, 0, 1)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 6', function()
        local r, g, b = color.rgb_to_hsv(1, 1, 0)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 7', function()
        local r, g, b = color.rgb_to_hsv(1, 0, 1)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 8', function()
        local r, g, b = color.rgb_to_hsv(0, 1, 1)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 9', function()
        local r, g, b = color.rgb_to_hsv(0.5, 0.5, 0.5)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 10', function()
        local r, g, b = color.rgb_to_hsv(0.2, 0.7, 0.9)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

end)