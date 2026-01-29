local from_percentage = require 'color.from_percentage'

describe("from_percentage", function()
  it("converts 0% to 0.0", function()
    local r = from_percentage(0.0)
    assert.are.equal(0.0, r)
  end)

  it("converts 50% to 0.5", function()
    local r = from_percentage(50.0)
    assert.are.equal(0.5, r)
  end)

  it("converts 100% to 1.0", function()
    local r = from_percentage(100.0)
    assert.are.equal(1.0, r)
  end)

  it("converts three values", function()
    local r, g, b = from_percentage(50.0, 25.0, 75.0)
    assert.are.equal(0.5, r)
    assert.are.equal(0.25, g)
    assert.are.equal(0.75, b)
  end)

  it("handles boundary 0%", function()
    local r = from_percentage(0.0)
    assert.are.equal(0.0, r)
  end)

  it("handles boundary 100%", function()
    local r = from_percentage(100.0)
    assert.are.equal(1.0, r)
  end)
end)