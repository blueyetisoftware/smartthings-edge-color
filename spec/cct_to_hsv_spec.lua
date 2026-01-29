local cct_to_hsv = require 'color.cct_to_hsv'

describe("cct_to_hsv", function()
  it("converts 3000K CCT to valid HSV ranges", function()
    local h, s, v = cct_to_hsv(3000)
    assert.is_true(h >= 0 and h <= 1)
    assert.is_true(s >= 0 and s <= 1)
    assert.is_true(v >= 0 and v <= 1)
  end)

  it("handles boundary 1000K CCT", function()
    local h, s, v = cct_to_hsv(1000)
    assert.is_true(h >= 0 and h <= 1)
    assert.is_true(s >= 0 and s <= 1)
    assert.is_true(v >= 0 and v <= 1)
  end)

  it("handles boundary 40000K CCT", function()
    local h, s, v = cct_to_hsv(40000)
    assert.is_true(h >= 0 and h <= 1)
    assert.is_true(s >= 0 and s <= 1)
    assert.is_true(v >= 0 and v <= 1)
  end)
end)