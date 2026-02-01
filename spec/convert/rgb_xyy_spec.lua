--- Test specifications for rgb ↔ xyy conversion module

local convert = require 'color.convert.rgb_xyy'

describe('rgb ↔ xyy conversions', function()

    describe('rgb8_to_xyy', function()

        it('converts test case 1', function()
            local result = {convert.rgb8_to_xyy(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 2', function()
            local result = {convert.rgb8_to_xyy(255, 255, 255)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 3', function()
            local result = {convert.rgb8_to_xyy(255, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 4', function()
            local result = {convert.rgb8_to_xyy(0, 255, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 5', function()
            local result = {convert.rgb8_to_xyy(0, 0, 255)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 6', function()
            local result = {convert.rgb8_to_xyy(255, 255, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 7', function()
            local result = {convert.rgb8_to_xyy(255, 0, 255)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 8', function()
            local result = {convert.rgb8_to_xyy(0, 255, 255)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 9', function()
            local result = {convert.rgb8_to_xyy(128, 128, 128)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 10', function()
            local result = {convert.rgb8_to_xyy(51, 179, 230)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

    end)

    describe('hex24_to_xyy', function()

        it('converts test case 1', function()
            local result = {convert.hex24_to_xyy(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 2', function()
            local result = {convert.hex24_to_xyy(1, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 3', function()
            local result = {convert.hex24_to_xyy(1, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 4', function()
            local result = {convert.hex24_to_xyy(0, 1, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 5', function()
            local result = {convert.hex24_to_xyy(0, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 6', function()
            local result = {convert.hex24_to_xyy(1, 1, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 7', function()
            local result = {convert.hex24_to_xyy(1, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 8', function()
            local result = {convert.hex24_to_xyy(0, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 9', function()
            local result = {convert.hex24_to_xyy(0.5, 0.5, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 10', function()
            local result = {convert.hex24_to_xyy(0.2, 0.7, 0.9)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

    end)

    describe('rgb100_to_xyy', function()

        it('converts test case 1', function()
            local result = {convert.rgb100_to_xyy(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 2', function()
            local result = {convert.rgb100_to_xyy(100, 100, 100)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 3', function()
            local result = {convert.rgb100_to_xyy(100, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 4', function()
            local result = {convert.rgb100_to_xyy(0, 100, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 5', function()
            local result = {convert.rgb100_to_xyy(0, 0, 100)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 6', function()
            local result = {convert.rgb100_to_xyy(100, 100, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 7', function()
            local result = {convert.rgb100_to_xyy(100, 0, 100)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 8', function()
            local result = {convert.rgb100_to_xyy(0, 100, 100)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 9', function()
            local result = {convert.rgb100_to_xyy(50, 50, 50)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 10', function()
            local result = {convert.rgb100_to_xyy(20, 70, 90)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

    end)

    describe('rgb_to_xyy', function()

        it('converts test case 1', function()
            local result = {convert.rgb_to_xyy(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 2', function()
            local result = {convert.rgb_to_xyy(1, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 3', function()
            local result = {convert.rgb_to_xyy(1, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 4', function()
            local result = {convert.rgb_to_xyy(0, 1, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 5', function()
            local result = {convert.rgb_to_xyy(0, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 6', function()
            local result = {convert.rgb_to_xyy(1, 1, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 7', function()
            local result = {convert.rgb_to_xyy(1, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 8', function()
            local result = {convert.rgb_to_xyy(0, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 9', function()
            local result = {convert.rgb_to_xyy(0.5, 0.5, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

        it('converts test case 10', function()
            local result = {convert.rgb_to_xyy(0.2, 0.7, 0.9)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- xyY should have x,y in 0-1 range, Y >= 0
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0)
        end)

    end)

    describe('xyy_to_rgb', function()

        it('converts test case 1', function()
            local result = {convert.xyy_to_rgb(0.3127, 0.329, 1.0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB should be in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 2', function()
            local result = {convert.xyy_to_rgb(0.3333, 0.3333, 1.0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB should be in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 3', function()
            local result = {convert.xyy_to_rgb(0.64, 0.33, 1.0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB should be in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 4', function()
            local result = {convert.xyy_to_rgb(0.3, 0.6, 1.0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB should be in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 5', function()
            local result = {convert.xyy_to_rgb(0.15, 0.06, 1.0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB should be in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 6', function()
            local result = {convert.xyy_to_rgb(0.3127, 0.329, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB should be in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 7', function()
            local result = {convert.xyy_to_rgb(0.2, 0.4, 0.8)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB should be in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 8', function()
            local result = {convert.xyy_to_rgb(0.1, 0.2, 0.3)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB should be in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 9', function()
            local result = {convert.xyy_to_rgb(0.5, 0.3, 0.9)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB should be in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 10', function()
            local result = {convert.xyy_to_rgb(0.4, 0.5, 0.1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB should be in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

    end)

end)