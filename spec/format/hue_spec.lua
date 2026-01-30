local Format = require 'color.format'
local spec_helper = require 'spec.spec_helper'

describe("clampHFF", function()
  it("wraps hue modulo 1 and clamps other values", function()
    local h, s, v = Format.clampHFF(1.5, 0.8, 0.6)
    assert.are.equal(0.5, h)  -- 1.5 % 1 = 0.5
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, v)
  end)

  it("handles negative hue values", function()
    local h, s, v = Format.clampHFF(-0.3, 0.5, 0.7)
    assert.are.equal(0.7, h)  -- -0.3 % 1 = 0.7
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, v)
  end)

  it("clamps saturation/value to [0, 1]", function()
    local h, s, v = Format.clampHFF(0.2, -0.1, 1.2)
    assert.are.equal(0.2, h)
    assert.are.equal(0, s)
    assert.are.equal(1, v)
  end)

  it("handles boundary values", function()
    local h, s, v = Format.clampHFF(0, 0, 0)
    assert.are.equal(0, h)
    assert.are.equal(0, s)
    assert.are.equal(0, v)
  end)
end)

describe("clampHdFF", function()
  it("wraps degrees hue modulo 360 and clamps other values", function()
    local h, s, v = Format.clampHdFF(450, 0.8, 0.6)  -- 450 % 360 = 90
    assert.are.equal(90, h)
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, v)
  end)

  it("handles negative degrees", function()
    local h, s, v = Format.clampHdFF(-90, 0.5, 0.7)  -- -90 % 360 = 270
    assert.are.equal(270, h)
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, v)
  end)

  it("clamps saturation/value to [0, 1]", function()
    local h, s, v = Format.clampHdFF(180, -0.1, 1.2)
    assert.are.equal(180, h)
    assert.are.equal(0, s)
    assert.are.equal(1, v)
  end)
end)

describe("toHdFF", function()
  it("converts normalized hue to degrees", function()
    local h, s, v = Format.toHdFF(0.5, 0.8, 0.6)  -- 0.5 * 360 = 180
    assert.are.equal(180, h)
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, v)
  end)

  it("wraps converted degrees", function()
    local h, s, v = Format.toHdFF(1.25, 0.5, 0.7)  -- 1.25 * 360 = 450, 450 % 360 = 90
    assert.are.equal(90, h)
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, v)
  end)

  it("clamps saturation/value", function()
    local h, s, v = Format.toHdFF(0.3, 1.2, -0.1)
    spec_helper.assert_near(108, h, 0.1)  -- 0.3 * 360 = 108
    assert.are.equal(1, s)
    assert.are.equal(0, v)
  end)
end)

describe("fromHdFF", function()
  it("converts degrees hue to normalized", function()
    local h, s, v = Format.fromHdFF(180, 0.8, 0.6)  -- 180 / 360 = 0.5
    assert.are.equal(0.5, h)
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, v)
  end)

  it("wraps converted normalized hue", function()
    local h, s, v = Format.fromHdFF(450, 0.5, 0.7)  -- 450 / 360 = 1.25, 1.25 % 1 = 0.25
    assert.are.equal(0.25, h)
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, v)
  end)

  it("clamps saturation/value", function()
    local h, s, v = Format.fromHdFF(90, 1.2, -0.1)
    spec_helper.assert_near(0.25, h, 1e-10)  -- 90 / 360 = 0.25
    assert.are.equal(1, s)
    assert.are.equal(0, v)
  end)
end)