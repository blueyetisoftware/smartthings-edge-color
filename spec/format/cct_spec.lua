local Format = require 'color.format'

describe("clampKelvin", function()
  it("clamps values to Kelvin range", function()
    local k = Format.clampKelvin(500)
    assert.are.equal(1000, k)
  end)

  it("handles boundary values", function()
    local k1 = Format.clampKelvin(1000)
    local k2 = Format.clampKelvin(40000)
    assert.are.equal(1000, k1)
    assert.are.equal(40000, k2)
  end)

  it("clamps out-of-range values", function()
    local k1 = Format.clampKelvin(500)
    local k2 = Format.clampKelvin(50000)
    assert.are.equal(1000, k1)
    assert.are.equal(40000, k2)
  end)
end)

describe("clampMired", function()
  it("passes through valid mired values", function()
    local m1 = Format.clampMired(100)
    local m2 = Format.clampMired(500)
    local m3 = Format.clampMired(1000)
    assert.are.equal(100, m1)
    assert.are.equal(500, m2)
    assert.are.equal(1000, m3)
  end)

  it("clamps out-of-range values", function()
    local m1 = Format.clampMired(10)
    local m2 = Format.clampMired(1500)
    assert.are.equal(25, m1)
    assert.are.equal(1000, m2)
  end)
end)

describe("toMired", function()
  it("converts 1000K to 1000 mired exactly", function()
    local mired = Format.toMired(1000)
    assert.equals(1000, mired)
  end)

  it("converts 3000K to 333 mired exactly", function()
    local mired = Format.toMired(3000)
    assert.equals(333, mired)
  end)

  it("converts 10000K to 100 mired exactly", function()
    local mired = Format.toMired(10000)
    assert.equals(100, mired)
  end)

  it("handles minimum kelvin (1000K)", function()
    local mired = Format.toMired(1000)
    assert.is_true(mired >= 100 and mired <= 1000)
  end)

  it("handles high kelvin (10000K)", function()
    local mired = Format.toMired(10000)
    assert.is_true(mired >= 100 and mired <= 1000)
  end)

  it("clamps low kelvin values to 1000K", function()
    local mired = Format.toMired(500)  -- Below minimum
    assert.equals(1000, mired)  -- 1000000 / 1000 = 1000
  end)

  it("clamps high kelvin values to 40000K", function()
    local mired = Format.toMired(50000)  -- Above maximum
    assert.equals(25, mired)  -- 1000000 / 40000 = 25
  end)
end)

describe("toKelvin", function()
  it("converts 100 mired to 10000K exactly", function()
    local kelvin = Format.toKelvin(100)
    assert.equals(10000, kelvin)
  end)

  it("converts 333 mired to 3003K exactly", function()
    local kelvin = Format.toKelvin(333)
    assert.equals(3003, kelvin)
  end)

  it("converts 1000 mired to 1000K exactly", function()
    local kelvin = Format.toKelvin(1000)
    assert.equals(1000, kelvin)
  end)

  it("handles minimum mired (100)", function()
    local kelvin = Format.toKelvin(100)
    assert.is_true(kelvin >= 1000 and kelvin <= 10000)
  end)

  it("handles maximum mired (1000)", function()
    local kelvin = Format.toKelvin(1000)
    assert.is_true(kelvin >= 1000 and kelvin <= 10000)
  end)

  it("clamps low mired values to 25", function()
    local kelvin = Format.toKelvin(10)  -- Below minimum
    assert.equals(40000, kelvin)  -- 1000000 / 25 = 40000
  end)

  it("clamps high mired values to 1000", function()
    local kelvin = Format.toKelvin(1200)  -- Above maximum
    assert.equals(1000, kelvin)  -- 1000000 / 1000 = 1000
  end)
end)