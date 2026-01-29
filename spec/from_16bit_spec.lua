local from_16bit = require 'color.from_16bit'
local spec_helper = require 'spec.spec_helper'

describe("from_16bit", function()
  it("converts 0 to 0.0 with tolerance", function()
    local r = from_16bit(0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("converts 32768 to approx 0.5 with tolerance", function()
    local r = from_16bit(32768)
    spec_helper.assert_near(0.5, r, 0.001)
  end)

  it("converts 65535 to 1.0 with tolerance", function()
    local r = from_16bit(65535)
    spec_helper.assert_near(1.0, r, 1e-10)
  end)

  it("converts three values with tolerance", function()
    local r, g, b = from_16bit(32768, 32768, 32768)
    spec_helper.assert_near(0.5, r, 0.001)
    spec_helper.assert_near(0.5, g, 0.001)
    spec_helper.assert_near(0.5, b, 0.001)
  end)

  it("converts two values with tolerance", function()
    local r, g = from_16bit(0, 65535)
    spec_helper.assert_near(0.0, r, 1e-10)
    spec_helper.assert_near(1.0, g, 1e-10)
  end)

  it("handles boundary 0", function()
    local r = from_16bit(0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("handles boundary 65535", function()
    local r = from_16bit(65535)
    spec_helper.assert_near(1.0, r, 1e-10)
  end)
end)