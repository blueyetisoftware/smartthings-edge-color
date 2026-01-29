local to_8bit = require 'color.to_8bit'

describe("to_8bit", function()
  it("converts 0.0 to 0", function()
    local r = to_8bit(0.0)
    assert.are.equal(0, r)
  end)

  it("converts 0.5 to 128", function()
    local r = to_8bit(0.5)
    assert.are.equal(128, r)
  end)

  it("converts 1.0 to 255", function()
    local r = to_8bit(1.0)
    assert.are.equal(255, r)
  end)

  it("converts three values", function()
    local r, g, b = to_8bit(0.5, 0.5, 0.5)
    assert.are.equal(128, r)
    assert.are.equal(128, g)
    assert.are.equal(128, b)
  end)

  it("converts two values", function()
    local r, g = to_8bit(0.0, 1.0)
    assert.are.equal(0, r)
    assert.are.equal(255, g)
  end)

  it("handles boundary 0.0", function()
    local r = to_8bit(0.0)
    assert.are.equal(0, r)
  end)

  it("handles boundary 1.0", function()
    local r = to_8bit(1.0)
    assert.are.equal(255, r)
  end)
end)