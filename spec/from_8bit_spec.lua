local from_8bit = require 'color.from_8bit'

describe("from_8bit", function()
  it("converts 0 to 0.0", function()
    local r = from_8bit(0)
    assert.are.equal(0.0, r)
  end)

  it("converts 128 to approx 0.5", function()
    local r = from_8bit(128)
    assert.is_true(math.abs(r - 0.5) < 0.01)
  end)

  it("converts 255 to 1.0", function()
    local r = from_8bit(255)
    assert.are.equal(1.0, r)
  end)

  it("converts three values", function()
    local r, g, b = from_8bit(128, 128, 128)
    assert.is_true(math.abs(r - 0.5) < 0.01)
    assert.is_true(math.abs(g - 0.5) < 0.01)
    assert.is_true(math.abs(b - 0.5) < 0.01)
  end)

  it("converts two values", function()
    local r, g = from_8bit(0, 255)
    assert.are.equal(0.0, r)
    assert.are.equal(1.0, g)
  end)

  it("handles boundary 0", function()
    local r = from_8bit(0)
    assert.are.equal(0.0, r)
  end)

  it("handles boundary 255", function()
    local r = from_8bit(255)
    assert.are.equal(1.0, r)
  end)
end)