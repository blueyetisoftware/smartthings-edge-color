--- Test specifications for cct_to_rgb conversion

local cct_to_rgb = require 'color.core.cct_to_rgb'
local spec_helper = require 'spec.spec_helper'

describe('cct_to_rgb', function()

    it('converts 3000K CCT to RGB with tolerance', function()
        local r, g, b = cct_to_rgb(3000)
        spec_helper.assert_rgb_near(r, g, b, 255/255, 180/255, 108/255, 0.01)
    end)

    it('converts 10000K CCT to RGB with tolerance', function()
        local r, g, b = cct_to_rgb(10000)
        spec_helper.assert_rgb_near(r, g, b, 204/255, 220/255, 255/255, 0.01)
    end)

    it('converts 1500K CCT to RGB with tolerance', function()
        local r, g, b = cct_to_rgb(1500)
        spec_helper.assert_rgb_near(r, g, b, 255/255, 107/255, 0/255, 0.01)
    end)

    it('handles minimum CCT (1000K)', function()
        local r, g, b = cct_to_rgb(1000)
        assert.is_true(r >= 0 and r <= 1)
        assert.is_true(g >= 0 and g <= 1)
        assert.is_true(b >= 0 and b <= 1)
    end)

    it('handles maximum CCT (40000K)', function()
        local r, g, b = cct_to_rgb(40000)
        assert.is_true(r >= 0 and r <= 1)
        assert.is_true(g >= 0 and g <= 1)
        assert.is_true(b >= 0 and b <= 1)
    end)
end)