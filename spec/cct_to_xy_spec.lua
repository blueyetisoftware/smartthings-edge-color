local cct_to_xy = require 'color.cct_to_xy'

describe("cct_to_xy", function()
  it("converts 3000K to valid xy", function()
    local x, y = cct_to_xy(3000)
    assert.is_true(x >= 0 and x <= 1)
    assert.is_true(y >= 0 and y <= 1)
  end)

  it("converts 1000K to valid xy", function()
    local x, y = cct_to_xy(1000)
    assert.is_true(x >= 0 and x <= 1)
    assert.is_true(y >= 0 and y <= 1)
  end)

  it("handles boundary 1000K", function()
    local x, y = cct_to_xy(1000)
    assert.is_true(x >= 0 and x <= 1)
    assert.is_true(y >= 0 and y <= 1)
  end)

  it("handles boundary 40000K", function()
    local x, y = cct_to_xy(40000)
    assert.is_true(x >= 0 and x <= 1)
    assert.is_true(y >= 0 and y <= 1)
  end)
end)