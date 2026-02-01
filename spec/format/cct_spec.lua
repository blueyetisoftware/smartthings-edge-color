local CCT = require 'color.format.cct'

describe("clamp_kelvin", function()
  it("clamps values to SmartThings Kelvin range [1, 30000]", function()
    local k = CCT.clamp_kelvin(0)
    assert.are.equal(1, k)
  end)

  it("handles boundary values", function()
    local k1 = CCT.clamp_kelvin(1)
    local k2 = CCT.clamp_kelvin(30000)
    assert.are.equal(1, k1)
    assert.are.equal(30000, k2)
  end)

  it("clamps out-of-range values", function()
    local k1 = CCT.clamp_kelvin(0)
    local k2 = CCT.clamp_kelvin(40000)
    assert.are.equal(1, k1)
    assert.are.equal(30000, k2)
  end)
end)

describe("clamp_mired", function()
  it("passes through valid mired values", function()
    local m1 = CCT.clamp_mired(100)
    local m2 = CCT.clamp_mired(500)
    local m3 = CCT.clamp_mired(1000)
    assert.are.equal(100, m1)
    assert.are.equal(500, m2)
    assert.are.equal(1000, m3)
  end)

  it("clamps out-of-range values", function()
    local m1 = CCT.clamp_mired(10)
    local m2 = CCT.clamp_mired(1500000)
    assert.are.equal(33, m1)
    assert.are.equal(1000000, m2)
  end)
end)

describe("cctk_to_cctm", function()
  it("converts 1000K to 1000 mired exactly", function()
    local mired = CCT.cctk_to_cctm(1000)
    assert.equals(1000, mired)
  end)

  it("converts 3000K to 333 mired exactly", function()
    local mired = CCT.cctk_to_cctm(3000)
    assert.equals(333, mired)
  end)

  it("converts 10000K to 100 mired exactly", function()
    local mired = CCT.cctk_to_cctm(10000)
    assert.equals(100, mired)
  end)

  it("handles minimum kelvin (1000K)", function()
    local mired = CCT.cctk_to_cctm(1000)
    assert.is_true(mired >= 100 and mired <= 1000)
  end)

  it("handles high kelvin (10000K)", function()
    local mired = CCT.cctk_to_cctm(10000)
    assert.is_true(mired >= 100 and mired <= 1000)
  end)

  it("handles valid kelvin values", function()
    local mired = CCT.cctk_to_cctm(500)  -- Valid value
    assert.equals(2000, mired)  -- 1000000 / 500 = 2000
  end)

  it("clamps low kelvin values to 1K", function()
    local mired = CCT.cctk_to_cctm(0)  -- Below minimum
    assert.equals(1000000, mired)  -- 1000000 / 1 = 1000000
  end)

  it("clamps high kelvin values to 30000K", function()
    local mired = CCT.cctk_to_cctm(40000)  -- Above maximum
    assert.equals(33, mired)  -- 1000000 / 30000 ≈ 33
  end)
end)

describe("cctm_to_cctk", function()
  it("converts 100 mired to 10000K exactly", function()
    local kelvin = CCT.cctm_to_cctk(100)
    assert.equals(10000, kelvin)
  end)

  it("converts 333 mired to 3003K exactly", function()
    local kelvin = CCT.cctm_to_cctk(333)
    assert.equals(3003, kelvin)
  end)

  it("converts 1000 mired to 1000K exactly", function()
    local kelvin = CCT.cctm_to_cctk(1000)
    assert.equals(1000, kelvin)
  end)

  it("handles minimum mired (100)", function()
    local kelvin = CCT.cctm_to_cctk(100)
    assert.is_true(kelvin >= 1000 and kelvin <= 10000)
  end)

  it("handles maximum mired (1000)", function()
    local kelvin = CCT.cctm_to_cctk(1000)
    assert.is_true(kelvin >= 1 and kelvin <= 30000)
  end)

  it("clamps low mired values to 33", function()
    local kelvin = CCT.cctm_to_cctk(10)  -- Below minimum
    assert.equals(30303, kelvin)  -- 1000000 / 33 ≈ 30303
  end)

  it("clamps high mired values to 1000000", function()
    local kelvin = CCT.cctm_to_cctk(1200000)  -- Above maximum
    assert.equals(1, kelvin)  -- 1000000 / 1000000 = 1
  end)
end)