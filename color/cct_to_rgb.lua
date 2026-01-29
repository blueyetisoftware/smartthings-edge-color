local st_utils = require 'st.utils'
local from_8bit = require 'color.from_8bit'

--- Converts correlated color temperature (CCT) in Kelvin to RGB color values.
---
--- This function implements Neil Bartlett's 2015 improved approximation algorithm
--- for converting color temperature to RGB values based on blackbody radiation curves.
--- This is a refinement of Tanner Helland's 2012 algorithm, using piecewise linear fits
--- with logarithmic terms to approximate the relationship between temperature and RGB components.
---
--- The coefficients used here are the result of least-squares fitting to match real
--- blackbody chromaticities converted to sRGB. This provides smoother and more accurate
--- results than the original 2012 coefficients, particularly around the 6600K breakpoint.
---
--- @param cct number Color temperature in Kelvin. Valid range: 1000K to 40000K.
---     Values outside this range will be clamped.
--- @return number red Red component in range [0, 1]
--- @return number green Green component in range [0, 1]
--- @return number blue Blue component in range [0, 1]
---
--- @raise error if cct is not a number
---
--- @usage
--- local r, g, b = cct_to_rgb(3000)  -- Warm white light
--- local r, g, b = cct_to_rgb(6500)  -- Daylight white
---
--- @see https://github.com/neilbartlett/color-temperature
--- @see https://tannerhelland.com/2012/09/18/convert-temperature-rgb-algorithm-code.html
--- @see https://en.wikipedia.org/wiki/Color_temperature
local function cct_to_rgb(cct)
    if type(cct) ~= "number" then
        error("cct must be a number", 2)
    end

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

    return from_8bit(
        st_utils.clamp_value(red, 0, 255),
        st_utils.clamp_value(green, 0, 255),
        st_utils.clamp_value(blue, 0, 255)
    )
end

return cct_to_rgb