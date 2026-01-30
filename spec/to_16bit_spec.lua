local Format = require 'color.format'
local spec_helper = require 'spec.spec_helper'

describe("to_16bit", function()
  it("converts 0.0 to 0 exactly", function()
    local r = Format.to16(0.0)
    assert.equals(0, r)
  end)

  it("converts 0.5 to 32768 exactly", function()
    local r = Format.to16(0.5)
    assert.equals(32768, r)
  end)

  it("converts 1.0 to 65535 exactly", function()
    local r = Format.to16(1.0)
    assert.equals(65535, r)
  end)

  it("converts three values exactly", function()
    local r, g, b = Format.to16(0.5, 0.5, 0.5)
    assert.equals(32768, r)
    assert.equals(32768, g)
    assert.equals(32768, b)
  end)

  it("converts two values exactly", function()
    local r, g = Format.to16(0.0, 1.0)
    assert.equals(0, r)
    assert.equals(65535, g)
  end)

  it("handles boundary 0.0", function()
    local r = Format.to16(0.0)
    assert.equals(0, r)
  end)

  it("handles boundary 1.0", function()
    local r = Format.to16(1.0)
    assert.equals(65535, r)
  end)
end)