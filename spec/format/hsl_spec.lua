local HSL = require 'color.format.hsl'
local spec_helper = require 'spec.spec_helper'

describe("clamp_hsl", function()
  it("wraps hue modulo 1 and clamps other values", function()
    local h, s, l = HSL.clamp_hsl(1.5, 0.8, 0.6)
    assert.are.equal(0.5, h)  -- 1.5 % 1 = 0.5
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, l)
  end)

  it("handles negative hue values", function()
    local h, s, l = HSL.clamp_hsl(-0.3, 0.5, 0.7)
    assert.are.equal(0.7, h)  -- -0.3 % 1 = 0.7
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, l)
  end)

  it("clamps saturation/lightness to [0, 1]", function()
    local h, s, l = HSL.clamp_hsl(0.2, -0.1, 1.2)
    assert.are.equal(0.2, h)
    assert.are.equal(0, s)
    assert.are.equal(1, l)
  end)

  it("handles boundary values", function()
    local h, s, l = HSL.clamp_hsl(0, 0, 0)
    assert.are.equal(0, h)
    assert.are.equal(0, s)
    assert.are.equal(0, l)
  end)
end)

describe("clamp_hsl360", function()
  it("wraps degrees hue modulo 360 and clamps other values", function()
    local h, s, l = HSL.clamp_hsl360(450, 0.8, 0.6)  -- 450 % 360 = 90
    assert.are.equal(90, h)
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, l)
  end)

  it("handles negative degrees", function()
    local h, s, l = HSL.clamp_hsl360(-90, 0.5, 0.7)  -- -90 % 360 = 270
    assert.are.equal(270, h)
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, l)
  end)

  it("clamps saturation/lightness to [0, 1]", function()
    local h, s, l = HSL.clamp_hsl360(180, -0.1, 1.2)
    assert.are.equal(180, h)
    assert.are.equal(0, s)
    assert.are.equal(1, l)
  end)

  it("handles boundary values", function()
    local h, s, l = HSL.clamp_hsl360(0, 0, 0)
    assert.are.equal(0, h)
    assert.are.equal(0, s)
    assert.are.equal(0, l)
  end)
end)

describe("to_hsl360", function()
  it("converts normalized HSL to degrees", function()
    local h, s, l = HSL.to_hsl360(0.25, 0.8, 0.6)  -- 0.25 * 360 = 90
    assert.are.equal(90, h)
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, l)
  end)

  it("wraps hue values", function()
    local h, s, l = HSL.to_hsl360(1.25, 0.5, 0.7)  -- 1.25 * 360 = 450, 450 % 360 = 90
    assert.are.equal(90, h)
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, l)
  end)
end)

describe("from_hsl360", function()
  it("converts degrees HSL to normalized", function()
    local h, s, l = HSL.from_hsl360(90, 0.8, 0.6)  -- 90 / 360 = 0.25
    assert.are.equal(0.25, h)
    assert.are.equal(0.8, s)
    assert.are.equal(0.6, l)
  end)

  it("wraps hue values", function()
    local h, s, l = HSL.from_hsl360(450, 0.5, 0.7)  -- 450 % 360 = 90, 90 / 360 = 0.25
    assert.are.equal(0.25, h)
    assert.are.equal(0.5, s)
    assert.are.equal(0.7, l)
  end)
end)