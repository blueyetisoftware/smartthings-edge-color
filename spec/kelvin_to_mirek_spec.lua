local kelvin_to_mirek = require 'color.kelvin_to_mirek'

describe("kelvin_to_mirek", function()
  it("converts 1000K to 1000 mirek", function()
    local mirek = kelvin_to_mirek(1000)
    assert.are.equal(1000, mirek)
  end)

  it("converts 3000K to 333 mirek", function()
    local mirek = kelvin_to_mirek(3000)
    assert.are.equal(333, mirek)
  end)

  it("converts 10000K to 100 mirek", function()
    local mirek = kelvin_to_mirek(10000)
    assert.are.equal(100, mirek)
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