local xy_to_hsv = require 'color.xy_to_hsv'
local spec_helper = require 'spec.spec_helper'

describe("xy_to_hsv", function()
  it("converts xy (16206, 21550) to HSV with tolerance", function()
    local h, s, v = xy_to_hsv(16206, 21550)
    spec_helper.assert_hsv_near({h = 0.15637122244754, s = 1.0, v = 1.0}, {h = h, s = s, v = v}, 1e-10)
  end)

  it("handles valid xy ranges", function()
    local h, s, v = xy_to_hsv(0, 0)
    assert.is_true(h >= 0 and h <= 1)
    assert.is_true(s >= 0 and s <= 1)
    assert.is_true(v >= 0 and v <= 1)
  end)

  it("handles boundary xy (0,0)", function()
    local h, s, v = xy_to_hsv(0, 0)
    assert.is_true(h >= 0 and h <= 1)
    assert.is_true(s >= 0 and s <= 1)
    assert.is_true(v >= 0 and v <= 1)
  end)

  it("handles boundary xy (65535,65535)", function()
    local h, s, v = xy_to_hsv(65535, 65535)
    assert.is_true(h >= 0 and h <= 1)
    assert.is_true(s >= 0 and s <= 1)
    assert.is_true(v >= 0 and v <= 1)
  end)

  it("defaults Y to 1.0 when omitted", function()
    local h1, s1, v1 = xy_to_hsv(16206, 21550, 65535)  -- Y=1.0 in 16-bit
    local h2, s2, v2 = xy_to_hsv(16206, 21550)         -- Y defaults to 1.0
    spec_helper.assert_near(h1, h2, 1e-10)
    spec_helper.assert_near(s1, s2, 1e-10)
    spec_helper.assert_near(v1, v2, 1e-10)
  end)
end)