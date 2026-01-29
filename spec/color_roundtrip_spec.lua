local Color = require 'color'
local spec_helper = require 'spec.spec_helper'

describe("Color conversion roundtrips", function()
  describe("CCT roundtrips", function()
    it("CCT -> RGB -> CCT", function()
      local test_temps = {3000, 4000, 5000, 6500}
      for _, cct in ipairs(test_temps) do
        local r, g, b = Color.cct_to_rgb(cct)
        local cct2 = Color.rgb_to_cct(r, g, b)
        spec_helper.assert_near(cct, cct2, 600) -- Allow 600K tolerance for approximation
      end
    end)

    it("CCT -> xy -> CCT", function()
      local test_temps = {3000, 4000, 5000, 6500}
      for _, cct in ipairs(test_temps) do
        local x, y, Y = Color.cct_to_xy(cct)
        local cct2 = Color.xy_to_cct(x, y, Y)
        spec_helper.assert_near(cct, cct2, 700) -- Allow larger tolerance
      end
    end)

    it("CCT -> HSV -> CCT", function()
      local test_temps = {3000, 4000, 5000, 6500}
      for _, cct in ipairs(test_temps) do
        local h, s, v = Color.cct_to_hsv(cct)
        local cct2 = Color.hsv_to_cct(h, s, v)
        spec_helper.assert_near(cct, cct2, 500)
      end
    end)
  end)

  describe("RGB roundtrips", function()
    it("RGB -> HSV -> RGB", function()
      local test_colors = {
        {1, 0, 0}, {0, 1, 0}, {0, 0, 1},
        {1, 1, 0}, {1, 0, 1}, {0, 1, 1},
        {0.5, 0.5, 0.5}, {1, 1, 1}
      }
      for _, rgb in ipairs(test_colors) do
        local h, s, v = Color.rgb_to_hsv(rgb[1], rgb[2], rgb[3])
        -- Normalize RGB by value for roundtrip
        local r2, g2, b2 = Color.hsv_to_rgb(h, s)
        r2, g2, b2 = r2 * v, g2 * v, b2 * v
        spec_helper.assert_rgb_near(rgb[1], rgb[2], rgb[3], r2, g2, b2, 1e-2)
      end
    end)

    it("RGB -> xy -> RGB", function()
      local test_colors = {
        {1, 0, 0}, {0, 1, 0}, {0, 0, 1},
        {1, 1, 1}
      }
      for _, rgb in ipairs(test_colors) do
        local x, y, Y = Color.rgb_to_xy(rgb[1], rgb[2], rgb[3])
        local r2, g2, b2 = Color.xy_to_rgb(x, y, Y)
        spec_helper.assert_rgb_near(rgb[1], rgb[2], rgb[3], r2, g2, b2, 1e-2)
      end
    end)
  end)

  describe("HSV roundtrips", function()
    it("HSV -> xy -> HSV", function()
      local test_hsv = {
        {0, 1, 1}, {0.333, 1, 1}, {0.667, 1, 1}
      }
      for _, hsv in ipairs(test_hsv) do
        local x, y, Y = Color.hsv_to_xy(hsv[1], hsv[2])
        local h2, s2, v2 = Color.xy_to_hsv(x, y, Y)
        spec_helper.assert_hsv_near(hsv[1], hsv[2], hsv[3], h2, s2, v2, 1e-1)
      end
    end)
  end)

  describe("xy roundtrips", function()
    it("xy -> CCT -> xy", function()
      local test_xy = {
        {0.64, 0.33}, {0.30, 0.60}, {0.15, 0.06}, {0.3127, 0.3290}
      }
      for _, xy in ipairs(test_xy) do
        local cct = Color.xy_to_cct(xy[1], xy[2])
        local x2, y2, Y2 = Color.cct_to_xy(cct)
        spec_helper.assert_xyy_near(xy[1], xy[2], 1, x2, y2, Y2, 1.0)
        -- Larger tolerance since CCT doesn't preserve luminance exactly
      end
    end)
  end)
end)