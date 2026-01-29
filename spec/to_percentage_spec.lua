local to_percentage = require 'color.to_percentage'

describe("to_percentage", function()
  it("converts 0.0 to 0%", function()
    local r = to_percentage(0.0)
    assert.are.equal(0.0, r)
  end)

  it("converts 0.5 to 50%", function()
    local r = to_percentage(0.5)
    assert.are.equal(50.0, r)
  end)

  it("converts 1.0 to 100%", function()
    local r = to_percentage(1.0)
    assert.are.equal(100.0, r)
  end)

  it("converts three values", function()
    local r, g, b = to_percentage(0.5, 0.25, 0.75)
    assert.are.equal(50.0, r)
    assert.are.equal(25.0, g)
    assert.are.equal(75.0, b)
  end)

  it("handles boundary 0.0", function()
    local r = to_percentage(0.0)
    assert.are.equal(0.0, r)
  end)

  it("handles boundary 1.0", function()
    local r = to_percentage(1.0)
    assert.are.equal(100.0, r)
  end)
end)