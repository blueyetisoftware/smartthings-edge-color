local from_percentage = require 'color.from_percentage'
local spec_helper = require 'spec.spec_helper'

describe("from_percentage", function()
  it("converts 0% to 0.0 with tolerance", function()
    local r = from_percentage(0.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("converts 50% to 0.5 with tolerance", function()
    local r = from_percentage(50.0)
    spec_helper.assert_near(0.5, r, 1e-10)
  end)

  it("converts 100% to 1.0 with tolerance", function()
    local r = from_percentage(100.0)
    spec_helper.assert_near(1.0, r, 1e-10)
  end)

  it("converts three values with tolerance", function()
    local r, g, b = from_percentage(50.0, 25.0, 75.0)
    spec_helper.assert_near(0.5, r, 1e-10)
    spec_helper.assert_near(0.25, g, 1e-10)
    spec_helper.assert_near(0.75, b, 1e-10)
  end)

  it("handles boundary 0%", function()
    local r = from_percentage(0.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("handles boundary 100%", function()
    local r = from_percentage(100.0)
    spec_helper.assert_near(1.0, r, 1e-10)
  end)
end)