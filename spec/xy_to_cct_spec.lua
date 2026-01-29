local xy_to_cct = require 'color.xy_to_cct'

describe("xy_to_cct", function()
  it("converts xy (0.5, 1.0) to 1000K", function()
    local cct = xy_to_cct(0.5, 1.0)
    assert.are.equal(1000, cct)
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
end)