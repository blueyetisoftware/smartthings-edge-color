local hsv_to_rgb = require 'color.hsv_to_rgb'
local spec_helper = require 'spec.spec_helper'

describe("hsv_to_rgb", function()
  it("converts pure red HSV to RGB", function()
    local r, g, b = hsv_to_rgb(0, 1)
    spec_helper.assert_near(r, 1, 1e-6)
    spec_helper.assert_near(g, 0, 1e-6)
    spec_helper.assert_near(b, 0, 1e-6)
  end)

  it("converts pure green HSV to RGB", function()
    local r, g, b = hsv_to_rgb(1/3, 1)
    spec_helper.assert_near(r, 0, 1e-6)
    spec_helper.assert_near(g, 1, 1e-6)
    spec_helper.assert_near(b, 0, 1e-6)
  end)

  it("converts pure blue HSV to RGB", function()
    local r, g, b = hsv_to_rgb(2/3, 1)
    spec_helper.assert_near(r, 0, 1e-6)
    spec_helper.assert_near(g, 0, 1e-6)
    spec_helper.assert_near(b, 1, 1e-6)
  end)

  it("converts white HSV to RGB", function()
    local r, g, b = hsv_to_rgb(0, 0)
    spec_helper.assert_near(r, 1, 1e-6)
    spec_helper.assert_near(g, 1, 1e-6)
    spec_helper.assert_near(b, 1, 1e-6)
  end)

  it("converts cyan HSV to RGB", function()
    local r, g, b = hsv_to_rgb(0.5, 1)
    spec_helper.assert_near(r, 0, 1e-6)
    spec_helper.assert_near(g, 1, 1e-6)
    spec_helper.assert_near(b, 1, 1e-6)
  end)

  it("converts magenta HSV to RGB", function()
    local r, g, b = hsv_to_rgb(5/6, 1)
    spec_helper.assert_near(r, 1, 1e-6)
    spec_helper.assert_near(g, 0, 1e-6)
    spec_helper.assert_near(b, 1, 1e-6)
  end)

  it("converts yellow HSV to RGB", function()
    local r, g, b = hsv_to_rgb(1/6, 1)
    spec_helper.assert_near(r, 1, 1e-6)
    spec_helper.assert_near(g, 1, 1e-6)
    spec_helper.assert_near(b, 0, 1e-6)
  end)

  it("handles hue wraparound", function()
    local r1, g1, b1 = hsv_to_rgb(0, 1)
    local r2, g2, b2 = hsv_to_rgb(0.999, 1)  -- Close to 1 but not exactly 1
    spec_helper.assert_near(r1, r2, 1e-2)
    spec_helper.assert_near(g1, g2, 1e-2)
    spec_helper.assert_near(b1, b2, 1e-2)
  end)

  it("handles zero saturation", function()
    local r, g, b = hsv_to_rgb(0.5, 0)
    spec_helper.assert_near(r, 1, 1e-6)
    spec_helper.assert_near(g, 1, 1e-6)
    spec_helper.assert_near(b, 1, 1e-6)
  end)

  it("clamps input values", function()
    local r, g, b = hsv_to_rgb(-0.1, 1.1)
    -- Hue wraps circularly to 0.9, saturation clamps to 1, value defaults to 1
    spec_helper.assert_near(r, 1, 1e-6)
    spec_helper.assert_near(g, 0, 1e-6)
    spec_helper.assert_near(b, 0.6, 1e-6)
  end)

  it("rejects non-number inputs", function()
    assert.has_error(function() hsv_to_rgb("red", 1) end)
    assert.has_error(function() hsv_to_rgb(0, "full") end)
    assert.has_error(function() hsv_to_rgb(0, 1, "bright") end)
  end)

  it("supports value parameter for brightness control", function()
    -- Full brightness red
    local r1, g1, b1 = hsv_to_rgb(0, 1, 1)
    spec_helper.assert_near(r1, 1, 1e-6)
    spec_helper.assert_near(g1, 0, 1e-6)
    spec_helper.assert_near(b1, 0, 1e-6)

    -- Half brightness red
    local r2, g2, b2 = hsv_to_rgb(0, 1, 0.5)
    spec_helper.assert_near(r2, 0.5, 1e-6)
    spec_helper.assert_near(g2, 0, 1e-6)
    spec_helper.assert_near(b2, 0, 1e-6)

    -- Quarter brightness red
    local r3, g3, b3 = hsv_to_rgb(0, 1, 0.25)
    spec_helper.assert_near(r3, 0.25, 1e-6)
    spec_helper.assert_near(g3, 0, 1e-6)
    spec_helper.assert_near(b3, 0, 1e-6)
  end)

  it("defaults value to 1.0 when omitted", function()
    local r1, g1, b1 = hsv_to_rgb(0, 1, 1)
    local r2, g2, b2 = hsv_to_rgb(0, 1)
    spec_helper.assert_near(r1, r2, 1e-10)
    spec_helper.assert_near(g1, g2, 1e-10)
    spec_helper.assert_near(b1, b2, 1e-10)
  end)

  it("handles zero value (black)", function()
    local r, g, b = hsv_to_rgb(0, 1, 0)
    spec_helper.assert_near(r, 0, 1e-6)
    spec_helper.assert_near(g, 0, 1e-6)
    spec_helper.assert_near(b, 0, 1e-6)
  end)

  it("handles unsaturated colors with value scaling", function()
    -- Gray at half brightness
    local r, g, b = hsv_to_rgb(0, 0, 0.5)
    spec_helper.assert_near(r, 0.5, 1e-6)
    spec_helper.assert_near(g, 0.5, 1e-6)
    spec_helper.assert_near(b, 0.5, 1e-6)
  end)

  it("matches st_utils.hsv_to_rgb when value = 1.0", function()
    -- Test several hue/saturation combinations
    local test_cases = {
      {0, 1},      -- Red
      {1/6, 1},    -- Yellow
      {1/3, 1},    -- Green
      {0.5, 1},    -- Cyan
      {2/3, 1},    -- Blue
      {5/6, 1},    -- Magenta
      {0, 0},      -- White
      {0, 0.5},    -- Light red
    }

    for _, case in ipairs(test_cases) do
      local h, s = case[1], case[2]
      local st_r, st_g, st_b = require('st.utils').hsv_to_rgb(h, s)
      local my_r, my_g, my_b = hsv_to_rgb(h, s, 1.0)
      spec_helper.assert_near(st_r, my_r, 1e-10, string.format("H=%.3f S=%.3f red mismatch", h, s))
      spec_helper.assert_near(st_g, my_g, 1e-10, string.format("H=%.3f S=%.3f green mismatch", h, s))
      spec_helper.assert_near(st_b, my_b, 1e-10, string.format("H=%.3f S=%.3f blue mismatch", h, s))
    end
  end)
end)