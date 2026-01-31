--- Test specifications for rgb ↔ cct conversion module

local convert = require 'color.convert.rgb_cct'

describe('rgb ↔ cct conversions', function()

    describe('rgb8_to_cctk', function()

        it('converts test case 1', function()
            local result = convert.rgb8_to_cctk(0, 0, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 2', function()
            local result = convert.rgb8_to_cctk(255, 255, 255)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 3', function()
            local result = convert.rgb8_to_cctk(255, 0, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 4', function()
            local result = convert.rgb8_to_cctk(0, 255, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 5', function()
            local result = convert.rgb8_to_cctk(0, 0, 255)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 6', function()
            local result = convert.rgb8_to_cctk(255, 255, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 7', function()
            local result = convert.rgb8_to_cctk(255, 0, 255)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 8', function()
            local result = convert.rgb8_to_cctk(0, 255, 255)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 9', function()
            local result = convert.rgb8_to_cctk(128, 128, 128)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 10', function()
            local result = convert.rgb8_to_cctk(51, 179, 230)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

    end)

    describe('rgb8_to_cctm', function()

        it('converts test case 1', function()
            local result = convert.rgb8_to_cctm(0, 0, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 2', function()
            local result = convert.rgb8_to_cctm(255, 255, 255)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 3', function()
            local result = convert.rgb8_to_cctm(255, 0, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 4', function()
            local result = convert.rgb8_to_cctm(0, 255, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 5', function()
            local result = convert.rgb8_to_cctm(0, 0, 255)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 6', function()
            local result = convert.rgb8_to_cctm(255, 255, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 7', function()
            local result = convert.rgb8_to_cctm(255, 0, 255)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 8', function()
            local result = convert.rgb8_to_cctm(0, 255, 255)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 9', function()
            local result = convert.rgb8_to_cctm(128, 128, 128)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 10', function()
            local result = convert.rgb8_to_cctm(51, 179, 230)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

    end)

    describe('hex24_to_cctk', function()

        it('converts test case 1', function()
            local result = convert.hex24_to_cctk(0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 2', function()
            local result = convert.hex24_to_cctk(16777215)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 3', function()
            local result = convert.hex24_to_cctk(16711680)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 4', function()
            local result = convert.hex24_to_cctk(65280)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 5', function()
            local result = convert.hex24_to_cctk(255)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 6', function()
            local result = convert.hex24_to_cctk(16776960)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 7', function()
            local result = convert.hex24_to_cctk(16711935)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 8', function()
            local result = convert.hex24_to_cctk(65535)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 9', function()
            local result = convert.hex24_to_cctk(8421504)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 10', function()
            local result = convert.hex24_to_cctk(3388390)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

    end)

    describe('hex24_to_cctm', function()

        it('converts test case 1', function()
            local result = convert.hex24_to_cctm(0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 2', function()
            local result = convert.hex24_to_cctm(16777215)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 3', function()
            local result = convert.hex24_to_cctm(16711680)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 4', function()
            local result = convert.hex24_to_cctm(65280)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 5', function()
            local result = convert.hex24_to_cctm(255)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 6', function()
            local result = convert.hex24_to_cctm(16776960)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 7', function()
            local result = convert.hex24_to_cctm(16711935)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 8', function()
            local result = convert.hex24_to_cctm(65535)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 9', function()
            local result = convert.hex24_to_cctm(8421504)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 10', function()
            local result = convert.hex24_to_cctm(3388390)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

    end)

    describe('rgb100_to_cctk', function()

        it('converts test case 1', function()
            local result = convert.rgb100_to_cctk(0, 0, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 2', function()
            local result = convert.rgb100_to_cctk(100, 100, 100)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 3', function()
            local result = convert.rgb100_to_cctk(100, 0, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 4', function()
            local result = convert.rgb100_to_cctk(0, 100, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 5', function()
            local result = convert.rgb100_to_cctk(0, 0, 100)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 6', function()
            local result = convert.rgb100_to_cctk(100, 100, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 7', function()
            local result = convert.rgb100_to_cctk(100, 0, 100)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 8', function()
            local result = convert.rgb100_to_cctk(0, 100, 100)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 9', function()
            local result = convert.rgb100_to_cctk(50, 50, 50)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 10', function()
            local result = convert.rgb100_to_cctk(20, 70, 90)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

    end)

    describe('rgb100_to_cctm', function()

        it('converts test case 1', function()
            local result = convert.rgb100_to_cctm(0, 0, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 2', function()
            local result = convert.rgb100_to_cctm(100, 100, 100)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 3', function()
            local result = convert.rgb100_to_cctm(100, 0, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 4', function()
            local result = convert.rgb100_to_cctm(0, 100, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 5', function()
            local result = convert.rgb100_to_cctm(0, 0, 100)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 6', function()
            local result = convert.rgb100_to_cctm(100, 100, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 7', function()
            local result = convert.rgb100_to_cctm(100, 0, 100)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 8', function()
            local result = convert.rgb100_to_cctm(0, 100, 100)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 9', function()
            local result = convert.rgb100_to_cctm(50, 50, 50)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 10', function()
            local result = convert.rgb100_to_cctm(20, 70, 90)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

    end)

    describe('rgb_to_cctk', function()

        it('converts test case 1', function()
            local result = convert.rgb_to_cctk(0, 0, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 2', function()
            local result = convert.rgb_to_cctk(1, 1, 1)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 3', function()
            local result = convert.rgb_to_cctk(1, 0, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 4', function()
            local result = convert.rgb_to_cctk(0, 1, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 5', function()
            local result = convert.rgb_to_cctk(0, 0, 1)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 6', function()
            local result = convert.rgb_to_cctk(1, 1, 0)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 7', function()
            local result = convert.rgb_to_cctk(1, 0, 1)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 8', function()
            local result = convert.rgb_to_cctk(0, 1, 1)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 9', function()
            local result = convert.rgb_to_cctk(0.5, 0.5, 0.5)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

        it('converts test case 10', function()
            local result = convert.rgb_to_cctk(0.2, 0.7, 0.9)

            -- Verify result is not nil
            assert.is_not_nil(result)
            assert.is_number(result)
        end)

    end)

    describe('cctk_to_rgb', function()

        it('converts test case 1', function()
            local result = {convert.cctk_to_rgb(1000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 2', function()
            local result = {convert.cctk_to_rgb(1500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 3', function()
            local result = {convert.cctk_to_rgb(2000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 4', function()
            local result = {convert.cctk_to_rgb(2500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 5', function()
            local result = {convert.cctk_to_rgb(3000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 6', function()
            local result = {convert.cctk_to_rgb(3500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 7', function()
            local result = {convert.cctk_to_rgb(4000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 8', function()
            local result = {convert.cctk_to_rgb(5000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 9', function()
            local result = {convert.cctk_to_rgb(6500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 10', function()
            local result = {convert.cctk_to_rgb(10000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

    end)

end)