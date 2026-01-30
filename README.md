# smartthings-edge-color

A comprehensive color space conversion library for SmartThings Edge lighting drivers, providing consistent APIs, robust validation, and bug-free implementations.

## Value Proposition over SmartThings Edge st_utils

While SmartThings Edge provides basic color conversion functions through `st.utils`, this library offers significant improvements in reliability, consistency, and developer experience:

### 🔧 Consistent API Design
- **Normalized Input Ranges**: All functions use the standard [0,1] range for color components, eliminating confusion about whether inputs should be [0,255], [0,1], or other ranges. SmartThings `st_utils` is inconsistent - HSL functions use percentages [0,100] while RGB functions use 8-bit values [0,255].
- **Uniform Parameter Order**: Consistent parameter ordering across all conversion functions (e.g., always `red, green, blue` for RGB inputs)
- **Predictable Return Values**: All functions return values in the same normalized [0,1] range

### 🛡️ Robust Input Validation
- **Range Clamping**: Automatically clamps input values to valid ranges, preventing crashes from out-of-bounds inputs
- **Type Enforcement**: Validates that all inputs are numbers, with clear error messages for invalid types
- **Nil-Safe Operations**: Handles edge cases gracefully without crashing

### 🐛 Bug Fixes and Improvements
- **Fixed HSL Grayscale Bug**: The original `st.utils` HSL conversion had a critical bug where achromatic (grayscale) colors with zero saturation would ignore the lightness component, always producing pure white (255,255,255) regardless of the lightness value. This library implements the mathematically correct algorithm.
- **Eliminated API Inconsistencies**: SmartThings `st_utils` uses arbitrary, inconsistent ranges (HSL in percentages [0,100], RGB in 8-bit [0,255]) that don't match standard color APIs. This library uses normalized [0,1] ranges throughout for consistency.
- **Accurate Documentation**: Comments accurately describe what each function does, rather than making incorrect claims about "standard algorithms" when st_utils is actually used
- **Comprehensive Testing**: 214+ automated tests ensure correctness and prevent regressions, including industry standard benchmarks against CIE illuminants

### 📊 Supported Color Spaces and Conversions

| Color Space | Description | Range |
|-------------|-------------|-------|
| RGB | Red, Green, Blue | [0,1] |
| HSL | Hue, Saturation, Lightness | H: [0,1], S: [0,1], L: [0,1] |
| HSV | Hue, Saturation, Value | H: [0,1], S: [0,1], V: [0,1] |
| xyY | CIE 1931 chromaticity coordinates | x: [0,1], y: [0,1], Y: [0,1] |
| CCT | Correlated Color Temperature | 1000K - 40000K |

### 🔄 Available Conversions

- `rgb_to_hsl()` - RGB to HSL
- `hsl_to_rgb()` - HSL to RGB
- `rgb_to_hsv()` - RGB to HSV (via st_utils)
- `rgb_to_xy()` - RGB to CIE xyY (via st_utils)
- `xy_to_rgb()` - CIE xyY to RGB (via st_utils)
- `cct_to_rgb()` - Color temperature to RGB
- `rgb_to_cct()` - RGB to color temperature (dual-algorithm: fast approximation + accurate distance-based)
- `toMired(kelvin)` / `toKelvin(mired)` - Temperature unit conversions (format module)
- `kelvin_to_mired()` / `mired_to_kelvin()` - Backward compatibility aliases
- `kelvin_to_mirek()` / `mirek_to_kelvin()` - Backward compatibility aliases for Philips Hue API

### 🧮 Utility Functions

- `to_rgb8(r, g, b)` / `from_rgb8(r8, g8, b8)` - Convert between [0,1] and [0,255] RGB
- `to_rgb16(r, g, b)` / `from_rgb16(r16, g16, b16)` - Convert between [0,1] and [0,65535] RGB
- `to_rgb100(r, g, b)` / `from_rgb100(r100, g100, b100)` - Convert between [0,1] and [0,100] RGB
- `clampRGB8(r, g, b)` / `clampRGB16(r, g, b)` / `clampRGB100(r, g, b)` - Clamp RGB values to integer ranges
- `roundRGB(r, g, b)` - Round RGB values to integers (no scaling)
- `to_degrees()` / `from_degrees()` - Convert between [0,1] and [0,360] (for hue)

## Installation

Copy the `color/` directory to your SmartThings Edge driver project.

```lua
local color = require 'color'
```

## Usage Examples

### Basic Color Conversion
```lua
local color = require 'color'

-- Convert RGB to HSL
local h, s, l = color.rgb_to_hsl(1, 0, 0)  -- Pure red: 0, 1, 1

-- Convert HSL to RGB
local r, g, b = color.hsl_to_rgb(0, 1, 0.5)  -- Red: 1, 0, 0

-- Convert color temperature to RGB
local r, g, b = color.cct_to_rgb(3000)  -- Warm white
```

### Working with Different Ranges
```lua
local color = require 'color'

-- Convert from 8-bit RGB to normalized RGB
local r, g, b = color.from_8bit(255, 128, 0)  -- 1, 0.5, 0

-- Convert back to 8-bit
local r8, g8, b8 = color.to_8bit(1, 0.5, 0)  -- 255, 128, 0
```

### CIE xyY Color Space
```lua
local color = require 'color'

-- Convert RGB to CIE xyY chromaticity
local x, y, Y = color.rgb_to_xy(1, 0, 0)  -- Red chromaticity coordinates

-- Convert back to RGB
local r, g, b = color.xy_to_rgb(x, y, Y)
```

### RGB to Color Temperature Conversion

The `rgb_to_cct()` function provides two algorithms optimized for different use cases:

```lua
local color = require 'color'

-- Fast approximation (10-20x faster, ~10-20K accuracy)
local cct_fast = color.rgb_to_cct(1, 0.8, 0.6, false)

-- Accurate calculation (exact results, 2-3x slower)
local cct_accurate = color.rgb_to_cct(1, 0.8, 0.6, true)
```

**Algorithm Details:**
- **Fast**: Lookup table interpolation with 78 reference points (optimized for performance)
- **Accurate**: Distance-based minimization using golden section search (optimized for precision)
- **Validation**: Both algorithms tested against CIE standard illuminants (A, D50, D65)

## Testing

This library includes comprehensive test coverage using the [busted](https://lunarmodules.github.io/busted/) testing framework.

```bash
busted
```

All 214+ tests should pass, covering:
- **Round-trip conversion accuracy** with exact equality assertions
- **Industry standard benchmarks** against CIE illuminants (A, D50, D65, 7500K)
- **Dual-algorithm validation** for RGB to CCT (fast approximation vs accurate distance-based)
- **Edge cases** (black, white, grayscale, boundary conditions)
- **Input validation and error handling** with type enforcement
- **Performance characteristics** and algorithm accuracy tradeoffs

## API Reference

See the individual function files in the `color/` directory for detailed documentation and parameter descriptions.

## License

See LICENSE file for details.
