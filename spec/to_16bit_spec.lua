local to_16bit = require 'color.to_16bit'

describe("to_16bit", function()
  it("converts 0.0 to 0", function()
    local r = to_16bit(0.0)
    assert.are.equal(0, r)
  end)

  it("converts 0.5 to 32768", function()
    local r = to_16bit(0.5)
    assert.are.equal(32768, r)
  end)

  it("converts 1.0 to 65535", function()
    local r = to_16bit(1.0)
    assert.are.equal(65535, r)
  end)

  it("converts three values", function()
    local r, g, b = to_16bit(0.5, 0.5, 0.5)
    assert.are.equal(32768, r)
    assert.are.equal(32768, g)
    assert.are.equal(32768, b)
  end)

  it("converts two values", function()
    local r, g = to_16bit(0.0, 1.0)
    assert.are.equal(0, r)
    assert.are.equal(65535, g)
  end)

  it("handles boundary 0.0", function()
    local r = to_16bit(0.0)
    assert.are.equal(0, r)
  end)

  it("handles boundary 1.0", function()
    local r = to_16bit(1.0)
    assert.are.equal(65535, r)
  end)
end)