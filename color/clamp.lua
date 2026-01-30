local st_utils = require 'st.utils'

local Clamp = {}

--- Clamps values to 8-bit integer range [0, 255].
---
--- @param a number First value to clamp
--- @param b number|nil Second value to clamp (optional)
--- @param c number|nil Third value to clamp (optional)
--- @return number|number,number|number,number,number Clamped value(s)
function Clamp.clamp8(a, b, c)
    if c ~= nil then
        return st_utils.round(st_utils.clamp_value(a, 0, 255)), st_utils.round(st_utils.clamp_value(b, 0, 255)), st_utils.round(st_utils.clamp_value(c, 0, 255))
    elseif b ~= nil then
        return st_utils.round(st_utils.clamp_value(a, 0, 255)), st_utils.round(st_utils.clamp_value(b, 0, 255))
    else
        return st_utils.round(st_utils.clamp_value(a, 0, 255))
    end
end

--- Clamps values to 16-bit integer range [0, 65535].
---
--- @param a number First value to clamp
--- @param b number|nil Second value to clamp (optional)
--- @param c number|nil Third value to clamp (optional)
--- @return number|number,number|number,number,number Clamped value(s)
function Clamp.clamp16(a, b, c)
    if c ~= nil then
        return st_utils.round(st_utils.clamp_value(a, 0, 65535)), st_utils.round(st_utils.clamp_value(b, 0, 65535)), st_utils.round(st_utils.clamp_value(c, 0, 65535))
    elseif b ~= nil then
        return st_utils.round(st_utils.clamp_value(a, 0, 65535)), st_utils.round(st_utils.clamp_value(b, 0, 65535))
    else
        return st_utils.round(st_utils.clamp_value(a, 0, 65535))
    end
end

--- Clamps values to normalized float range [0, 1].
---
--- @param a number First value to clamp
--- @param b number|nil Second value to clamp (optional)
--- @param c number|nil Third value to clamp (optional)
--- @return number|number,number|number,number,number Clamped value(s)
function Clamp.clampF(a, b, c)
    if c ~= nil then
        return st_utils.clamp_value(a, 0, 1), st_utils.clamp_value(b, 0, 1), st_utils.clamp_value(c, 0, 1)
    elseif b ~= nil then
        return st_utils.clamp_value(a, 0, 1), st_utils.clamp_value(b, 0, 1)
    else
        return st_utils.clamp_value(a, 0, 1)
    end
end

--- Clamps values to normalized hue range [0, 1).
---
--- @param a number First value to clamp
--- @param b number|nil Second value to clamp (optional)
--- @param c number|nil Third value to clamp (optional)
--- @return number|number,number|number,number,number Clamped value(s)
function Clamp.clampHue(a, b, c)
    if c ~= nil then
        return a % 1, b % 1, c % 1
    elseif b ~= nil then
        return a % 1, b % 1
    else
        return a % 1
    end
end

--- Clamps values to degree range [0, 360).
---
--- @param a number First value to clamp
--- @param b number|nil Second value to clamp (optional)
--- @param c number|nil Third value to clamp (optional)
--- @return number|number,number|number,number,number Clamped value(s)
function Clamp.clampDeg(a, b, c)
    if c ~= nil then
        return a % 360, b % 360, c % 360
    elseif b ~= nil then
        return a % 360, b % 360
    else
        return a % 360
    end
end

--- Clamps values to percentage range [0, 100].
---
--- @param a number First value to clamp
--- @param b number|nil Second value to clamp (optional)
--- @param c number|nil Third value to clamp (optional)
--- @return number|number,number|number,number,number Clamped value(s)
function Clamp.clampPct(a, b, c)
    if c ~= nil then
        return st_utils.clamp_value(a, 0, 100), st_utils.clamp_value(b, 0, 100), st_utils.clamp_value(c, 0, 100)
    elseif b ~= nil then
        return st_utils.clamp_value(a, 0, 100), st_utils.clamp_value(b, 0, 100)
    else
        return st_utils.clamp_value(a, 0, 100)
    end
end

return Clamp