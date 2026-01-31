--- Test specifications for cct ↔ xyy conversion module

local convert = require 'color.convert.cct_xyy'

describe('cct ↔ xyy conversions', function()

    describe('cctk_to_xyy', function()

        it('converts test case 1', function()
            local result = {convert.cctk_to_xyy(1000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 2', function()
            local result = {convert.cctk_to_xyy(1500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 3', function()
            local result = {convert.cctk_to_xyy(2000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 4', function()
            local result = {convert.cctk_to_xyy(2500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 5', function()
            local result = {convert.cctk_to_xyy(3000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 6', function()
            local result = {convert.cctk_to_xyy(3500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 7', function()
            local result = {convert.cctk_to_xyy(4000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 8', function()
            local result = {convert.cctk_to_xyy(5000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 9', function()
            local result = {convert.cctk_to_xyy(6500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 10', function()
            local result = {convert.cctk_to_xyy(10000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

    end)

    describe('cctm_to_xyy', function()

        it('converts test case 1', function()
            local result = {convert.cctm_to_xyy(1000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 2', function()
            local result = {convert.cctm_to_xyy(1500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 3', function()
            local result = {convert.cctm_to_xyy(2000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 4', function()
            local result = {convert.cctm_to_xyy(2500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 5', function()
            local result = {convert.cctm_to_xyy(3000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 6', function()
            local result = {convert.cctm_to_xyy(3500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 7', function()
            local result = {convert.cctm_to_xyy(4000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 8', function()
            local result = {convert.cctm_to_xyy(5000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 9', function()
            local result = {convert.cctm_to_xyy(6500)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

        it('converts test case 10', function()
            local result = {convert.cctm_to_xyy(10000)}

            -- Verify results are not nil
            assert.is_not_nil(result[1])
            assert.is_not_nil(result[2])
            assert.is_not_nil(result[3])
        end)

    end)

end)