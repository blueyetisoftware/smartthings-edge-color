--- Test specifications for hsv_to_rgb conversion

local hsv_to_rgb = require 'color.core.hsv_to_rgb'
local spec_helper = require 'spec.spec_helper'

describe('hsv_to_rgb', function()

    it('converts pure red HSV to RGB', function()
        local r, g, b = hsv_to_rgb(0, 1, 1)
        spec_helper.assert_near(r, 1, 1e-6)
        spec_helper.assert_near(g, 0, 1e-6)
        spec_helper.assert_near(b, 0, 1e-6)
    end)

    it('converts pure green HSV to RGB', function()
        local r, g, b = hsv_to_rgb(1/3, 1, 1)
        spec_helper.assert_near(r, 0, 1e-6)
        spec_helper.assert_near(g, 1, 1e-6)
        spec_helper.assert_near(b, 0, 1e-6)
    end)

    it('converts pure blue HSV to RGB', function()
        local r, g, b = hsv_to_rgb(2/3, 1, 1)
        spec_helper.assert_near(r, 0, 1e-6)
        spec_helper.assert_near(g, 0, 1e-6)
        spec_helper.assert_near(b, 1, 1e-6)
    end)

    it('converts white HSV to RGB', function()
        local r, g, b = hsv_to_rgb(0, 0, 1)
        spec_helper.assert_near(r, 1, 1e-6)
        spec_helper.assert_near(g, 1, 1e-6)
        spec_helper.assert_near(b, 1, 1e-6)
    end)

    it('converts black HSV to RGB', function()
        local r, g, b = hsv_to_rgb(0, 0, 0)
        spec_helper.assert_near(r, 0, 1e-6)
        spec_helper.assert_near(g, 0, 1e-6)
        spec_helper.assert_near(b, 0, 1e-6)
    end)

    it('converts cyan HSV to RGB', function()
        local r, g, b = hsv_to_rgb(0.5, 1, 1)
        spec_helper.assert_near(r, 0, 1e-6)
        spec_helper.assert_near(g, 1, 1e-6)
        spec_helper.assert_near(b, 1, 1e-6)
    end)

    it('converts magenta HSV to RGB', function()
        local r, g, b = hsv_to_rgb(5/6, 1, 1)
        spec_helper.assert_near(r, 1, 1e-6)
        spec_helper.assert_near(g, 0, 1e-6)
        spec_helper.assert_near(b, 1, 1e-6)
    end)

    it('converts yellow HSV to RGB', function()
        local r, g, b = hsv_to_rgb(1/6, 1, 1)
        spec_helper.assert_near(r, 1, 1e-6)
        spec_helper.assert_near(g, 1, 1e-6)
        spec_helper.assert_near(b, 0, 1e-6)
    end)

    it('defaults value to 1.0 when omitted', function()
        local r1, g1, b1 = hsv_to_rgb(0, 1, 1)
        local r2, g2, b2 = hsv_to_rgb(0, 1)
        spec_helper.assert_near(r1, r2, 1e-10)
        spec_helper.assert_near(g1, g2, 1e-10)
        spec_helper.assert_near(b1, b2, 1e-10)
    end)
end)