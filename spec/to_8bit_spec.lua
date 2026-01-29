local to_8bit = require 'color.to_8bit'
local spec_helper = require 'spec.spec_helper'

describe("to_8bit", function()
  it("converts 0.0 to 0 with tolerance", function()
    local r = to_8bit(0.0)
    spec_helper.assert_near(0, r, 0.5)
  end)

  it("converts 0.5 to 128 with tolerance", function()
    local r = to_8bit(0.5)
    spec_helper.assert_near(128, r, 0.5)
  end)

  it("converts 1.0 to 255 with tolerance", function()
    local r = to_8bit(1.0)
    spec_helper.assert_near(255, r, 0.5)
  end)

  it("converts three values with tolerance", function()
    local r, g, b = to_8bit(0.5, 0.5, 0.5)
    spec_helper.assert_near(128, r, 0.5)
    spec_helper.assert_near(128, g, 0.5)
    spec_helper.assert_near(128, b, 0.5)
  end)

  it("converts two values with tolerance", function()
    local r, g = to_8bit(0.0, 1.0)
    spec_helper.assert_near(0, r, 0.5)
    spec_helper.assert_near(255, g, 0.5)
  end)

  it("handles boundary 0.0", function()
    local r = to_8bit(0.0)
    spec_helper.assert_near(0, r, 0.5)
  end)

  it("handles boundary 1.0", function()
    local r = to_8bit(1.0)
    spec_helper.assert_near(255, r, 0.5)
  end)
end)