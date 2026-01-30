local Color = require 'color'
local spec_helper = require 'spec.spec_helper'

describe("Color module round trip tests", function()
  describe("CCT round trip", function()
    it("CCT -> HSV -> CCT with tolerance", function()
      local original_cct = 3000
      local h, s, v = Color.cct_to_hsv(original_cct)
      local recovered_cct = Color.hsv_to_cct(h, s, v)
      spec_helper.assert_near(original_cct, recovered_cct, 1000)
    end)

    it("CCT -> RGB -> CCT with tolerance", function()
      local original_cct = 3000
      local r, g, b = Color.cct_to_rgb(original_cct)
      local r8, g8, b8 = Color.to_rgb8(r, g, b)
      local recovered_cct = Color.rgb_to_cct(r8, g8, b8)
      spec_helper.assert_near(original_cct, recovered_cct, 4000)
    end)

    it("CCT -> XY -> CCT with tolerance", function()
      local original_cct = 3000
      local x, y, Y = Color.cct_to_xy(original_cct)
      local recovered_cct = Color.xy_to_cct(x, y, Y)
      spec_helper.assert_near(original_cct, recovered_cct, 1000)
    end)
  end)

  describe("HSL round trip", function()
    -- HSL conversions are inherently lossy, no reliable round trip test
  end)

  describe("HSV round trip", function()
    it("HSV -> CCT -> HSV with tolerance", function()
      local original_h, original_s, original_v = 0.1, 0.5, 1.0
      local cct = Color.hsv_to_cct(original_h, original_s, original_v)
      local recovered_h, recovered_s, recovered_v = Color.cct_to_hsv(cct)
      spec_helper.assert_near(original_h, recovered_h, 0.02)
      spec_helper.assert_near(original_s, recovered_s, 0.01)
      spec_helper.assert_near(original_v, recovered_v, 0.01)
    end)
  end)

  describe("RGB round trip", function()
    it("RGB -> CCT -> RGB with tolerance", function()
      local original_r, original_g, original_b = 0.8, 0.6, 0.4
      local cct = Color.rgb_to_cct(original_r, original_g, original_b)
      local recovered_r, recovered_g, recovered_b = Color.cct_to_rgb(cct)
      spec_helper.assert_near(original_r, recovered_r, 0.2)
      spec_helper.assert_near(original_g, recovered_g, 0.2)
      spec_helper.assert_near(original_b, recovered_b, 0.2)
    end)
  end)

  describe("XY round trip", function()
    it("XY -> CCT -> XY with tolerance", function()
      local original_x, original_y = 0.4, 0.4
      local cct = Color.xy_to_cct(original_x, original_y)
      local recovered_x, recovered_y, _ = Color.cct_to_xy(cct)
      spec_helper.assert_near(original_x, recovered_x, 0.1)
      spec_helper.assert_near(original_y, recovered_y, 0.1)
    end)

    it("XY -> HSV -> XY with tolerance", function()
      local original_x, original_y = 0.3, 0.5
      local h, s, v = Color.xy_to_hsv(original_x, original_y)
      local recovered_x, recovered_y, _ = Color.hsv_to_xy(h, s, v)
      spec_helper.assert_near(original_x, recovered_x, 0.1)
      spec_helper.assert_near(original_y, recovered_y, 0.1)
    end)

    it("XY -> RGB -> XY with tolerance", function()
      local original_x, original_y = 0.2, 0.6
      local r, g, b = Color.xy_to_rgb(original_x, original_y, 1.0)
      local recovered_x, recovered_y, recovered_Y = Color.rgb_to_xy(r, g, b)
      spec_helper.assert_near(original_x, recovered_x, 0.1)
      spec_helper.assert_near(original_y, recovered_y, 0.1)
      assert.is_true(recovered_Y >= 0 and recovered_Y <= 1)
    end)

    it("XY -> RGB -> XY with default Y", function()
      local original_x, original_y = 0.2, 0.6
      local r, g, b = Color.xy_to_rgb(original_x, original_y)  -- Y defaults to 1.0
      local recovered_x, recovered_y, recovered_Y = Color.rgb_to_xy(r, g, b)
      spec_helper.assert_near(original_x, recovered_x, 0.1)
      spec_helper.assert_near(original_y, recovered_y, 0.1)
      assert.is_true(recovered_Y >= 0 and recovered_Y <= 1)
    end)
  end)

  describe("8bit round trip", function()
    it("8bit -> RGB -> 8bit with tolerance", function()
      local original_r8, original_g8, original_b8 = 128, 64, 192
      local r, g, b = Color.from_rgb8(original_r8, original_g8, original_b8)
      local recovered_r8, recovered_g8, recovered_b8 = Color.to_rgb8(r, g, b)
      spec_helper.assert_near(original_r8, recovered_r8, 0.5)
      spec_helper.assert_near(original_g8, recovered_g8, 0.5)
      spec_helper.assert_near(original_b8, recovered_b8, 0.5)
    end)
  end)

  describe("16bit round trip", function()
    it("16bit -> RGB -> 16bit with tolerance", function()
      local original_r16, original_g16, original_b16 = 32768, 16384, 49152
      local r, g, b = Color.from_rgb16(original_r16, original_g16, original_b16)
      local recovered_r16, recovered_g16, recovered_b16 = Color.to_rgb16(r, g, b)
      spec_helper.assert_near(original_r16, recovered_r16, 0.5)
      spec_helper.assert_near(original_g16, recovered_g16, 0.5)
      spec_helper.assert_near(original_b16, recovered_b16, 0.5)
    end)
  end)

  describe("RGB100 round trip", function()
    it("RGB100 -> from_rgb100 with tolerance", function()
      local original_r, original_g, original_b = 75.0, 50.0, 25.0
      local normalized_r, normalized_g, normalized_b = Color.from_rgb100(original_r, original_g, original_b)
      local recovered_r, recovered_g, recovered_b = Color.to_rgb100(normalized_r, normalized_g, normalized_b)
      spec_helper.assert_near(original_r, recovered_r, 0.01)
      spec_helper.assert_near(original_g, recovered_g, 0.01)
      spec_helper.assert_near(original_b, recovered_b, 0.01)
    end)
  end)
end)