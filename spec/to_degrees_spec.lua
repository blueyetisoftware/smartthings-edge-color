local to_degrees = require 'color.to_degrees'

describe("to_degrees", function()
  it("converts 0.0 to 0°", function()
    local r = to_degrees(0.0)
    assert.are.equal(0.0, r)
  end)

  it("converts 0.5 to 180°", function()
    local r = to_degrees(0.5)
    assert.are.equal(180.0, r)
  end)

  it("converts 1.0 to 360°", function()
    local r = to_degrees(1.0)
    assert.are.equal(360.0, r)
  end)

  it("converts three values", function()
    local r, g, b = to_degrees(0.5, 0.25, 0.75)
    assert.are.equal(180.0, r)
    assert.are.equal(90.0, g)
    assert.are.equal(270.0, b)
  end)

  it("handles boundary 0.0", function()
    local r = to_degrees(0.0)
    assert.are.equal(0.0, r)
  end)

  it("handles boundary 1.0", function()
    local r = to_degrees(1.0)
    assert.are.equal(360.0, r)
  end)
end)