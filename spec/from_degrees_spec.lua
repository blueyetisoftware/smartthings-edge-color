local from_degrees = require 'color.from_degrees'

describe("from_degrees", function()
  it("converts 0° to 0.0", function()
    local r = from_degrees(0.0)
    assert.are.equal(0.0, r)
  end)

  it("converts 180° to 0.5", function()
    local r = from_degrees(180.0)
    assert.are.equal(0.5, r)
  end)

  it("converts 360° to 1.0", function()
    local r = from_degrees(360.0)
    assert.are.equal(1.0, r)
  end)

  it("converts three values", function()
    local r, g, b = from_degrees(180.0, 90.0, 270.0)
    assert.are.equal(0.5, r)
    assert.are.equal(0.25, g)
    assert.are.equal(0.75, b)
  end)

  it("handles boundary 0°", function()
    local r = from_degrees(0.0)
    assert.are.equal(0.0, r)
  end)

  it("handles boundary 360°", function()
    local r = from_degrees(360.0)
    assert.are.equal(1.0, r)
  end)
end)