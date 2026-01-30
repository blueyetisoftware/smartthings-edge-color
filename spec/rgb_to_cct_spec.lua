local rgb_to_cct = require 'color.rgb_to_cct'
local spec_helper = require 'spec.spec_helper'

describe("rgb_to_cct", function()
  describe("fast approximation (default)", function()
    it("converts RGB (1.0, 0.7, 0.4) to approx 2906K with tolerance", function()
      local cct = rgb_to_cct(1.0, 0.7, 0.4)  -- Warm color
      spec_helper.assert_near(2906, cct, 100)
    end)

    it("converts RGB (0.8, 0.9, 1.0) to approx 9985K with tolerance", function()
      local cct = rgb_to_cct(0.8, 0.9, 1.0)  -- Cool color
      spec_helper.assert_near(9985, cct, 500)
    end)

    it("converts RGB (1.0, 1.0, 1.0) to approx 6524K with tolerance", function()
      local cct = rgb_to_cct(1.0, 1.0, 1.0)  -- Pure white
      spec_helper.assert_near(6524, cct, 200)
    end)

    it("converts RGB (1.0, 0.5, 0.0) to approx 1000K with tolerance", function()
      local cct = rgb_to_cct(1.0, 0.5, 0.0)  -- Deep red/orange
      spec_helper.assert_near(1000, cct, 100)
    end)
  end)

  describe("accurate algorithm", function()
    it("converts RGB (1.0, 0.7, 0.4) to approx 2913K with tolerance", function()
      local cct = rgb_to_cct(1.0, 0.7, 0.4, true)  -- Warm color
      spec_helper.assert_near(2913, cct, 100)
    end)

    it("converts RGB (0.8, 0.9, 1.0) to approx 9463K with tolerance", function()
      local cct = rgb_to_cct(0.8, 0.9, 1.0, true)  -- Cool color
      spec_helper.assert_near(9463, cct, 500)
    end)

    it("converts RGB (1.0, 1.0, 1.0) to approx 6600K with tolerance", function()
      local cct = rgb_to_cct(1.0, 1.0, 1.0, true)  -- Pure white
      spec_helper.assert_near(6600, cct, 200)
    end)

    it("converts RGB (1.0, 0.5, 0.0) to approx 1803K with tolerance", function()
      local cct = rgb_to_cct(1.0, 0.5, 0.0, true)  -- Deep red/orange
      spec_helper.assert_near(1803, cct, 200)
    end)
  end)

  it("handles boundary values", function()
    local cct_min = rgb_to_cct(1.0, 0.0, 0.0)  -- Pure red
    local cct_max = rgb_to_cct(0.0, 0.0, 1.0)  -- Pure blue
    assert.is_true(cct_min >= 1000 and cct_min <= 40000)
    assert.is_true(cct_max >= 1000 and cct_max <= 40000)
  end)

  it("clamps input values", function()
    local cct = rgb_to_cct(-0.1, 1.5, 0.5)
    assert.is_true(cct >= 1000 and cct <= 40000)
  end)

  it("raises error for invalid input types", function()
    assert.has_error(function() rgb_to_cct("red", 0.5, 0.5) end)
    assert.has_error(function() rgb_to_cct(0.5, "green", 0.5) end)
    assert.has_error(function() rgb_to_cct(0.5, 0.5, "blue") end)
  end)
end)