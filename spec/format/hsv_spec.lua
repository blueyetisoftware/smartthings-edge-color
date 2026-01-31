local HSV = require 'color.format.hsv'
local spec_helper = require 'spec.spec_helper'

describe("clamp_hsv", function()
  it("wraps hue modulo 1 and clamps other values", function()
    local h, s, v = HSV.clamp_hsv(1.5, 0.8, 0.6)
    assert.are.equal(0.5, h)  -- 1.5 % 1 = 0.5
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, v)
  end)

  it("handles negative hue values", function()
    local h, s, v = HSV.clamp_hsv(-0.3, 0.5, 0.7)
    assert.are.equal(0.7, h)  -- -0.3 % 1 = 0.7
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, v)
  end)

  it("clamps saturation/value to [0, 1]", function()
    local h, s, v = HSV.clamp_hsv(0.2, -0.1, 1.2)
    assert.are.equal(0.2, h)
    assert.are.equal(0, s)
    assert.are.equal(1, v)
  end)

  it("handles boundary values", function()
    local h, s, v = HSV.clamp_hsv(0, 0, 0)
    assert.are.equal(0, h)
    assert.are.equal(0, s)
    assert.are.equal(0, v)
  end)
end)

describe("clamp_hsv360", function()
  it("wraps degrees hue modulo 360 and clamps other values", function()
    local h, s, v = HSV.clamp_hsv360(450, 0.8, 0.6)  -- 450 % 360 = 90
    assert.are.equal(90, h)
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, v)
  end)

  it("handles negative degrees", function()
    local h, s, v = HSV.clamp_hsv360(-90, 0.5, 0.7)  -- -90 % 360 = 270
    assert.are.equal(270, h)
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, v)
  end)

  it("clamps saturation/value to [0, 1]", function()
    local h, s, v = HSV.clamp_hsv360(180, -0.1, 1.2)
    assert.are.equal(180, h)
    assert.are.equal(0, s)
    assert.are.equal(1, v)
  end)

  it("handles boundary values", function()
    local h, s, v = HSV.clamp_hsv360(0, 0, 0)
    assert.are.equal(0, h)
    assert.are.equal(0, s)
    assert.are.equal(0, v)
  end)
end)

describe("to_hsv360", function()
  it("converts normalized HSV to degrees", function()
    local h, s, v = HSV.to_hsv360(0.25, 0.8, 0.6)  -- 0.25 * 360 = 90
    assert.are.equal(90, h)
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, v)
  end)

  it("wraps hue values", function()
    local h, s, v = HSV.to_hsv360(1.25, 0.5, 0.7)  -- 1.25 * 360 = 450, 450 % 360 = 90
    assert.are.equal(90, h)
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, v)
  end)
end)

describe("from_hsv360", function()
  it("converts degrees HSV to normalized", function()
    local h, s, v = HSV.from_hsv360(90, 0.8, 0.6)  -- 90 / 360 = 0.25
    assert.are.equal(0.25, h)
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, v)
  end)

  it("wraps hue values", function()
    local h, s, v = HSV.from_hsv360(450, 0.5, 0.7)  -- 450 % 360 = 90, 90 / 360 = 0.25
    assert.are.equal(0.25, h)
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, v)
  end)
end)