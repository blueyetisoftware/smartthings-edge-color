local scale = require 'color.scale'

describe("scale", function()
  it("scales single value by 2", function()
    local r = scale(2, 0.5)
    assert.are.equal(1.0, r)
  end)

  it("scales two values by 100", function()
    local r, g = scale(100, 0.5, 0.25)
    assert.are.equal(50.0, r)
    assert.are.equal(25.0, g)
  end)

  it("scales three values by 360", function()
    local r, g, b = scale(360, 0.5, 0.25, 0.75)
    assert.are.equal(180.0, r)
    assert.are.equal(90.0, g)
    assert.are.equal(270.0, b)
  end)

  it("handles zero scalar", function()
    local r = scale(0, 1.0)
    assert.are.equal(0.0, r)
  end)

  it("handles negative scalar", function()
    local r = scale(-1, 0.5)
    assert.are.equal(-0.5, r)
  end)
end)