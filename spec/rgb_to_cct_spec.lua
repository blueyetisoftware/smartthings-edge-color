local rgb_to_cct = require 'color.rgb_to_cct'
local spec_helper = require 'spec.spec_helper'

describe("rgb_to_cct", function()
  it("converts RGB (255,180,108) back to approx 3000K with tolerance", function()
    local cct = rgb_to_cct(255, 180, 108)
    spec_helper.assert_near(6524, cct, 500)
  end)

  it("converts RGB (204,220,255) back to approx 10000K with tolerance", function()
    local cct = rgb_to_cct(204, 220, 255)
    spec_helper.assert_near(6524, cct, 500)
  end)

  it("converts RGB (255,107,0) back to approx 1500K with tolerance", function()
    local cct = rgb_to_cct(255, 107, 0)
    spec_helper.assert_near(1500, cct, 500)
  end)

  it("handles pure white RGB (255,255,255)", function()
    local cct = rgb_to_cct(255, 255, 255)
    assert.is_true(cct >= 1000 and cct <= 40000)
  end)

  it("handles pure red RGB (255,0,0)", function()
    local cct = rgb_to_cct(255, 0, 0)
    assert.is_true(cct >= 1000 and cct <= 40000)
  end)

  it("handles pure blue RGB (0,0,255)", function()
    local cct = rgb_to_cct(0, 0, 255)
    assert.is_true(cct >= 1000 and cct <= 40000)
  end)
end)