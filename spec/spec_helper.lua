--- Helper utilities for busted test specs
local M = {}

--- Assert that two numbers are approximately equal within a tolerance
--- @param actual number The actual value
--- @param expected number The expected value
--- @param tolerance number The tolerance for comparison (default 1e-6)
--- @param message string Optional message for assertion failure
function M.assert_near(actual, expected, tolerance, message)
  tolerance = tolerance or 1e-6
  local diff = math.abs(actual - expected)
  assert(diff <= tolerance, message or string.format(
    "Expected %f to be near %f (diff: %f, tolerance: %f)",
    actual, expected, diff, tolerance))
end

--- Assert that three RGB values are approximately equal within tolerance
--- @param rgb1 table|number RGB table {r,g,b} or individual r
--- @param g1 number|nil Green component 1 or expected RGB table
--- @param b1 number|nil Blue component 1 or tolerance
--- @param r2 number|nil Expected red or nil
--- @param g2 number|nil Expected green or nil
--- @param b2 number|nil Expected blue or nil
--- @param tolerance number Tolerance (default 1e-3)
function M.assert_rgb_near(rgb1, g1, b1, r2, g2, b2, tolerance)
  if type(rgb1) == "table" and type(g1) == "table" then
    -- Called with two tables: assert_rgb_near(actual_rgb_table, expected_rgb_table, tolerance)
    local actual = rgb1
    local expected = g1
    tolerance = b1 or 1e-3
    M.assert_near(actual.r, expected.r, tolerance, "Red components differ")
    M.assert_near(actual.g, expected.g, tolerance, "Green components differ")
    M.assert_near(actual.b, expected.b, tolerance, "Blue components differ")
  else
    -- Original signature: assert_rgb_near(r1, g1, b1, r2, g2, b2, tolerance)
    tolerance = tolerance or 1e-3
    M.assert_near(rgb1, r2, tolerance, "Red components differ")
    M.assert_near(g1, g2, tolerance, "Green components differ")
    M.assert_near(b1, b2, tolerance, "Blue components differ")
  end
end

--- Assert that two HSV values are approximately equal within tolerance
--- @param hsv1 table|number HSV table {h,s,v} or individual h
--- @param s1 number|nil Saturation 1 or expected HSV table
--- @param v1 number|nil Value 1 or tolerance
--- @param h2 number|nil Expected hue or nil
--- @param s2 number|nil Expected saturation or nil
--- @param v2 number|nil Expected value or nil
--- @param tolerance number Tolerance (default 1e-3)
function M.assert_hsv_near(hsv1, s1, v1, h2, s2, v2, tolerance)
  if type(hsv1) == "table" and type(s1) == "table" then
    -- Called with two tables: assert_hsv_near(actual_hsv_table, expected_hsv_table, tolerance)
    local actual = hsv1
    local expected = s1
    tolerance = v1 or 1e-3
    M.assert_near(actual.h, expected.h, tolerance, "Hue components differ")
    M.assert_near(actual.s, expected.s, tolerance, "Saturation components differ")
    M.assert_near(actual.v, expected.v, tolerance, "Value components differ")
  else
    -- Original signature: assert_hsv_near(h1, s1, v1, h2, s2, v2, tolerance)
    tolerance = tolerance or 1e-3
    M.assert_near(hsv1, h2, tolerance, "Hue components differ")
    M.assert_near(s1, s2, tolerance, "Saturation components differ")
    M.assert_near(v1, v2, tolerance, "Value components differ")
  end
end

--- Assert that two xyY values are approximately equal within tolerance
--- @param xyy1 table|number xyY table {x,y,Y} or individual x
--- @param y1 number|nil y 1 or expected xyY table
--- @param Y1 number|nil Y 1 or tolerance
--- @param x2 number|nil Expected x or nil
--- @param y2 number|nil Expected y or nil
--- @param Y2 number|nil Expected Y or nil
--- @param tolerance number Tolerance (default 1e-3)
function M.assert_xyy_near(xyy1, y1, Y1, x2, y2, Y2, tolerance)
  if type(xyy1) == "table" and type(y1) == "table" then
    -- Called with two tables: assert_xyy_near(actual_xyy_table, expected_xyy_table, tolerance)
    local actual = xyy1
    local expected = y1
    tolerance = Y1 or 1e-3
    M.assert_near(actual.x, expected.x, tolerance, "x components differ")
    M.assert_near(actual.y, expected.y, tolerance, "y components differ")
    M.assert_near(actual.Y, expected.Y, tolerance, "Y components differ")
  else
    -- Original signature: assert_xyy_near(x1, y1, Y1, x2, y2, Y2, tolerance)
    tolerance = tolerance or 1e-3
    M.assert_near(xyy1, x2, tolerance, "x components differ")
    M.assert_near(y1, y2, tolerance, "y components differ")
    M.assert_near(Y1, Y2, tolerance, "Y components differ")
  end
end

--- Assert that a value is NaN
--- @param value any The value to check
--- @param message string Optional message for assertion failure
function M.assert_is_nan(value, message)
  local is_nan = value ~= value  -- NaN is the only value where x ~= x
  assert(is_nan, message or string.format("Expected NaN but got %s", tostring(value)))
end

return M