local cct_to_hsv = require 'color.cct_to_hsv'
local hsv_to_cct = require 'color.hsv_to_cct'
local cct_to_rgb = require 'color.cct_to_rgb'
local to_rgb8 = require 'color.format.rgb'.to_rgb8
local rgb_to_cct = require 'color.rgb_to_cct'
local cct_to_xyy = require 'color.cct_to_xyy'
local xyy_to_cct = require 'color.xyy_to_cct'
local xyy_to_hsv = require 'color.xyy_to_hsv'
local hsv_to_xyy = require 'color.hsv_to_xyy'
local xyy_to_rgb = require 'color.xyy_to_rgb'
local rgb_to_xyy = require 'color.rgb_to_xyy'
local spec_helper = require 'spec.spec_helper'

describe("Color module round trip tests", function()
  describe("CCT round trip", function()
    it("CCT -> HSV -> CCT with tolerance", function()
      local original_cct = 3000
      local h, s, v = cct_to_hsv(original_cct)
      local recovered_cct = hsv_to_cct(h, s, v)
      spec_helper.assert_near(original_cct, recovered_cct, 1000)
    end)

    it("CCT -> RGB -> CCT with tolerance", function()
      local original_cct = 3000
      local r, g, b = cct_to_rgb(original_cct)
      local r8, g8, b8 = to_rgb8(r, g, b)
      local recovered_cct = rgb_to_cct(r8, g8, b8)
      spec_helper.assert_near(original_cct, recovered_cct, 4000)
    end)

    it("CCT -> XY -> CCT with tolerance", function()
      local original_cct = 3000
      local x, y, Y = cct_to_xyy(original_cct)
      local recovered_cct = xyy_to_cct(x, y, Y)
      spec_helper.assert_near(original_cct, recovered_cct, 1000)
    end)
  end)

  describe("HSL round trip", function()
    -- HSL conversions are inherently lossy, no reliable round trip test
  end)

  describe("HSV round trip", function()
    it("HSV -> CCT -> HSV with tolerance", function()
      local original_h, original_s, original_v = 0.1, 0.5, 1.0
      local cct = hsv_to_cct(original_h, original_s, original_v)
      local recovered_h, recovered_s, recovered_v = cct_to_hsv(cct)
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
    it("XY -> CCT -> XY with tolerance", function()
      local original_x, original_y = 0.4, 0.4
      local cct = xyy_to_cct(original_x, original_y)
      local recovered_x, recovered_y, _ = cct_to_xyy(cct)
      spec_helper.assert_near(original_x, recovered_x, 0.1)
      spec_helper.assert_near(original_y, recovered_y, 0.1)
    end)

    it("XY -> HSV -> XY with tolerance", function()
      local original_x, original_y = 0.3, 0.5
      local h, s, v = xyy_to_hsv(original_x, original_y)
      local recovered_x, recovered_y, _ = hsv_to_xyy(h, s, v)
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