local utils = require 'st.utils'

local Color = {}

-- @param red color component in range [0, 1]
-- @param green color component in range [0, 1]
-- @param blue color component in range [0, 1]
-- @return color temperature in kelvin
function Color.rgb_to_cct(r, g, b)
    local ratio = b / r
    local cct, _
    local epsilon = 0.4
    local min = 1000
    local max = 40000

    while max - min > epsilon do
        cct = (max + min) / 2
        r, _, b = Color.cct_to_rgb(cct)
        if b / r >= ratio then
            max = cct
        else
            min = cct
        end
    end

    return utils.round(cct)
end

-- @param cct color temperature in kelvin
-- @return red color component in range [0, 1]
-- @return green color component in range [0, 1]
-- @return blue color component in range [0, 1]
function Color.cct_to_rgb(cct)
    local temperature = cct / 100.0
    local red, green, blue

    local fit = function(a, b, c, x)
        -- a + b x + c log(x)
        return a + b * x + c * math.log(x)
    end

    -- calculate red

    if temperature < 66.0 then
        red = 255
    else
        red = fit(351.97690566805693, 0.114206453784165, -40.25366309332127, temperature - 55.0)
    end

    -- calculate green

    if temperature < 66.0 then
        green = fit(-155.25485562709179, -0.44596950469579133, 104.49216199393888, temperature - 2)
    else
        green = fit(325.4494125711974, 0.07943456536662342, -28.0852963507957, temperature - 50)
    end

    -- calculate blue

    if temperature >= 66.0 then
        blue = 255
    elseif temperature <= 20.0 then
        blue = 0
    else
        blue = fit(-254.76935184120902, 0.8274096064007395, 115.67994401066147, temperature - 10)
    end

    return Color.from_8bit(
        utils.clamp_value(red, 0, 255),
        utils.clamp_value(green, 0, 255),
        utils.clamp_value(blue, 0, 255)
    )
end

-- @param x coordinate [0, 1]
-- @param y coordinate [0, 1]
-- @param Y brightness [0, 1]
-- @return cct in kelvin
function Color.xy_to_cct(x, y, Y)
    return Color.rgb_to_cct(Color.xy_to_rgb(x, y, Y or 1))
end

-- @param cct color temperature in kelvin
-- @return x coordinate [0, 1]
-- @return y coordinate [0, 1]
-- @return Y brightness [0, 1]
function Color.cct_to_xy(cct)
    return Color.rgb_to_xy(Color.cct_to_rgb(cct))
end

-- @param x coordinate [0, 1]
-- @param y coordinate [0, 1]
-- @param Y brightness [0, 1]
-- @return red color component in range [0, 1]
-- @return green color component in range [0, 1]
-- @return blue color component in range [0, 1]
function Color.xy_to_rgb(x, y, Y)
    return utils.xy_to_rgb(x, y, Y or 1)
end

-- @param red color component in range [0, 1]
-- @param green color component in range [0, 1]
-- @param blue color component in range [0, 1]
-- @return x coordinate [0, 1]
-- @return y coordinate [0, 1]
-- @return Y brightness [0, 1]
function Color.rgb_to_xy(r, g, b)
    return utils.rgb_to_xy(r, g, b)
end

function Color.hsv_to_rgb(h, s, v)
    return utils.hsv_to_rgb(h, s, v or 1)
end

function Color.rgb_to_hsv(r, g, b)
    return utils.rgb_to_hsv(r, g, b)
end

-- @param x [0, 1]
-- @param y [0, 1]
-- @param Y [0, 1]
-- @return h [0, 1]
-- @return s [0, 1]
function Color.xy_to_hsv(x, y, Y)
    return Color.rgb_to_hsv(Color.xy_to_rgb(x, y, Y or 1))
end

-- @param h [0, 1]
-- @param s [0, 1]
-- @return x [0, 1]
-- @return y [0, 1]
-- @return Y [0, 1]
function Color.hsv_to_xy(h, s, v)
    return Color.rgb_to_xy(Color.hsv_to_rgb(h, s, v or 1))
end

function Color.cct_to_hsv(cct)
    return Color.xy_to_hsv(Color.cct_to_xy(cct))
end

function Color.hsv_to_cct(h, s, v)
    return Color.xy_to_cct(Color.hsv_to_xy(h, s, v or 1))
end

function Color.round(a, b, c)
    assert(a ~= nil)
    if c ~= nil then
        return utils.round(a), utils.round(b), utils.round(c)
    elseif b ~= nil then
        return utils.round(a), utils.round(b)
    elseif a ~= nil then
        return utils.round(a)
    end
end

function Color.scale(scalar, a, b, c)
    assert(a ~= nil)
    if c ~= nil then
        return a * scalar, b * scalar, c * scalar
    elseif b ~= nil then
        return a * scalar, b * scalar
    elseif a ~= nil then
        return a * scalar
    end
end

function Color.to_percentage(a, b, c)
    return Color.scale(100.0, a, b, c)
end

function Color.from_percentage(a, b, c)
    return Color.scale(1 / 100.0, a, b, c)
end

function Color.to_degrees(a, b, c)
    return Color.scale(360.0, a, b, c)
end

function Color.from_degrees(a, b, c)
    return Color.scale(1 / 360.0, a, b, c)
end

function Color.to_8bit(a, b, c)
    return Color.round(Color.scale(255.0, a, b, c))
end

function Color.from_8bit(a, b, c)
    return Color.scale(1 / 255.0, a, b, c)
end

function Color.to_16bit(a, b, c)
    return Color.round(Color.scale(65535.0, a, b, c))
end

function Color.from_16bit(a, b, c)
    return Color.scale(1 / 65535.0, a, b, c)
end

function Color.kelvin_to_mirek(kelvin)
    return utils.round(1000000.0 / kelvin)
end

function Color.mirek_to_kelvin(mirek)
    return utils.round(1000000.0 / mirek)
end

if require then
    return Color
end
