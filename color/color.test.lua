local Color = require 'color'

do
    print(Color.rgb_to_cct(204, 220, 255))
    print(Color.hsv_to_xy(50, 50))
    print(Color.xy_to_hsv(16206, 21550))
    print(Color.xy_to_cct(50, 100))
    print(Color.to_8bit(Color.cct_to_rgb(3000)))
end

do
    local r, g, b = Color.to_8bit(Color.cct_to_rgb(3000))
    assert(r == 255)
    assert(g == 180)
    assert(b == 108)
end

do
    local r, g, b = Color.to_8bit(Color.cct_to_rgb(10000))
    assert(r == 204)
    assert(g == 220)
    assert(b == 255)
end

do
    local r, g, b = Color.to_8bit(Color.cct_to_rgb(1500))
    assert(r == 255)
    assert(g == 107)
    assert(b == 0)
end

do
    assert(math.abs(Color.rgb_to_cct(255, 180, 108) - 3000) <= 500)
    assert(math.abs(Color.rgb_to_cct(204, 220, 255) - 10000) <= 500)
    assert(math.abs(Color.rgb_to_cct(255, 107, 0) - 1500) <= 500)
end


