local to_16bit = require 'color.to_16bit'
local spec_helper = require 'spec.spec_helper'

describe("to_16bit", function()
  it("converts 0.0 to 0 with tolerance", function()
    local r = to_16bit(0.0)
    spec_helper.assert_near(0, r, 0.5)
  end)

  it("converts 0.5 to 32768 with tolerance", function()
    local r = to_16bit(0.5)
    spec_helper.assert_near(32768, r, 0.5)
  end)

  it("converts 1.0 to 65535 with tolerance", function()
    local r = to_16bit(1.0)
    spec_helper.assert_near(65535, r, 0.5)
  end)

  it("converts three values with tolerance", function()
    local r, g, b = to_16bit(0.5, 0.5, 0.5)
    spec_helper.assert_near(32768, r, 0.5)
    spec_helper.assert_near(32768, g, 0.5)
    spec_helper.assert_near(32768, b, 0.5)
  end)

  it("converts two values with tolerance", function()
    local r, g = to_16bit(0.0, 1.0)
    spec_helper.assert_near(0, r, 0.5)
    spec_helper.assert_near(65535, g, 0.5)
  end)

  it("handles boundary 0.0", function()
    local r = to_16bit(0.0)
    spec_helper.assert_near(0, r, 0.5)
  end)

  it("handles boundary 1.0", function()
    local r = to_16bit(1.0)
    spec_helper.assert_near(65535, r, 0.5)
  end)
end)