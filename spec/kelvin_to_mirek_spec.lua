local kelvin_to_mirek = require 'color.kelvin_to_mirek'
local spec_helper = require 'spec.spec_helper'

describe("kelvin_to_mirek", function()
  it("converts 1000K to 1000 mirek with tolerance", function()
    local mirek = kelvin_to_mirek(1000)
    spec_helper.assert_near(1000, mirek, 0.1)
  end)

  it("converts 3000K to 333 mirek with tolerance", function()
    local mirek = kelvin_to_mirek(3000)
    spec_helper.assert_near(333.333, mirek, 0.5)
  end)

  it("converts 10000K to 100 mirek with tolerance", function()
    local mirek = kelvin_to_mirek(10000)
    spec_helper.assert_near(100, mirek, 0.1)
  end)

  it("handles minimum kelvin (1000K)", function()
    local mirek = kelvin_to_mirek(1000)
    assert.is_true(mirek >= 100 and mirek <= 1000)
  end)

  it("handles high kelvin (10000K)", function()
    local mirek = kelvin_to_mirek(10000)
    assert.is_true(mirek >= 100 and mirek <= 1000)
  end)
end)