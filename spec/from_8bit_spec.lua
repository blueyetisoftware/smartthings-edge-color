local from_8bit = require 'color.from_8bit'
local spec_helper = require 'spec.spec_helper'

describe("from_8bit", function()
  it("converts 0 to 0.0 with tolerance", function()
    local r = from_8bit(0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("converts 128 to approx 0.5 with tolerance", function()
    local r = from_8bit(128)
    spec_helper.assert_near(0.5, r, 0.01)
  end)

  it("converts 255 to 1.0 with tolerance", function()
    local r = from_8bit(255)
    spec_helper.assert_near(1.0, r, 1e-10)
  end)

  it("converts three values with tolerance", function()
    local r, g, b = from_8bit(128, 128, 128)
    spec_helper.assert_near(0.5, r, 0.01)
    spec_helper.assert_near(0.5, g, 0.01)
    spec_helper.assert_near(0.5, b, 0.01)
  end)

  it("converts two values with tolerance", function()
    local r, g = from_8bit(0, 255)
    spec_helper.assert_near(0.0, r, 1e-10)
    spec_helper.assert_near(1.0, g, 1e-10)
  end)

  it("handles boundary 0", function()
    local r = from_8bit(0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("handles boundary 255", function()
    local r = from_8bit(255)
    spec_helper.assert_near(1.0, r, 1e-10)
  end)
end)