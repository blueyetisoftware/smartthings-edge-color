local hsv_to_xy = require 'color.hsv_to_xy'

describe("hsv_to_xy", function()
  it("converts HSV (50, 50) to xyY", function()
    local x, y, Y = hsv_to_xy(50, 50)
    assert.is_true(math.abs(x - 0.28552972694502) < 1e-10)
    assert.is_true(math.abs(y - 0.90810373061023) < 1e-10)
    assert.is_true(math.abs(Y - (-2.4274166356037)) < 1e-10)
  end)

  it("handles valid HSV ranges", function()
    local x, y, Y = hsv_to_xy(0, 0, 0)
    assert.is_true(x >= 0 and x <= 1)
    assert.is_true(y >= 0 and y <= 1)
  end)

  it("handles boundary HSV (0,0,0)", function()
    local x, y, Y = hsv_to_xy(0, 0, 0)
    assert.is_true(x >= 0 and x <= 1)
    assert.is_true(y >= 0 and y <= 1)
  end)

  it("handles boundary HSV (100,100,100)", function()
    local x, y, Y = hsv_to_xy(100, 100, 100)
    assert.is_true(x >= 0 and x <= 1)
    assert.is_true(y >= 0 and y <= 1)
  end)
end)