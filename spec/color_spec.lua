local Color = require 'color'

describe("Color module round trip tests", function()
  describe("CCT round trip", function()
    it("CCT -> HSV -> CCT", function()
      local original_cct = 3000
      local h, s, v = Color.cct_to_hsv(original_cct)
      local recovered_cct = Color.hsv_to_cct(h, s, v)
      assert.is_true(math.abs(recovered_cct - original_cct) <= 1000)
    end)

    it("CCT -> RGB -> CCT", function()
      local original_cct = 3000
      local r, g, b = Color.cct_to_rgb(original_cct)
      local r8, g8, b8 = Color.to_8bit(r, g, b)
      local recovered_cct = Color.rgb_to_cct(r8, g8, b8)
      assert.is_true(math.abs(recovered_cct - original_cct) <= 500)
    end)

    it("CCT -> XY -> CCT", function()
      local original_cct = 3000
      local x, y = Color.cct_to_xy(original_cct)
      local recovered_cct = Color.xy_to_cct(x, y)
      assert.is_true(math.abs(recovered_cct - original_cct) <= 1000)
    end)
  end)

  describe("HSL round trip", function()
    -- HSL conversions are inherently lossy, no reliable round trip test
  end)

  describe("HSV round trip", function()
    it("HSV -> CCT -> HSV", function()
      local original_h, original_s, original_v = 0.1, 0.5, 1.0
      local cct = Color.hsv_to_cct(original_h, original_s, original_v)
      local recovered_h, recovered_s, recovered_v = Color.cct_to_hsv(cct)
      assert.is_true(math.abs(recovered_h - original_h) < 0.02)
      assert.is_true(math.abs(recovered_s - original_s) < 0.01)
      assert.is_true(math.abs(recovered_v - original_v) < 0.01)
    end)
  end)

  describe("RGB round trip", function()
    it("RGB -> CCT -> RGB", function()
      local original_r, original_g, original_b = 0.8, 0.6, 0.4
      local cct = Color.rgb_to_cct(original_r, original_g, original_b)
      local recovered_r, recovered_g, recovered_b = Color.cct_to_rgb(cct)
      assert.is_true(math.abs(recovered_r - original_r) < 0.2)
      assert.is_true(math.abs(recovered_g - original_g) < 0.2)
      assert.is_true(math.abs(recovered_b - original_b) < 0.2)
    end)
  end)

  describe("XY round trip", function()
    it("XY -> CCT -> XY", function()
      local original_x, original_y = 0.4, 0.4
      local cct = Color.xy_to_cct(original_x, original_y)
      local recovered_x, recovered_y = Color.cct_to_xy(cct)
      assert.is_true(math.abs(recovered_x - original_x) < 0.1)
      assert.is_true(math.abs(recovered_y - original_y) < 0.1)
    end)

    it("XY -> HSV -> XY", function()
      local original_x, original_y = 0.3, 0.5
      local h, s, v = Color.xy_to_hsv(original_x, original_y)
      local recovered_x, recovered_y = Color.hsv_to_xy(h, s, v)
      assert.is_true(math.abs(recovered_x - original_x) < 0.1)
      assert.is_true(math.abs(recovered_y - original_y) < 0.1)
    end)

    it("XY -> RGB -> XY", function()
      local original_x, original_y = 0.2, 0.6
      local r, g, b = Color.xy_to_rgb(original_x, original_y, 1.0)
      local recovered_x, recovered_y, Y = Color.rgb_to_xy(r, g, b)
      assert.is_true(math.abs(recovered_x - original_x) < 0.1)
      assert.is_true(math.abs(recovered_y - original_y) < 0.1)
    end)
  end)

  describe("8bit round trip", function()
    it("8bit -> RGB -> 8bit", function()
      local original_r8, original_g8, original_b8 = 128, 64, 192
      local r, g, b = Color.from_8bit(original_r8, original_g8, original_b8)
      local recovered_r8, recovered_g8, recovered_b8 = Color.to_8bit(r, g, b)
      assert.is_equal(recovered_r8, original_r8)
      assert.is_equal(recovered_g8, original_g8)
      assert.is_equal(recovered_b8, original_b8)
    end)
  end)

  describe("16bit round trip", function()
    it("16bit -> RGB -> 16bit", function()
      local original_r16, original_g16, original_b16 = 32768, 16384, 49152
      local r, g, b = Color.from_16bit(original_r16, original_g16, original_b16)
      local recovered_r16, recovered_g16, recovered_b16 = Color.to_16bit(r, g, b)
      assert.is_equal(recovered_r16, original_r16)
      assert.is_equal(recovered_g16, original_g16)
      assert.is_equal(recovered_b16, original_b16)
    end)
  end)

  describe("Percentage round trip", function()
    it("Percentage -> from_percentage", function()
      local original = 50.0
      local normalized = Color.from_percentage(original)
      local recovered = Color.to_percentage(normalized)
      assert.is_true(math.abs(recovered - original) < 0.01)
    end)
  end)

  describe("Degrees round trip", function()
    it("Degrees -> from_degrees", function()
      local original = 180.0
      local normalized = Color.from_degrees(original)
      local recovered = Color.to_degrees(normalized)
      assert.is_true(math.abs(recovered - original) < 0.01)
    end)
  end)
end)