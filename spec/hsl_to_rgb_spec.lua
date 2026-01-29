local hsl_to_rgb = require 'color.hsl_to_rgb'
local spec_helper = require 'spec.spec_helper'

describe("hsl_to_rgb", function()
  it("converts pure red HSL to RGB", function()
    local r, g, b = hsl_to_rgb(0, 1, 0.5)
    spec_helper.assert_rgb_near(r, g, b, 1, 0, 0)
  end)

  it("converts pure green HSL to RGB", function()
    local r, g, b = hsl_to_rgb(1/3, 1, 0.5)  -- Standard green hue
    spec_helper.assert_rgb_near(r, g, b, 0, 1, 0)
  end)

  it("converts pure blue HSL to RGB", function()
    local r, g, b = hsl_to_rgb(2/3, 1, 0.5)  -- Standard blue hue
    spec_helper.assert_rgb_near(r, g, b, 0, 0, 1)
  end)

  it("converts white HSL to RGB", function()
    local r, g, b = hsl_to_rgb(0, 0, 1)
    spec_helper.assert_rgb_near(r, g, b, 1, 1, 1)
  end)

  it("converts black HSL to RGB", function()
    local r, g, b = hsl_to_rgb(0, 0, 0)
    spec_helper.assert_rgb_near(r, g, b, 0, 0, 0)
  end)

  it("converts gray HSL to RGB", function()
    local r, g, b = hsl_to_rgb(0, 0, 0.5)
    spec_helper.assert_rgb_near(r, g, b, 0.5, 0.5, 0.5)
  end)

  it("handles nil lightness parameter", function()
    local r, g, b = hsl_to_rgb(0, 1)
    -- Should default to 0.5 lightness
    spec_helper.assert_rgb_near(r, g, b, 1, 0, 0)
  end)

  it("handles edge hue values", function()
    local r1, g1, b1 = hsl_to_rgb(0, 1, 0.5)
    local r2, g2, b2 = hsl_to_rgb(0.001, 1, 0.5)  -- Very close to 0
    spec_helper.assert_rgb_near(r1, g1, b1, r2, g2, b2, 0.05)  -- Allow some tolerance for small hue differences
  end)

  it("handles minimum and maximum saturation", function()
    local r1, g1, b1 = hsl_to_rgb(0, 0, 0.5)
    local r2, g2, b2 = hsl_to_rgb(0, 1, 0.5)
    spec_helper.assert_rgb_near(r1, g1, b1, 0.5, 0.5, 0.5) -- gray (unsaturated)
    spec_helper.assert_rgb_near(r2, g2, b2, 1, 0, 0) -- red (fully saturated)
  end)
end)