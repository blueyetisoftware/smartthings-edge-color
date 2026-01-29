local mirek_to_kelvin = require 'color.mirek_to_kelvin'
local spec_helper = require 'spec.spec_helper'

describe("mirek_to_kelvin", function()
  it("converts 100 mirek to 10000K with tolerance", function()
    local kelvin = mirek_to_kelvin(100)
    spec_helper.assert_near(10000, kelvin, 0.1)
  end)

  it("converts 333 mirek to 3003K with tolerance", function()
    local kelvin = mirek_to_kelvin(333)
    spec_helper.assert_near(3003, kelvin, 0.1)
  end)

  it("converts 1000 mirek to 1000K with tolerance", function()
    local kelvin = mirek_to_kelvin(1000)
    spec_helper.assert_near(1000, kelvin, 0.1)
  end)

  it("handles minimum mirek (100)", function()
    local kelvin = mirek_to_kelvin(100)
    assert.is_true(kelvin >= 1000 and kelvin <= 10000)
  end)

  it("handles maximum mirek (1000)", function()
    local kelvin = mirek_to_kelvin(1000)
    assert.is_true(kelvin >= 1000 and kelvin <= 10000)
  end)
end)