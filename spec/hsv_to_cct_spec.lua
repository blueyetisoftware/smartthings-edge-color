local hsv_to_cct = require 'color.hsv_to_cct'

describe("hsv_to_cct", function()
  it("converts HSV (0.5, 0.5, 0.5) to valid CCT range", function()
    local cct = hsv_to_cct(0.5, 0.5, 0.5)
    assert.is_true(cct >= 1000 and cct <= 40000)
  end)

  it("handles boundary HSV (0,0,0)", function()
    local cct = hsv_to_cct(0, 0, 0)
    assert.is_true(cct >= 1000 and cct <= 40000)
  end)

  it("handles boundary HSV (1,1,1)", function()
    local cct = hsv_to_cct(1, 1, 1)
    assert.is_true(cct >= 1000 and cct <= 40000)
  end)
end)