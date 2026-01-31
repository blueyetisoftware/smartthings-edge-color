--- Test specifications for rgb_to_cctk conversion

local rgb_to_cctk = require 'color.core.rgb_to_cctk'
local spec_helper = require 'spec.spec_helper'

describe('rgb_to_cctk', function()

    describe('fast approximation (default)', function()
        it('converts RGB (1.0, 0.7, 0.4) to approx 2906K with tolerance', function()
            local cct = rgb_to_cctk(1.0, 0.7, 0.4)  -- Warm color
            spec_helper.assert_near(2906, cct, 100, "Fast approximation for RGB (1.0, 0.7, 0.4) should be near 2906K")
        end)

        it('converts RGB (0.8, 0.9, 1.0) to approx 9985K with tolerance', function()
            local cct = rgb_to_cctk(0.8, 0.9, 1.0)  -- Cool color
            spec_helper.assert_near(9985, cct, 500, "Fast approximation for RGB (0.8, 0.9, 1.0) should be near 9985K")
        end)

        it('converts RGB (1.0, 1.0, 1.0) to approx 6524K with tolerance', function()
            local cct = rgb_to_cctk(1.0, 1.0, 1.0)  -- Pure white
            spec_helper.assert_near(6524, cct, 200, "Fast approximation for RGB (1.0, 1.0, 1.0) should be near 6524K")
        end)

        it('converts RGB (1.0, 0.5, 0.0) to approx 1K with tolerance', function()
            local cct = rgb_to_cctk(1.0, 0.5, 0.0)  -- Deep red/orange
            spec_helper.assert_near(1, cct, 100, "Fast approximation for RGB (1.0, 0.5, 0.0) should be near 1K")
        end)
    end)

    describe('accurate algorithm', function()
        it('converts RGB (1.0, 0.7, 0.4) to approx 2913K with tolerance', function()
            local cct = rgb_to_cctk(1.0, 0.7, 0.4, true)  -- Warm color
            spec_helper.assert_near(2913, cct, 100, "Accurate algorithm for RGB (1.0, 0.7, 0.4) should be near 2913K")
        end)

        it('converts RGB (0.8, 0.9, 1.0) to approx 9463K with tolerance', function()
            local cct = rgb_to_cctk(0.8, 0.9, 1.0, true)  -- Cool color
            spec_helper.assert_near(9463, cct, 500, "Accurate algorithm for RGB (0.8, 0.9, 1.0) should be near 9463K")
        end)

        it('converts RGB (1.0, 1.0, 1.0) to approx 6600K with tolerance', function()
            local cct = rgb_to_cctk(1.0, 1.0, 1.0, true)  -- Pure white
            spec_helper.assert_near(6600, cct, 200, "Accurate algorithm for RGB (1.0, 1.0, 1.0) should be near 6600K")
        end)

        it('converts RGB (1.0, 0.5, 0.0) to approx 1803K with tolerance', function()
            local cct = rgb_to_cctk(1.0, 0.5, 0.0, true)  -- Deep red/orange
            spec_helper.assert_near(1803, cct, 100, "Accurate algorithm for RGB (1.0, 0.5, 0.0) should be near 1803K")
        end)
    end)
end)