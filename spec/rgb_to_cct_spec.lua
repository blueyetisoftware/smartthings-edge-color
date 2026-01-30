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

  -- ============================================================================
  -- Benchmark Validation Against Industry Standards
  -- ============================================================================
  --
  -- These tests validate the RGB to CCT conversion algorithms against standard
  -- illuminants defined by the International Commission on Illumination (CIE).
  -- The tests perform roundtrip validation: CCT -> RGB -> CCT using the
  -- cct_to_rgb function to generate reference RGB values, then verify that
  -- rgb_to_cct correctly recovers the original CCT values.
  --
  -- Standard Illuminants Tested:
  -- - Illuminant A (2856K): Incandescent lamp reference
  -- - Illuminant D50 (5003K): Daylight reference for graphic arts
  -- - Illuminant D65 (6504K): Daylight reference for colorimetry
  -- - High CCT (7500K): Extended range validation
  --
  -- Validation Method:
  -- 1. Generate RGB values using cct_to_rgb (based on blackbody approximation)
  -- 2. Convert back to CCT using both fast and accurate algorithms
  -- 3. Verify results match expected CCT within specified tolerances
  --
  -- Tolerances:
  -- - Accurate algorithm: < 1K (exact match expected)
  -- - Fast algorithm: < 20K for low temps, < 10K for mid/high temps
  --
  -- This validates that the algorithms correctly handle colors on the Planckian
  -- locus and provides confidence in real-world color temperature calculations.
  -- ============================================================================

  describe("benchmark validation against standard illuminants", function()
    local cct_to_rgb = require 'color.cct_to_rgb'

    it("roundtrip accuracy for Illuminant A (2856K)", function()
      local r, g, b = cct_to_rgb(2856)
      local cct_fast = rgb_to_cct(r, g, b, false)
      local cct_accurate = rgb_to_cct(r, g, b, true)

      -- Fast algorithm should be within 20K for this temperature range
      spec_helper.assert_near(2856, cct_fast, 20)
      -- Accurate algorithm should be exact
      spec_helper.assert_near(2856, cct_accurate, 1)
    end)

    it("roundtrip accuracy for Illuminant D50 (5003K)", function()
      local r, g, b = cct_to_rgb(5003)
      local cct_fast = rgb_to_cct(r, g, b, false)
      local cct_accurate = rgb_to_cct(r, g, b, true)

      -- Fast algorithm should be within 10K for this temperature range
      spec_helper.assert_near(5003, cct_fast, 10)
      -- Accurate algorithm should be exact
      spec_helper.assert_near(5003, cct_accurate, 1)
    end)

    it("roundtrip accuracy for Illuminant D65 (6504K)", function()
      local r, g, b = cct_to_rgb(6504)
      local cct_fast = rgb_to_cct(r, g, b, false)
      local cct_accurate = rgb_to_cct(r, g, b, true)

      -- Fast algorithm should be within 10K for this temperature range
      spec_helper.assert_near(6504, cct_fast, 10)
      -- Accurate algorithm should be exact
      spec_helper.assert_near(6504, cct_accurate, 1)
    end)

    it("roundtrip accuracy for high CCT (7500K)", function()
      local r, g, b = cct_to_rgb(7500)
      local cct_fast = rgb_to_cct(r, g, b, false)
      local cct_accurate = rgb_to_cct(r, g, b, true)

      -- Fast algorithm should be within 10K for this temperature range
      spec_helper.assert_near(7500, cct_fast, 10)
      -- Accurate algorithm should be exact
      spec_helper.assert_near(7500, cct_accurate, 1)
    end)
  end)
end)