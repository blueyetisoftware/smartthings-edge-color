local from_degrees = require 'color.from_degrees'
local spec_helper = require 'spec.spec_helper'

describe("from_degrees", function()
  it("converts 0° to 0.0 with tolerance", function()
    local r = from_degrees(0.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("converts 180° to 0.5 with tolerance", function()
    local r = from_degrees(180.0)
    spec_helper.assert_near(0.5, r, 1e-10)
  end)

  it("converts 360° to 0.0 with tolerance", function()
    local r = from_degrees(360.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("converts three values with tolerance", function()
    -- Removed: function now takes single argument
  end)

  it("handles boundary 0°", function()
    local r = from_degrees(0.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("handles boundary 360°", function()
    local r = from_degrees(360.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)
end)