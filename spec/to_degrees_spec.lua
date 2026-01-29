local to_degrees = require 'color.to_degrees'
local spec_helper = require 'spec.spec_helper'

describe("to_degrees", function()
  it("converts 0.0 to 0° with tolerance", function()
    local r = to_degrees(0.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("converts 0.5 to 180° with tolerance", function()
    local r = to_degrees(0.5)
    spec_helper.assert_near(180.0, r, 1e-10)
  end)

  it("converts 1.0 to 0° with tolerance", function()
    local r = to_degrees(1.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("converts three values with tolerance", function()
    -- Removed: function now takes single argument
  end)

  it("handles boundary 0.0", function()
    local r = to_degrees(0.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)

  it("handles boundary 1.0", function()
    local r = to_degrees(1.0)
    spec_helper.assert_near(0.0, r, 1e-10)
  end)
end)