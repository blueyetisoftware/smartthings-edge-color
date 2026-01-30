--- Test specifications for cct_to_rgb conversion

local color = require 'color'

describe('cct_to_rgb', function()

    it('converts test case 1', function()
        local r, g, b = color.cct_to_rgb(1000)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 2', function()
        local r, g, b = color.cct_to_rgb(1500)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 3', function()
        local r, g, b = color.cct_to_rgb(2000)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 4', function()
        local r, g, b = color.cct_to_rgb(2500)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 5', function()
        local r, g, b = color.cct_to_rgb(3000)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 6', function()
        local r, g, b = color.cct_to_rgb(3500)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 7', function()
        local r, g, b = color.cct_to_rgb(4000)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 8', function()
        local r, g, b = color.cct_to_rgb(5000)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 9', function()
        local r, g, b = color.cct_to_rgb(6500)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

    it('converts test case 10', function()
        local r, g, b = color.cct_to_rgb(10000)

        -- Verify results are not nil
        assert.is_not_nil(r)
        assert.is_not_nil(g)
        assert.is_not_nil(b)
    end)

end)