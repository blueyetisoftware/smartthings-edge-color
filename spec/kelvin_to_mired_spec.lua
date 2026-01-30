local Format = require 'color.format'
local spec_helper = require 'spec.spec_helper'

describe("to_mired", function()
  it("converts 1000K to 1000 mired with tolerance", function()
    local mired = Format.to_mired(1000)
    spec_helper.assert_near(1000, mired, 0.1)
  end)

  it("converts 3000K to 333 mired with tolerance", function()
    local mired = Format.to_mired(3000)
    spec_helper.assert_near(333.333, mired, 0.5)
  end)

  it("converts 10000K to 100 mired with tolerance", function()
    local mired = Format.to_mired(10000)
    spec_helper.assert_near(100, mired, 0.1)
  end)

  it("handles minimum kelvin (1000K)", function()
    local mired = Format.to_mired(1000)
    assert.is_true(mired >= 100 and mired <= 1000)
  end)

  it("handles high kelvin (10000K)", function()
    local mired = Format.to_mired(10000)
    assert.is_true(mired >= 100 and mired <= 1000)
  end)
end)