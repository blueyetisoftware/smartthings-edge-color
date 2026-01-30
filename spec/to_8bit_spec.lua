local Format = require 'color.format'

describe("to_8bit", function()
  it("converts 0.0 to 0 exactly", function()
    local r = Format.to8(0.0)
    assert.equals(0, r)
  end)

  it("converts 0.5 to 128 exactly", function()
    local r = Format.to8(0.5)
    assert.equals(128, r)
  end)

  it("converts 1.0 to 255 exactly", function()
    local r = Format.to8(1.0)
    assert.equals(255, r)
  end)

  it("converts three values exactly", function()
    local r, g, b = Format.to8(0.5, 0.5, 0.5)
    assert.equals(128, r)
    assert.equals(128, g)
    assert.equals(128, b)
  end)

  it("converts two values exactly", function()
    local r, g = Format.to8(0.0, 1.0)
    assert.equals(0, r)
    assert.equals(255, g)
  end)

  it("handles boundary 0.0", function()
    local r = Format.to8(0.0)
    assert.equals(0, r)
  end)

  it("handles boundary 1.0", function()
    local r = Format.to8(1.0)
    assert.equals(255, r)
  end)
end)