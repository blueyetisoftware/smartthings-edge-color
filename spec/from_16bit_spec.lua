local from_16bit = require 'color.from_16bit'

describe("from_16bit", function()
  it("converts 0 to 0.0", function()
    local r = from_16bit(0)
    assert.are.equal(0.0, r)
  end)

  it("converts 32768 to approx 0.5", function()
    local r = from_16bit(32768)
    assert.is_true(math.abs(r - 0.5) < 0.001)
  end)

  it("converts 65535 to 1.0", function()
    local r = from_16bit(65535)
    assert.are.equal(1.0, r)
  end)

  it("converts three values", function()
    local r, g, b = from_16bit(32768, 32768, 32768)
    assert.is_true(math.abs(r - 0.5) < 0.001)
    assert.is_true(math.abs(g - 0.5) < 0.001)
    assert.is_true(math.abs(b - 0.5) < 0.001)
  end)

  it("converts two values", function()
    local r, g = from_16bit(0, 65535)
    assert.are.equal(0.0, r)
    assert.are.equal(1.0, g)
  end)

  it("handles boundary 0", function()
    local r = from_16bit(0)
    assert.are.equal(0.0, r)
  end)

  it("handles boundary 65535", function()
    local r = from_16bit(65535)
    assert.are.equal(1.0, r)
  end)
end)