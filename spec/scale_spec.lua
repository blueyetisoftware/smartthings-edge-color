local scale = require 'color.scale'
local spec_helper = require 'spec.spec_helper'

describe("scale", function()
  it("scales single value by 2 with tolerance", function()
    local r = scale(2, 0.5)
    spec_helper.assert_near(1.0, r, 1e-10)
  end)

  it("scales two values by 100 with tolerance", function()
    local r, g = scale(100, 0.5, 0.25)
    spec_helper.assert_near(50.0, r, 1e-10)
    spec_helper.assert_near(25.0, g, 1e-10)
  end)

  it("scales three values by 360 with tolerance", function()
    local r, g, b = scale(360, 0.5, 0.25, 0.75)
    spec_helper.assert_near(180.0, r, 1e-10)
    spec_helper.assert_near(90.0, g, 1e-10)
    spec_helper.assert_near(270.0, b, 1e-10)
  end)

  it("handles zero scalar", function()
    local r = scale(0, 1.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("handles negative scalar", function()
    local r = scale(-1, 0.5)
    spec_helper.assert_near(-0.5, r, 1e-10)
  end)
end)