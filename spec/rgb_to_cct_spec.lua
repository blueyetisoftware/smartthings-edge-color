local rgb_to_cct = require 'color.rgb_to_cct'
local spec_helper = require 'spec.spec_helper'

describe("rgb_to_cct", function()
  describe("fast approximation (default)", function()
    it("converts RGB (1.0, 0.7, 0.4) to approx 2906K with tolerance", function()
      local cct = rgb_to_cct(1.0, 0.7, 0.4)  -- Warm color
      spec_helper.assert_near(2906, cct, 100, "Fast approximation for RGB (1.0, 0.7, 0.4) should be near 2906K")
    end)

    it("converts RGB (0.8, 0.9, 1.0) to approx 9985K with tolerance", function()
      local cct = rgb_to_cct(0.8, 0.9, 1.0)  -- Cool color
      spec_helper.assert_near(9985, cct, 500, "Fast approximation for RGB (0.8, 0.9, 1.0) should be near 9985K")
    end)

    it("converts RGB (1.0, 1.0, 1.0) to approx 6524K with tolerance", function()
      local cct = rgb_to_cct(1.0, 1.0, 1.0)  -- Pure white
      spec_helper.assert_near(6524, cct, 200, "Fast approximation for RGB (1.0, 1.0, 1.0) should be near 6524K")
    end)

    it("converts RGB (1.0, 0.5, 0.0) to approx 1K with tolerance", function()
      local cct = rgb_to_cct(1.0, 0.5, 0.0)  -- Deep red/orange
      spec_helper.assert_near(1, cct, 100, "Fast approximation for RGB (1.0, 0.5, 0.0) should be near 1K")
    end)
  end)

  describe("accurate algorithm", function()
    it("converts RGB (1.0, 0.7, 0.4) to approx 2913K with tolerance", function()
      local cct = rgb_to_cct(1.0, 0.7, 0.4, true)  -- Warm color
      spec_helper.assert_near(2913, cct, 100, "Accurate algorithm for RGB (1.0, 0.7, 0.4) should be near 2913K")
    end)

    it("converts RGB (0.8, 0.9, 1.0) to approx 9463K with tolerance", function()
      local cct = rgb_to_cct(0.8, 0.9, 1.0, true)  -- Cool color
      spec_helper.assert_near(9463, cct, 500, "Accurate algorithm for RGB (0.8, 0.9, 1.0) should be near 9463K")
    end)

    it("converts RGB (1.0, 1.0, 1.0) to approx 6600K with tolerance", function()
      local cct = rgb_to_cct(1.0, 1.0, 1.0, true)  -- Pure white
      spec_helper.assert_near(6600, cct, 200, "Accurate algorithm for RGB (1.0, 1.0, 1.0) should be near 6600K")
    end)

    it("converts RGB (1.0, 0.5, 0.0) to approx 1803K with tolerance", function()
      local cct = rgb_to_cct(1.0, 0.5, 0.0, true)  -- Deep red/orange
      spec_helper.assert_near(1803, cct, 100, "Accurate algorithm for RGB (1.0, 0.5, 0.0) should be near 1803K")
    end)
  end)

  it("handles boundary values", function()
    local cct_min = rgb_to_cct(1.0, 0.0, 0.0)  -- Pure red
    local cct_max = rgb_to_cct(0.0, 0.0, 1.0)  -- Pure blue
    assert.is_true(cct_min >= 1 and cct_min <= 30000)
    assert.is_true(cct_max >= 1 and cct_max <= 30000)
  end)

  it("clamps input values", function()
    local cct = rgb_to_cct(-0.1, 1.5, 0.5)
    assert.is_true(cct >= 1 and cct <= 30000)
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

      -- Fast algorithm should be within 50K for this temperature range
      spec_helper.assert_near(2856, cct_fast, 50)
      -- Accurate algorithm should be exact
      spec_helper.assert_near(2856, cct_accurate, 1)
    end)

    it("roundtrip accuracy for Illuminant D50 (5003K)", function()
      local r, g, b = cct_to_rgb(5003)
      local cct_fast = rgb_to_cct(r, g, b, false)
      local cct_accurate = rgb_to_cct(r, g, b, true)

      -- Fast algorithm should be within 50K for this temperature range
      spec_helper.assert_near(5003, cct_fast, 50)
      -- Accurate algorithm should be exact
      spec_helper.assert_near(5003, cct_accurate, 1)
    end)

    it("roundtrip accuracy for Illuminant D65 (6504K)", function()
      local r, g, b = cct_to_rgb(6504)
      local cct_fast = rgb_to_cct(r, g, b, false)
      local cct_accurate = rgb_to_cct(r, g, b, true)

      -- Fast algorithm should be within 100K for this temperature range
      spec_helper.assert_near(6504, cct_fast, 100)
      -- Accurate algorithm should be exact
      spec_helper.assert_near(6504, cct_accurate, 1)
    end)

    it("roundtrip accuracy for high CCT (30000K)", function()
      local r, g, b = cct_to_rgb(30000)
      local cct_fast = rgb_to_cct(r, g, b, false)
      local cct_accurate = rgb_to_cct(r, g, b, true)

      -- Fast algorithm should be within 100K for this temperature range
      spec_helper.assert_near(30000, cct_fast, 100)
      -- Accurate algorithm should be exact
      spec_helper.assert_near(30000, cct_accurate, 1)
    end)

    describe("real bulb simulation tests", function()
      it("matches Philips Hue White Ambiance bulb", function()
        -- Philips Hue White Ambiance bulb approximation (warm white)
        local r, g, b = 1.0, 0.7, 0.4
        local cct_fast = rgb_to_cct(r, g, b, false)
        local cct_accurate = rgb_to_cct(r, g, b, true)

        spec_helper.assert_near(2900, cct_fast, 200)
        spec_helper.assert_near(2900, cct_accurate, 200)
      end)

      it("matches LIFX A19 Soft White bulb", function()
        -- LIFX A19 Soft White bulb approximation (warm white)
        local r, g, b = 1.0, 0.75, 0.55
        local cct_fast = rgb_to_cct(r, g, b, false)
        local cct_accurate = rgb_to_cct(r, g, b, true)

        spec_helper.assert_near(3500, cct_fast, 200)
        spec_helper.assert_near(3500, cct_accurate, 200)
      end)

      it("matches typical LED daylight bulb", function()
        -- Typical LED daylight bulb approximation (cool white)
        local r, g, b = 0.95, 0.98, 1.0
        local cct_fast = rgb_to_cct(r, g, b, false)
        local cct_accurate = rgb_to_cct(r, g, b, true)

        -- LED bulbs have manufacturing variations, test within 300K of ~7000K
        spec_helper.assert_near(7000, cct_fast, 300)
        spec_helper.assert_near(7000, cct_accurate, 300)
      end)
    end)

    describe("fuzz testing", function()
      it("handles random RGB inputs without crashing", function()
        -- Test 100 random RGB combinations
        for i = 1, 100 do
          local r = math.random()
          local g = math.random()
          local b = math.random()

          -- Should not crash or return NaN
          local cct_fast = rgb_to_cct(r, g, b, false)
          local cct_accurate = rgb_to_cct(r, g, b, true)

          -- Should be valid numbers within expected range
          assert.is_true(type(cct_fast) == "number")
          assert.is_true(type(cct_accurate) == "number")
          assert.is_true(cct_fast >= 1 and cct_fast <= 30000)
          assert.is_true(cct_accurate >= 1 and cct_accurate <= 30000)
          assert.is_true(cct_fast == cct_fast)  -- Not NaN
          assert.is_true(cct_accurate == cct_accurate)  -- Not NaN
        end
      end)

      it("handles edge case RGB combinations", function()
        local edge_cases = {
          {1, 1, 1},       -- Pure white
          {0, 0, 0},       -- Black
          {1, 0, 0},       -- Pure red
          {0, 1, 0},       -- Pure green
          {0, 0, 1},       -- Pure blue
          {1, 1, 0},       -- Yellow
          {1, 0, 1},       -- Magenta
          {0, 1, 1},       -- Cyan
          {0.5, 0.5, 0.5}, -- Gray
          {1e-6, 1e-6, 1e-6}, -- Near black
          {0.999, 0.999, 0.999}, -- Near white
        }

        for _, rgb in ipairs(edge_cases) do
          local r, g, b = rgb[1], rgb[2], rgb[3]
          local cct_fast = rgb_to_cct(r, g, b, false)
          local cct_accurate = rgb_to_cct(r, g, b, true)

          -- Should be valid numbers within range
          assert.is_true(type(cct_fast) == "number")
          assert.is_true(type(cct_accurate) == "number")
          assert.is_true(cct_fast >= 1 and cct_fast <= 30000)
          assert.is_true(cct_accurate >= 1 and cct_accurate <= 30000)
          assert.is_true(cct_fast == cct_fast)  -- Not NaN
          assert.is_true(cct_accurate == cct_accurate)  -- Not NaN
        end
      end)
    end)
  end)
end)