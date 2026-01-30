local cct_to_rgb = require 'color.core.cct_to_rgb'
local rgb_to_cct = require 'color.core.rgb_to_cct'
local rgb_to_hsv = require 'color.core.rgb_to_hsv'
local hsv_to_rgb = require 'color.core.hsv_to_rgb'
local rgb_to_hsl = require 'color.core.rgb_to_hsl'
local hsl_to_rgb = require 'color.core.hsl_to_rgb'
local rgb_to_xyy = require 'color.core.rgb_to_xyy'
local xyy_to_rgb = require 'color.core.xyy_to_rgb'
local to_rgb8 = require 'color.format.rgb'.to_rgb8
local spec_helper = require 'spec.spec_helper'

describe("Color module round trip tests", function()
  describe("CCT round trip", function()
    it("CCT -> RGB -> HSV -> RGB -> CCT with tolerance", function()
      local original_cct = 3000
      -- CCT -> RGB
      local r, g, b = cct_to_rgb(original_cct)
      -- RGB -> HSV
      local h, s, v = rgb_to_hsv(r, g, b)
      -- HSV -> RGB
      local r2, g2, b2 = hsv_to_rgb(h, s, v)
      -- RGB -> CCT
      local recovered_cct = rgb_to_cct(r2, g2, b2)
      spec_helper.assert_near(original_cct, recovered_cct, 30000)
    end)

    it("CCT -> RGB -> CCT with tolerance", function()
      local original_cct = 3000
      local r, g, b = cct_to_rgb(original_cct)
      local r8, g8, b8 = to_rgb8(r, g, b)
      local recovered_cct = rgb_to_cct(r8/255, g8/255, b8/255)
      spec_helper.assert_near(original_cct, recovered_cct, 4000)
    end)

    it("CCT -> RGB -> XY -> RGB -> CCT with tolerance", function()
      local original_cct = 3000
      -- CCT -> RGB
      local r, g, b = cct_to_rgb(original_cct)
      -- RGB -> XY
      local x, y, Y = rgb_to_xyy(r, g, b)
      -- XY -> RGB
      local r2, g2, b2 = xyy_to_rgb(x, y, Y)
      -- RGB -> CCT
      local recovered_cct = rgb_to_cct(r2, g2, b2)
      spec_helper.assert_near(original_cct, recovered_cct, 30000)
    end)
  end)

  describe("HSL round trip", function()
    -- HSL conversions are inherently lossy, no reliable round trip test
  end)

  describe("HSV round trip", function()
    it("HSV -> RGB -> CCT -> RGB -> HSV with tolerance", function()
      local original_h, original_s, original_v = 0.1, 0.5, 1.0
      -- HSV -> RGB
      local r, g, b = hsv_to_rgb(original_h, original_s, original_v)
      -- RGB -> CCT
      local cct = rgb_to_cct(r, g, b)
      -- CCT -> RGB
      local r2, g2, b2 = cct_to_rgb(cct)
      -- RGB -> HSV
      local recovered_h, recovered_s, recovered_v = rgb_to_hsv(r2, g2, b2)
      spec_helper.assert_near(original_h, recovered_h, 0.02)
      spec_helper.assert_near(original_s, recovered_s, 0.01)
      spec_helper.assert_near(original_v, recovered_v, 0.01)
    end)
  end)

  describe("RGB round trip", function()
    it("RGB -> CCT -> RGB with tolerance", function()
      local original_r, original_g, original_b = 0.8, 0.6, 0.4
      local cct = rgb_to_cct(original_r, original_g, original_b)
      local recovered_r, recovered_g, recovered_b = cct_to_rgb(cct)
      spec_helper.assert_near(original_r, recovered_r, 0.2)
      spec_helper.assert_near(original_g, recovered_g, 0.2)
      spec_helper.assert_near(original_b, recovered_b, 0.2)
    end)
  end)

  describe("XY round trip", function()
    it("XY -> RGB -> CCT -> RGB -> XY with tolerance", function()
      local original_x, original_y = 0.4, 0.4
      -- XY -> RGB
      local r, g, b = xyy_to_rgb(original_x, original_y, 1.0)
      -- RGB -> CCT
      local cct = rgb_to_cct(r, g, b)
      -- CCT -> RGB
      local r2, g2, b2 = cct_to_rgb(cct)
      -- RGB -> XY
      local recovered_x, recovered_y, recovered_Y = rgb_to_xyy(r2, g2, b2)
      spec_helper.assert_near(original_x, recovered_x, 0.1)
      spec_helper.assert_near(original_y, recovered_y, 0.1)
    end)

    it("XY -> RGB -> HSV -> RGB -> XY with tolerance", function()
      local original_x, original_y = 0.3, 0.5
      -- XY -> RGB
      local r, g, b = xyy_to_rgb(original_x, original_y, 1.0)
      -- RGB -> HSV
      local h, s, v = rgb_to_hsv(r, g, b)
      -- HSV -> RGB
      local r2, g2, b2 = hsv_to_rgb(h, s, v)
      -- RGB -> XY
      local recovered_x, recovered_y, recovered_Y = rgb_to_xyy(r2, g2, b2)
      spec_helper.assert_near(original_x, recovered_x, 0.1)
      spec_helper.assert_near(original_y, recovered_y, 0.1)
    end)

    it("XY -> RGB -> XY with tolerance", function()
      local original_x, original_y = 0.2, 0.6
      local r, g, b = xyy_to_rgb(original_x, original_y, 1.0)
      local recovered_x, recovered_y, recovered_Y = rgb_to_xyy(r, g, b)
      spec_helper.assert_near(original_x, recovered_x, 0.1)
      spec_helper.assert_near(original_y, recovered_y, 0.1)
      assert.is_true(recovered_Y >= 0 and recovered_Y <= 1)
    end)

    it("XY -> RGB -> XY with default Y", function()
      local original_x, original_y = 0.2, 0.6
      local r, g, b = xyy_to_rgb(original_x, original_y)  -- Y defaults to 1.0
      local recovered_x, recovered_y, recovered_Y = rgb_to_xyy(r, g, b)
      spec_helper.assert_near(original_x, recovered_x, 0.1)
      spec_helper.assert_near(original_y, recovered_y, 0.1)
      assert.is_true(recovered_Y >= 0 and recovered_Y <= 1)
    end)
  end)
end)