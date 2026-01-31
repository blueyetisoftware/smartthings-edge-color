--- Test specifications for rgb ↔ hsv conversion module

local convert = require 'color.convert.rgb_hsv'

describe('rgb ↔ hsv conversions', function()
local conversions = require 'color.convert.rgb_hsv'

    describe('rgb8_to_hsv', function()

        it('converts test case 1', function()
            local result = {conversions.rgb8_to_hsv(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 2', function()
            local result = {conversions.rgb8_to_hsv(255, 255, 255)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 3', function()
            local result = {conversions.rgb8_to_hsv(255, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 4', function()
            local result = {conversions.rgb8_to_hsv(0, 255, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 5', function()
            local result = {conversions.rgb8_to_hsv(0, 0, 255)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 6', function()
            local result = {conversions.rgb8_to_hsv(255, 255, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 7', function()
            local result = {conversions.rgb8_to_hsv(255, 0, 255)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 8', function()
            local result = {conversions.rgb8_to_hsv(0, 255, 255)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 9', function()
            local result = {conversions.rgb8_to_hsv(128, 128, 128)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 10', function()
            local result = {conversions.rgb8_to_hsv(51, 179, 230)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

    end)

    describe('rgb8_to_hsv360', function()

        it('converts test case 1', function()
        end)

        it('converts test case 2', function()
        end)

        it('converts test case 3', function()
        end)

        it('converts test case 4', function()
        end)

        it('converts test case 5', function()
        end)

        it('converts test case 6', function()
        end)

        it('converts test case 7', function()
        end)

        it('converts test case 8', function()
        end)

        it('converts test case 9', function()
        end)

        it('converts test case 10', function()
        end)

    end)

    describe('hex24_to_hsv', function()

        it('converts test case 1', function()
            local result = {conversions.hex24_to_hsv(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 2', function()
            local result = {conversions.hex24_to_hsv(1, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 3', function()
            local result = {conversions.hex24_to_hsv(1, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 4', function()
            local result = {conversions.hex24_to_hsv(0, 1, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 5', function()
            local result = {conversions.hex24_to_hsv(0, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 6', function()
            local result = {conversions.hex24_to_hsv(1, 1, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 7', function()
            local result = {conversions.hex24_to_hsv(1, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 8', function()
            local result = {conversions.hex24_to_hsv(0, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 9', function()
            local result = {conversions.hex24_to_hsv(0.5, 0.5, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 10', function()
            local result = {conversions.hex24_to_hsv(0.2, 0.7, 0.9)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

    end)

    describe('hex24_to_hsv360', function()

        it('converts test case 1', function()
        end)

        it('converts test case 2', function()
        end)

        it('converts test case 3', function()
        end)

        it('converts test case 4', function()
        end)

        it('converts test case 5', function()
        end)

        it('converts test case 6', function()
        end)

        it('converts test case 7', function()
        end)

        it('converts test case 8', function()
        end)

        it('converts test case 9', function()
        end)

        it('converts test case 10', function()
        end)

    end)

    describe('rgb100_to_hsv', function()

        it('converts test case 1', function()
            local result = {conversions.rgb100_to_hsv(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 2', function()
            local result = {conversions.rgb100_to_hsv(100, 100, 100)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 3', function()
            local result = {conversions.rgb100_to_hsv(100, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 4', function()
            local result = {conversions.rgb100_to_hsv(0, 100, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 5', function()
            local result = {conversions.rgb100_to_hsv(0, 0, 100)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 6', function()
            local result = {conversions.rgb100_to_hsv(100, 100, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 7', function()
            local result = {conversions.rgb100_to_hsv(100, 0, 100)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 8', function()
            local result = {conversions.rgb100_to_hsv(0, 100, 100)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 9', function()
            local result = {conversions.rgb100_to_hsv(50, 50, 50)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 10', function()
            local result = {conversions.rgb100_to_hsv(20, 70, 90)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

    end)

    describe('rgb100_to_hsv360', function()

        it('converts test case 1', function()
        end)

        it('converts test case 2', function()
        end)

        it('converts test case 3', function()
        end)

        it('converts test case 4', function()
        end)

        it('converts test case 5', function()
        end)

        it('converts test case 6', function()
        end)

        it('converts test case 7', function()
        end)

        it('converts test case 8', function()
        end)

        it('converts test case 9', function()
        end)

        it('converts test case 10', function()
        end)

    end)

    describe('rgb_to_hsv', function()

        it('converts test case 1', function()
            local result = {conversions.rgb_to_hsv(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 2', function()
            local result = {conversions.rgb_to_hsv(1, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 3', function()
            local result = {conversions.rgb_to_hsv(1, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 4', function()
            local result = {conversions.rgb_to_hsv(0, 1, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 5', function()
            local result = {conversions.rgb_to_hsv(0, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 6', function()
            local result = {conversions.rgb_to_hsv(1, 1, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 7', function()
            local result = {conversions.rgb_to_hsv(1, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 8', function()
            local result = {conversions.rgb_to_hsv(0, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 9', function()
            local result = {conversions.rgb_to_hsv(0.5, 0.5, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 10', function()
            local result = {conversions.rgb_to_hsv(0.2, 0.7, 0.9)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

    end)

    describe('hsv_to_rgb', function()

        it('converts test case 1', function()
            local result = {conversions.hsv_to_rgb(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 2', function()
            local result = {conversions.hsv_to_rgb(0, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 3', function()
            local result = {conversions.hsv_to_rgb(0, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 4', function()
            local result = {conversions.hsv_to_rgb(0.333, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 5', function()
            local result = {conversions.hsv_to_rgb(0.667, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 6', function()
            local result = {conversions.hsv_to_rgb(0.167, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 7', function()
            local result = {conversions.hsv_to_rgb(0.833, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 8', function()
            local result = {conversions.hsv_to_rgb(0.5, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 9', function()
            local result = {conversions.hsv_to_rgb(0, 0, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 10', function()
            local result = {conversions.hsv_to_rgb(0.1, 0.8, 0.6)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

    end)

end)