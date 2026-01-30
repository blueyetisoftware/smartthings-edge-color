local mired_to_kelvin = require 'color.mired_to_kelvin'
local spec_helper = require 'spec.spec_helper'

describe("mired_to_kelvin", function()
  it("converts 100 mired to 10000K with tolerance", function()
    local kelvin = mired_to_kelvin(100)
    spec_helper.assert_near(10000, kelvin, 0.1)
  end)

  it("converts 333 mired to 3003K with tolerance", function()
    local kelvin = mired_to_kelvin(333)
    spec_helper.assert_near(3003, kelvin, 0.1)
  end)

  it("converts 1000 mired to 1000K with tolerance", function()
    local kelvin = mired_to_kelvin(1000)
    spec_helper.assert_near(1000, kelvin, 0.1)
  end)

  it("handles minimum mired (100)", function()
    local kelvin = mired_to_kelvin(100)
    assert.is_true(kelvin >= 1000 and kelvin <= 10000)
  end)

  it("handles maximum mired (1000)", function()
    local kelvin = mired_to_kelvin(1000)
    assert.is_true(kelvin >= 1000 and kelvin <= 10000)
  end)
end)