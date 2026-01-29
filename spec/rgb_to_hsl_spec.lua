local rgb_to_hsl = require 'color.rgb_to_hsl'
local spec_helper = require 'spec.spec_helper'

describe("rgb_to_hsl", function()
  it("converts pure red RGB to HSL", function()
    local h, s, l = rgb_to_hsl(1, 0, 0)
    spec_helper.assert_near(h, 0, 1e-6)
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(l, 0.5, 1e-6)
  end)

  it("converts pure green RGB to HSL", function()
    local h, s, l = rgb_to_hsl(0, 1, 0)
    spec_helper.assert_near(h, 1/3, 1e-3)  -- Standard green hue
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(l, 0.5, 1e-6)
  end)

  it("converts pure blue RGB to HSL", function()
    local h, s, l = rgb_to_hsl(0, 0, 1)
    spec_helper.assert_near(h, 2/3, 1e-3)  -- Standard blue hue
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(l, 0.5, 1e-6)
  end)

  it("converts white RGB to HSL", function()
    local _, s, l = rgb_to_hsl(1, 1, 1)
    spec_helper.assert_near(s, 0, 1e-6)
    spec_helper.assert_near(l, 1, 1e-6)
    -- Hue is undefined for grayscale, but often 0
  end)

  it("converts black RGB to HSL", function()
    local _, s, l = rgb_to_hsl(0, 0, 0)
    spec_helper.assert_near(s, 0, 1e-6)
    spec_helper.assert_near(l, 0, 1e-6)
  end)

  it("converts gray RGB to HSL", function()
    local _, s, l = rgb_to_hsl(0.5, 0.5, 0.5)
    spec_helper.assert_near(s, 0, 1e-6)
    spec_helper.assert_near(l, 0.5, 1e-6)
  end)

  it("converts cyan RGB to HSL", function()
    local h, s, l = rgb_to_hsl(0, 1, 1)
    spec_helper.assert_near(h, 0.5, 1e-3)
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(l, 0.5, 1e-6)
  end)

  it("converts magenta RGB to HSL", function()
    local h, s, l = rgb_to_hsl(1, 0, 1)
    spec_helper.assert_near(h, 5/6, 1e-3)
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(l, 0.5, 1e-6)
  end)

  it("converts yellow RGB to HSL", function()
    local h, s, l = rgb_to_hsl(1, 1, 0)
    spec_helper.assert_near(h, 1/6, 1e-3)
    spec_helper.assert_near(s, 1, 1e-6)
    spec_helper.assert_near(l, 0.5, 1e-6)
  end)
end)