--- Test specifications for hsv_to_hsl conversion

local hsv_to_hsl = require 'color.core.hsv_to_hsl'
local spec_helper = require 'spec.spec_helper'

describe('hsv_to_hsl', function()

    it('converts pure red HSV to HSL', function()
        local h, s, l = hsv_to_hsl(0, 1, 1)
        assert.are.equal(h, 0)
        assert.are.equal(s, 1)
        spec_helper.assert_near(l, 0.5, 1e-6)
    end)

    it('converts pure green HSV to HSL', function()
        local h, s, l = hsv_to_hsl(1/3, 1, 1)
        assert.are.equal(h, 1/3)
        assert.are.equal(s, 1)
        spec_helper.assert_near(l, 0.5, 1e-6)
    end)

    it('converts pure blue HSV to HSL', function()
        local h, s, l = hsv_to_hsl(2/3, 1, 1)
        assert.are.equal(h, 2/3)
        assert.are.equal(s, 1)
        spec_helper.assert_near(l, 0.5, 1e-6)
    end)

    it('converts white HSV to HSL', function()
        local h, s, l = hsv_to_hsl(0, 0, 1)
        assert.are.equal(h, 0)  -- Hue is preserved
        assert.are.equal(s, 0)
        spec_helper.assert_near(l, 1, 1e-6)
    end)

    it('converts black HSV to HSL', function()
        local h, s, l = hsv_to_hsl(0, 0, 0)
        assert.are.equal(h, 0)  -- Hue is preserved
        assert.are.equal(s, 0)
        spec_helper.assert_near(l, 0, 1e-6)
    end)

    it('converts gray HSV to HSL', function()
        local h, s, l = hsv_to_hsl(0, 0, 0.5)
        assert.are.equal(h, 0)  -- Hue is preserved
        assert.are.equal(s, 0)
        spec_helper.assert_near(l, 0.5, 1e-6)
    end)

    it('converts saturated color with medium value', function()
        local h, s, l = hsv_to_hsl(0.1, 0.8, 0.6)
        spec_helper.assert_near(h, 0.1, 1e-6)
        spec_helper.assert_near(s, 0.666667, 1e-6)  -- (0.6 * 0.8) / (1 - |2*0.36 - 1|) = 0.48 / 0.72
        spec_helper.assert_near(l, 0.36, 1e-6)  -- 0.6 * (1 - 0.8/2)
    end)

    it('handles edge case with very low saturation', function()
        local h, s, l = hsv_to_hsl(0.5, 0.01, 0.8)
        spec_helper.assert_near(h, 0.5, 1e-6)
        spec_helper.assert_near(s, 0.019608, 1e-5)  -- (0.8 * 0.01) / (1 - |2*0.796 - 1|) ≈ 0.008 / 0.408
        spec_helper.assert_near(l, 0.796, 1e-3)  -- 0.8 * (1 - 0.01/2)
    end)

end)