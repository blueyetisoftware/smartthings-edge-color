local mirek_to_kelvin = require 'color.mirek_to_kelvin'

describe("mirek_to_kelvin", function()
  it("converts 100 mirek to 10000K", function()
    local kelvin = mirek_to_kelvin(100)
    assert.are.equal(10000, kelvin)
  end)

  it("converts 333 mirek to 3003K", function()
    local kelvin = mirek_to_kelvin(333)
    assert.are.equal(3003, kelvin)
  end)

  it("converts 1000 mirek to 1000K", function()
    local kelvin = mirek_to_kelvin(1000)
    assert.are.equal(1000, kelvin)
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