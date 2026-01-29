local xy_to_cct = require 'color.xy_to_cct'
local spec_helper = require 'spec.spec_helper'

describe("xy_to_cct", function()
  it("converts xy (0.5, 1.0) to approx 1000K with tolerance", function()
    local cct = xy_to_cct(0.5, 1.0)
    spec_helper.assert_near(1000, cct, 100)
  end)

  it("handles valid xy ranges", function()
    local cct = xy_to_cct(0.3, 0.3)
    assert.is_true(cct >= 1000 and cct <= 40000)
  end)

  it("handles boundary xy (0,0)", function()
    local cct = xy_to_cct(0, 0)
    assert.is_true(cct >= 1000 and cct <= 40000)
  end)

  it("handles boundary xy (1,1)", function()
    local cct = xy_to_cct(1, 1)
    assert.is_true(cct >= 1000 and cct <= 40000)
  end)

  it("defaults Y to 1.0 when omitted", function()
    local cct1 = xy_to_cct(0.5, 1.0, 1.0)
    local cct2 = xy_to_cct(0.5, 1.0)
    spec_helper.assert_near(cct1, cct2, 1e-10)
  end)
end)