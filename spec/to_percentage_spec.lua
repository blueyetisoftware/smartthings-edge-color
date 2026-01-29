local to_percentage = require 'color.to_percentage'
local spec_helper = require 'spec.spec_helper'

describe("to_percentage", function()
  it("converts 0.0 to 0% with tolerance", function()
    local r = to_percentage(0.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("converts 0.5 to 50% with tolerance", function()
    local r = to_percentage(0.5)
    spec_helper.assert_near(50.0, r, 1e-10)
  end)

  it("converts 1.0 to 100% with tolerance", function()
    local r = to_percentage(1.0)
    spec_helper.assert_near(100.0, r, 1e-10)
  end)

  it("converts three values with tolerance", function()
    local r, g, b = to_percentage(0.5, 0.25, 0.75)
    spec_helper.assert_near(50.0, r, 1e-10)
    spec_helper.assert_near(25.0, g, 1e-10)
    spec_helper.assert_near(75.0, b, 1e-10)
  end)

  it("handles boundary 0.0", function()
    local r = to_percentage(0.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("handles boundary 1.0", function()
    local r = to_percentage(1.0)
    spec_helper.assert_near(100.0, r, 1e-10)
  end)
end)