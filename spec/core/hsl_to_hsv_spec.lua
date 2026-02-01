--- Test specifications for hsl_to_hsv conversion

local hsl_to_hsv = require 'color.core.hsl_to_hsv'
local spec_helper = require 'spec.spec_helper'

describe('hsl_to_hsv', function()

    it('converts pure red HSL to HSV', function()
        local h, s, v = hsl_to_hsv(0, 1, 0.5)
        assert.are.equal(h, 0)
        assert.are.equal(s, 1)
        spec_helper.assert_near(v, 1, 1e-6)
    end)

    it('converts pure green HSL to HSV', function()
        local h, s, v = hsl_to_hsv(1/3, 1, 0.5)
        assert.are.equal(h, 1/3)
        assert.are.equal(s, 1)
        spec_helper.assert_near(v, 1, 1e-6)
    end)

    it('converts pure blue HSL to HSV', function()
        local h, s, v = hsl_to_hsv(2/3, 1, 0.5)
        assert.are.equal(h, 2/3)
        assert.are.equal(s, 1)
        spec_helper.assert_near(v, 1, 1e-6)
    end)

    it('converts white HSL to HSV', function()
        local h, s, v = hsl_to_hsv(0, 0, 1)
        assert.are.equal(h, 0)  -- Hue is preserved
        assert.are.equal(s, 0)
        spec_helper.assert_near(v, 1, 1e-6)
    end)

    it('converts black HSL to HSV', function()
        local h, s, v = hsl_to_hsv(0, 0, 0)
        assert.are.equal(h, 0)  -- Hue is preserved
        assert.are.equal(s, 0)
        spec_helper.assert_near(v, 0, 1e-6)
    end)

    it('converts gray HSL to HSV', function()
        local h, s, v = hsl_to_hsv(0, 0, 0.5)
        assert.are.equal(h, 0)  -- Hue is preserved
        assert.are.equal(s, 0)
        spec_helper.assert_near(v, 0.5, 1e-6)
    end)

    it('converts saturated color with medium lightness', function()
        local h, s, v = hsl_to_hsv(0.1, 1, 0.4)
        spec_helper.assert_near(h, 0.1, 1e-6)
        spec_helper.assert_near(s, 1, 1e-6)
        spec_helper.assert_near(v, 0.8, 1e-6)  -- 0.4 + 0.4 * 1 = 0.8
    end)

    it('handles edge case with very low saturation', function()
        local h, s, v = hsl_to_hsv(0.5, 0.01, 0.8)
        spec_helper.assert_near(h, 0.5, 1e-6)
        spec_helper.assert_near(s, 0.004988, 1e-5)  -- 2 * (1 - 0.8/0.802) ≈ 2 * 0.002494
        spec_helper.assert_near(v, 0.802, 1e-3)  -- 0.8 + 0.01 * min(0.8, 0.2)
    end)

end)