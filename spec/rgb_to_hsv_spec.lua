local rgb_to_hsv = require 'color.rgb_to_hsv'
local spec_helper = require 'spec.spec_helper'

describe("rgb_to_hsv", function()
  it("converts pure red RGB to HSV", function()
    local h, s, v = rgb_to_hsv(1, 0, 0)
    spec_helper.assert_near(h, 0, 1e-6)
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(v, 1, 1e-6)
  end)

  it("converts pure green RGB to HSV", function()
    local h, s, v = rgb_to_hsv(0, 1, 0)
    spec_helper.assert_near(h, 1/3, 1e-3) -- Allow some tolerance for hue
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(v, 1, 1e-6)
  end)

  it("converts pure blue RGB to HSV", function()
    local h, s, v = rgb_to_hsv(0, 0, 1)
    spec_helper.assert_near(h, 2/3, 1e-3)
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(v, 1, 1e-6)
  end)

  it("converts white RGB to HSV", function()
    local h, s, v = rgb_to_hsv(1, 1, 1)
    spec_helper.assert_near(h, 0, 1e-6)  -- Hue is 0 for achromatic colors
    spec_helper.assert_near(s, 0, 1e-6)
    spec_helper.assert_near(v, 1, 1e-6)
  end)

  it("converts black RGB to HSV", function()
    local h, s, v = rgb_to_hsv(0, 0, 0)
    spec_helper.assert_near(h, 0, 1e-6)  -- Hue is 0 for achromatic colors
    spec_helper.assert_near(s, 0, 1e-6)
    spec_helper.assert_near(v, 0, 1e-6)
  end)

  it("converts gray RGB to HSV", function()
    local h, s, v = rgb_to_hsv(0.5, 0.5, 0.5)
    spec_helper.assert_near(h, 0, 1e-6)  -- Hue is 0 for achromatic colors
    spec_helper.assert_near(s, 0, 1e-6)
    spec_helper.assert_near(v, 0.5, 1e-6)
  end)

  it("converts cyan RGB to HSV", function()
    local h, s, v = rgb_to_hsv(0, 1, 1)
    spec_helper.assert_near(h, 0.5, 1e-3)
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(v, 1, 1e-6)
  end)

  it("converts magenta RGB to HSV", function()
    local h, s, v = rgb_to_hsv(1, 0, 1)
    spec_helper.assert_near(h, 5/6, 1e-3)
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(v, 1, 1e-6)
  end)

  it("converts yellow RGB to HSV", function()
    local h, s, v = rgb_to_hsv(1, 1, 0)
    spec_helper.assert_near(h, 1/6, 1e-3)
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(v, 1, 1e-6)
  end)

  it("converts dim red RGB to HSV", function()
    local h, s, v = rgb_to_hsv(0.5, 0, 0)
    spec_helper.assert_near(h, 0, 1e-6)
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(v, 0.5, 1e-6)
  end)

  it("clamps input values", function()
    local h, s, v = rgb_to_hsv(-0.1, 1.1, 0.5)
    spec_helper.assert_near(h, 1/3, 0.1) -- Greenish
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(v, 1, 1e-6)
  end)

  it("rejects non-number inputs", function()
    assert.has_error(function() rgb_to_hsv("red", 0, 0) end)
    assert.has_error(function() rgb_to_hsv(1, "green", 0) end)
    assert.has_error(function() rgb_to_hsv(1, 0, "blue") end)
  end)
end)