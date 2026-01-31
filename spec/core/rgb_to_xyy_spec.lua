--- Test specifications for rgb_to_xyy conversion

local rgb_to_xyy = require 'color.core.rgb_to_xyy'
local spec_helper = require 'spec.spec_helper'

describe('rgb_to_xyy', function()

    it('converts pure red RGB to xyY', function()
        local x, y, Y = rgb_to_xyy(1, 0, 0)
        spec_helper.assert_near(x, 0.64, 1e-1)
        spec_helper.assert_near(y, 0.33, 1e-1)
        spec_helper.assert_near(Y, 0.21, 1e-1)
    end)

    it('converts pure green RGB to xyY', function()
        local x, y, Y = rgb_to_xyy(0, 1, 0)
        spec_helper.assert_near(x, 0.30, 1e-1)
        spec_helper.assert_near(y, 0.60, 1e-1)
        spec_helper.assert_near(Y, 0.72, 1e-1)
    end)

    it('converts pure blue RGB to xyY', function()
        local x, y, Y = rgb_to_xyy(0, 0, 1)
        spec_helper.assert_near(x, 0.15, 1e-1)
        spec_helper.assert_near(y, 0.06, 1e-1)
        spec_helper.assert_near(Y, 0.07, 1e-1)
    end)

    it('converts white RGB to xyY', function()
        local x, y, Y = rgb_to_xyy(1, 1, 1)
        spec_helper.assert_near(x, 0.3127, 1e-2)
        spec_helper.assert_near(y, 0.3290, 1e-2)
        spec_helper.assert_near(Y, 1, 1e-6)
    end)

    it('converts black RGB to xyY', function()
        local _, _, Y = rgb_to_xyy(0, 0, 0)
        -- Black has undefined chromaticity, but often returns D65 white point
        spec_helper.assert_near(Y, 0, 1e-6)
    end)

    it('converts cyan RGB to xyY', function()
        local x, y, Y = rgb_to_xyy(0, 1, 1)
        spec_helper.assert_near(x, 0.225, 1e-1)
        spec_helper.assert_near(y, 0.329, 1e-1)
        spec_helper.assert_near(Y, 0.79, 1e-1)
    end)

    it('converts magenta RGB to xyY', function()
        local x, y, Y = rgb_to_xyy(1, 0, 1)
        spec_helper.assert_near(x, 0.40, 1e-1)
        spec_helper.assert_near(y, 0.20, 1e-1)
        spec_helper.assert_near(Y, 0.28, 1e-1)
    end)
end)