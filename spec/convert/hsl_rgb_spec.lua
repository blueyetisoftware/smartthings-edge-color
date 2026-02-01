--- Test specifications for hsl ↔ rgb conversion module

local convert = require 'color.convert.hsl_rgb'

describe('hsl ↔ rgb conversions', function()

    describe('hsl_to_rgb8', function()

        it('converts test case 1', function()
            local result = {convert.hsl_to_rgb8(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 2', function()
            local result = {convert.hsl_to_rgb8(0, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 3', function()
            local result = {convert.hsl_to_rgb8(0, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 4', function()
            local result = {convert.hsl_to_rgb8(0.333, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 5', function()
            local result = {convert.hsl_to_rgb8(0.667, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 6', function()
            local result = {convert.hsl_to_rgb8(0.167, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 7', function()
            local result = {convert.hsl_to_rgb8(0.833, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 8', function()
            local result = {convert.hsl_to_rgb8(0.5, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 9', function()
            local result = {convert.hsl_to_rgb8(0, 0, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 10', function()
            local result = {convert.hsl_to_rgb8(0.2, 0.9, 0.4)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

    end)

    describe('hsl_to_hex24', function()

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

    describe('hsl_to_rgb100', function()

        it('converts test case 1', function()
            local result = {convert.hsl_to_rgb100(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 2', function()
            local result = {convert.hsl_to_rgb100(0, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 3', function()
            local result = {convert.hsl_to_rgb100(0, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 4', function()
            local result = {convert.hsl_to_rgb100(0.333, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 5', function()
            local result = {convert.hsl_to_rgb100(0.667, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 6', function()
            local result = {convert.hsl_to_rgb100(0.167, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 7', function()
            local result = {convert.hsl_to_rgb100(0.833, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 8', function()
            local result = {convert.hsl_to_rgb100(0.5, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 9', function()
            local result = {convert.hsl_to_rgb100(0, 0, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 10', function()
            local result = {convert.hsl_to_rgb100(0.2, 0.9, 0.4)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

    end)

    describe('hsl360_to_rgb8', function()

        it('converts test case 1', function()
            local result = {convert.hsl360_to_rgb8(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 2', function()
            local result = {convert.hsl360_to_rgb8(0, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 3', function()
            local result = {convert.hsl360_to_rgb8(0, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 4', function()
            local result = {convert.hsl360_to_rgb8(119.88, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 5', function()
            local result = {convert.hsl360_to_rgb8(240.12, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 6', function()
            local result = {convert.hsl360_to_rgb8(60.12, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 7', function()
            local result = {convert.hsl360_to_rgb8(299.88, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 8', function()
            local result = {convert.hsl360_to_rgb8(180.0, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 9', function()
            local result = {convert.hsl360_to_rgb8(0, 0, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

        it('converts test case 10', function()
            local result = {convert.hsl360_to_rgb8(72.0, 0.9, 0.4)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB8 should be integers in 0-255 range
            assert.is_true(type(result[1]) == 'number' and result[1] >= 0 and
                result[1] <= 255)
            assert.is_true(type(result[2]) == 'number' and result[2] >= 0 and
                result[2] <= 255)
            assert.is_true(type(result[3]) == 'number' and result[3] >= 0 and
                result[3] <= 255)
        end)

    end)

    describe('hsl360_to_hex24', function()

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

    describe('hsl360_to_rgb100', function()

        it('converts test case 1', function()
            local result = {convert.hsl360_to_rgb100(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 2', function()
            local result = {convert.hsl360_to_rgb100(0, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 3', function()
            local result = {convert.hsl360_to_rgb100(0, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 4', function()
            local result = {convert.hsl360_to_rgb100(119.88, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 5', function()
            local result = {convert.hsl360_to_rgb100(240.12, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 6', function()
            local result = {convert.hsl360_to_rgb100(60.12, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 7', function()
            local result = {convert.hsl360_to_rgb100(299.88, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 8', function()
            local result = {convert.hsl360_to_rgb100(180.0, 1, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 9', function()
            local result = {convert.hsl360_to_rgb100(0, 0, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

        it('converts test case 10', function()
            local result = {convert.hsl360_to_rgb100(72.0, 0.9, 0.4)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- RGB100 should be in 0-100 range
            assert.is_true(result[1] >= 0 and result[1] <= 100)
            assert.is_true(result[2] >= 0 and result[2] <= 100)
            assert.is_true(result[3] >= 0 and result[3] <= 100)
        end)

    end)

    describe('hsl_to_rgb', function()

        it('converts test case 1', function()
            local result = {convert.hsl_to_rgb(0, 0, 0)}

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
            local result = {convert.hsl_to_rgb(0, 0, 1)}

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
            local result = {convert.hsl_to_rgb(0, 1, 0.5)}

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
            local result = {convert.hsl_to_rgb(0.333, 1, 0.5)}

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
            local result = {convert.hsl_to_rgb(0.667, 1, 0.5)}

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
            local result = {convert.hsl_to_rgb(0.167, 1, 0.5)}

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
            local result = {convert.hsl_to_rgb(0.833, 1, 0.5)}

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
            local result = {convert.hsl_to_rgb(0.5, 1, 0.5)}

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
            local result = {convert.hsl_to_rgb(0, 0, 0.5)}

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
            local result = {convert.hsl_to_rgb(0.2, 0.9, 0.4)}

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

    describe('rgb_to_hsl', function()

        it('converts test case 1', function()
            local result = {convert.rgb_to_hsl(0, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- HSL should have H in 0-1, S,V/L in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 2', function()
            local result = {convert.rgb_to_hsl(1, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- HSL should have H in 0-1, S,V/L in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 3', function()
            local result = {convert.rgb_to_hsl(1, 0, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- HSL should have H in 0-1, S,V/L in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 4', function()
            local result = {convert.rgb_to_hsl(0, 1, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- HSL should have H in 0-1, S,V/L in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 5', function()
            local result = {convert.rgb_to_hsl(0, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- HSL should have H in 0-1, S,V/L in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 6', function()
            local result = {convert.rgb_to_hsl(1, 1, 0)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- HSL should have H in 0-1, S,V/L in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 7', function()
            local result = {convert.rgb_to_hsl(1, 0, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- HSL should have H in 0-1, S,V/L in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 8', function()
            local result = {convert.rgb_to_hsl(0, 1, 1)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- HSL should have H in 0-1, S,V/L in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 9', function()
            local result = {convert.rgb_to_hsl(0.5, 0.5, 0.5)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- HSL should have H in 0-1, S,V/L in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

        it('converts test case 10', function()
            local result = {convert.rgb_to_hsl(0.2, 0.7, 0.9)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
            assert.is_number(result[1])
            assert.is_number(result[2])
            assert.is_number(result[3])
            -- HSL should have H in 0-1, S,V/L in 0-1 range
            assert.is_true(result[1] >= 0 and result[1] <= 1)
            assert.is_true(result[2] >= 0 and result[2] <= 1)
            assert.is_true(result[3] >= 0 and result[3] <= 1)
        end)

    end)

end)