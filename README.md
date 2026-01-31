# smartthings-edge-color

A comprehensive color space conversion library for SmartThings Edge lighting drivers, providing consistent APIs, robust validation, and **industry-validated accuracy** with **460+ automated tests**.

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
- **Comprehensive Testing**: 220+ automated tests ensure correctness and prevent regressions, including industry standard benchmarks against CIE illuminants

### � SmartThings Edge API Differences

This library intentionally diverges from SmartThings Edge `st_utils` APIs to provide a better developer experience. All differences are documented here:

#### Color Space Naming
- **Library**: Uses `xyy_to_rgb()` and `rgb_to_xyy()` for CIE 1931 xyY color space conversions
- **st_utils**: Uses misleading `xy_to_rgb()` and `rgb_to_xy()` names that suggest only xy chromaticity coordinates
- **Rationale**: xyY functions return 3 values (x, y, Y), not 2. The `xyy` naming accurately represents the full color space operations.

#### Input Range Normalization
- **Library**: All color components use normalized [0,1] ranges for consistency
- **st_utils**: Inconsistent ranges:
  - HSL: Hue/Saturation/Lightness in [0,100] (percentages)
  - RGB: Red/Green/Blue in [0,255] (8-bit values)
  - xyY: x/y/Y in [0,1] (normalized)
- **Rationale**: Normalized ranges eliminate confusion and match standard color APIs. Use `color.to_rgb100()`, `color.from_rgb8()`, etc. for conversions.

#### Function Behavior
- **Library**: Robust input validation with automatic clamping and clear error messages
- **st_utils**: Limited validation, may crash on invalid inputs or produce undefined results
- **Rationale**: Production-ready drivers need defensive programming to handle edge cases gracefully.

### �📊 Supported Color Spaces and Formats

| Color Space | Description | Range | Format Variants |
|-------------|-------------|-------|-----------------|
| RGB | Red, Green, Blue | [0,1] | `RGB`, `RGB8`, `HEX24`, `RGB100` |
| HSL | Hue, Saturation, Lightness | H: [0,1], S: [0,1], L: [0,1] | `HSL`, `HSL360`, `HSL100` |
| HSV | Hue, Saturation, Value | H: [0,1], S: [0,1], V: [0,1] | `HSV`, `HSV360`, `HSV100` |
| xyY | CIE 1931 chromaticity coordinates | x: [0,1], y: [0,1], Y: [0,1] | `XYY` |
| CCT | Correlated Color Temperature | 1K - 30000K | `CCTK`, `CCTM` |

#### Format Naming Convention

| Format | Meaning | Example Values |
|--------|---------|----------------|
| **RGB** | Normalized RGB (0-1) | `1.0, 0.5, 0.0` |
| **RGB8** | 8-bit RGB (0-255) | `255, 128, 0` |
| **HEX24** | 24-bit hex integer | `0xFF8000` |
| **RGB100** | Percentage RGB (0-100%) | `100, 50, 0` |
| **HSV** | Normalized HSV | `0.1, 0.8, 1.0` |
| **HSV360** | HSV with hue in degrees | `36, 0.8, 1.0` |
| **HSV100** | HSV with percentage values | `10, 80, 100` |
| **HSL** | Normalized HSL | `0.1, 0.8, 0.5` |
| **HSL360** | HSL with hue in degrees | `36, 0.8, 0.5` |
| **HSL100** | HSL with percentage values | `10, 80, 50` |
| **XYY** | CIE xyY coordinates | `0.5, 0.4, 1.0` |
| **CCTK** | CCT in Kelvin | `6500` |
| **CCTM** | CCT in Mired | `153` |

### 🔄 Available Conversions

- `rgb_to_hsl()` - RGB to HSL
- `hsl_to_rgb()` - HSL to RGB
- `rgb_to_hsv()` - RGB to HSV (via st_utils)
- `rgb_to_xyy()` - RGB to CIE xyY (via st_utils)
- `xyy_to_rgb()` - CIE xyY to RGB (via st_utils)
- `cct_to_rgb()` - Color temperature to RGB
- `rgb_to_cct()` - RGB to color temperature (dual-algorithm: fast approximation + accurate distance-based)
- `clampKelvin(k)` - Clamp Kelvin to SmartThings [1,30000] range
- `toMired(kelvin)` / `toKelvin(mired)` - Temperature unit conversions (format module)
- `kelvin_to_mired()` / `mired_to_kelvin()` - Backward compatibility aliases
- `kelvin_to_mirek()` / `mirek_to_kelvin()` - Backward compatibility aliases for Philips Hue API

### 🧮 Utility Functions

- `to_rgb8(r, g, b)` / `from_rgb8(r8, g8, b8)` - Convert between [0,1] and [0,255] RGB
- `to_rgb_hex_int(r, g, b)` / `from_rgb_hex(hex)` - Convert between [0,1] RGB and 24-bit hex integers (0xRRGGBB)
- `to_rgb100(r, g, b)` / `from_rgb100(r100, g100, b100)` - Convert between [0,1] and [0,100] RGB
- `clamp_rgb8(r, g, b)` / `clamp_rgb100(r, g, b)` - Clamp RGB values to valid ranges
- `round_rgb(r, g, b)` - Round RGB values to integers (no scaling)
- `to_hsv360()` / `from_hsv360()` - Convert HSV between normalized [0,1] and degrees [0,360]
- `to_hsl360()` / `from_hsl360()` - Convert HSL between normalized [0,1] and degrees [0,360]
- `to_kelvin(mired)` / `to_mired(kelvin)` - Convert between CCT units

## Installation

Copy the `color/` directory to your SmartThings Edge driver project.

```lua
local color = require 'color'
```

### � Directory Structure

The library is organized for optimal tree-shaking and maintainability:

```
color/
├── init.lua              # Main module (loads all submodules)
├── core/                 # Core conversion implementations
│   ├── rgb_to_hsv.lua    # RGB → HSV conversion
│   ├── hsv_to_rgb.lua    # HSV → RGB conversion
│   ├── rgb_to_hsl.lua    # RGB → HSL conversion
│   ├── hsl_to_rgb.lua    # HSL → RGB conversion
│   ├── rgb_to_cct.lua    # RGB → CCT conversion
│   ├── cct_to_rgb.lua    # CCT → RGB conversion
│   ├── rgb_to_xyy.lua    # RGB → xyY conversion
│   └── xyy_to_rgb.lua    # xyY → RGB conversion
├── convert/          # Generated grouped conversion modules (run generate_chains.lua)
│   ├── rgb_hsv.lua       # All RGB ↔ HSV format variants
│   ├── rgb_hsl.lua       # All RGB ↔ HSL format variants
│   ├── rgb_cct.lua       # All RGB ↔ CCT format variants
│   ├── rgb_xyy.lua       # All RGB ↔ xyY format variants
│   ├── hsv_hsl.lua       # HSV ↔ HSL conversions
│   └── cct_xyy.lua       # CCT ↔ xyY conversions
└── format/               # Format conversion utilities
    ├── rgb.lua           # RGB format conversions (8-bit, hex, 100-scale)
    ├── hsv.lua           # HSV format conversions (degrees, normalized)
    ├── hsl.lua           # HSL format conversions (degrees, normalized)
    ├── cct.lua           # CCT format conversions (Kelvin ↔ Mired)
    └── xyy.lua           # xyY format utilities
```

**Core Implementation**: Conversion algorithms are implemented in `color/core/` and use normalized [0,1] ranges for consistency.

### 🏗️ Architectural Design Rationale

This library follows **optimal color space conversion architecture** that balances performance, maintainability, and mathematical correctness:

#### **RGB-Centric Core Conversions**
All fundamental conversions route through RGB as the **display-referred foundation**:
- **RGB ↔ HSV/HSL**: Core perceptual color space conversions
- **RGB ↔ CCT**: Color temperature calculations from RGB primaries  
- **RGB ↔ xyY**: CIE chromaticity and luminance from RGB

**Rationale**: RGB is the universal display color space. All other spaces are derived from RGB primaries, making this the mathematically sound foundation for conversions.

#### **Direct Cross-Space Conversions (Selective)**
Only **mathematically simple relationships** get direct implementations:
- **HSV ↔ HSL**: H/S are identical, V/L have simple relationship (`L = V × (1 - S/2)`, `V = L + S × min(L, 1-L)`)
- **No other direct conversions**: CCT↔xyY formulas exist but are niche and complex

**Rationale**: Most cross-space conversions require RGB intermediates. Direct conversions are only implemented when they provide clear performance benefits without compromising accuracy.

#### **Generated Grouped Modules**
Convert modules in `color/convert/` are **generated on-demand** to:
- Enable maximum tree-shaking for Edge driver bundle optimization
- Maintain consistency across format variants
- Keep the repository clean while supporting all use cases

**Rationale**: Manual maintenance of format variants would be error-prone. Generation ensures consistency while allowing selective imports for minimal bundle sizes.

**Generated Modules**: Grouped convert modules in `color/convert/` are generated on-demand to enable tree-shaking while keeping the repository clean.

### �📦 Bundle Size Optimization

This library is designed for **selective imports** to minimize bundle size in Edge drivers. Use granular requires instead of the top-level `color` module to enable tree-shaking. The library internals also use selective imports from leaf modules (e.g., `color.format.rgb.clampRGB`) rather than top-level format modules, enabling maximum tree-shaking efficiency.

```lua
-- ✅ RECOMMENDED: Selective imports for minimal bundles
local rgb_hsv = require 'color.convert.rgb_hsv'  -- Only RGB↔HSV conversions
local rgb_cct = require 'color.convert.rgb_cct'  -- Only RGB↔CCT conversions

-- ⚠️  AVOID: Top-level import loads everything
-- local color = require 'color'  -- Loads all modules
```

**Common Driver Scenarios:**
- **Tunable White Only**: `require 'color.convert.rgb_cct'`
- **Full Color Control**: `require 'color.convert.rgb_hsv'`, `require 'color.convert.rgb_hsl'`, `require 'color.convert.rgb_cct'`
- **xy-based Bulbs**: `require 'color.convert.rgb_xyy'`, `require 'color.convert.cct_xyy'`

### 🔀 Grouped Conversion Modules

For maximum tree-shaking efficiency, the library provides **grouped conversion modules** that contain all format variants for related color space conversions. These modules are **generated** and located in `color/convert/` and enable selective loading of conversion families.

**To generate the conversion modules:**
```bash
lua generate_chains.lua --generate
lua generate_tests.lua --generate
```

Example usage after generation:
```lua
-- Load all RGB ↔ HSV conversions (includes normalized pass-throughs)
local rgb_hsv = require 'color.convert.rgb_hsv'
local h, s, v = rgb_hsv.rgb8_to_hsv(255, 128, 0)  -- Convert 8-bit RGB to HSV
local r, g, b = rgb_hsv.hsv_to_rgb8(0.1, 0.8, 1)  -- Convert HSV to 8-bit RGB
local hex = rgb_hsv.hsv_to_hex24(0.1, 0.8, 1)     -- Convert HSV to 24-bit hex
local h, s, v = rgb_hsv.hex24_to_hsv(0xFF8000)     -- Convert 24-bit hex to HSV
local h, s, v = rgb_hsv.rgb_to_hsv(1, 0.5, 0)     -- Normalized RGB to HSV
local r, g, b = rgb_hsv.hsv_to_rgb(0.1, 0.8, 1)   -- Normalized HSV to RGB

-- Load all RGB ↔ HSL conversions
local rgb_hsl = require 'color.convert.rgb_hsl'
local h, s, l = rgb_hsl.rgb100_to_hsl(100, 50, 0)  -- Convert 0-100 RGB to HSL
local r, g, b = rgb_hsl.hsl_to_rgb(0.1, 0.8, 0.5)  -- Normalized HSL to RGB

-- Load all RGB ↔ CCT conversions
local rgb_cct = require 'color.convert.rgb_cct'
local kelvin = rgb_cct.rgb_to_cctk(1, 0.5, 0.2)    -- RGB to Kelvin
local r, g, b = rgb_cct.cctm_to_rgb(250, 200, 150) -- Mired to RGB

-- Cross-space conversions (through RGB)
local hsv_hsl = require 'color.convert.hsv_hsl'
local h, s, l = hsv_hsl.hsv360_to_hsl(120, 0.8, 0.9) -- Degrees-based HSV to HSL

local cct_xyy = require 'color.convert.cct_xyy'
local x, y, Y = cct_xyy.cct_kelvin_to_xyy(6500)  -- Color temperature to xyY
```

Available grouped modules (after generation):
- `color.convert.rgb_hsv` - RGB ↔ HSV (6 format combinations + 2 normalized)
- `color.convert.rgb_hsl` - RGB ↔ HSL (3 format combinations + 2 normalized)  
- `color.convert.rgb_cct` - RGB ↔ CCT (6 format combinations + 2 normalized)
- `color.convert.rgb_xyy` - RGB ↔ xyY (3 format combinations + 2 normalized)
- `color.convert.hsv_hsl` - HSV ↔ HSL (2 format combinations, through RGB)
- `color.convert.cct_xyy` - CCT ↔ xyY (2 format combinations, through RGB)

**Test Structure**: Convert module tests are generated in `spec/convert/` to mirror the library structure.

## Usage Examples

### Basic Color Conversion
```lua
-- Import only the modules you need for minimal bundle size
local rgb_hsv = require 'color.convert.rgb_hsv'
local rgb_hsl = require 'color.convert.rgb_hsl'

-- Convert RGB to HSV
local h, s, v = rgb_hsv.rgb_to_hsv(1, 0, 0)  -- Pure red: 0, 1, 1

-- Convert HSV to RGB
local r, g, b = rgb_hsv.hsv_to_rgb(0, 1, 0.5)  -- Red: 1, 0, 0

-- Convert RGB to HSL
local h, s, l = rgb_hsl.rgb_to_hsl(1, 0, 0)  -- Pure red: 0, 1, 0.5

-- Convert HSL to RGB
local r, g, b = rgb_hsl.hsl_to_rgb(0, 1, 0.5)  -- Red: 1, 0, 0
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
local x, y, Y = color.rgb_to_xyy(1, 0, 0)  -- Red chromaticity coordinates

-- Convert back to RGB
local r, g, b = color.xyy_to_rgb(x, y, Y)
```

### SmartThings Edge Compatibility

This library is designed for SmartThings Edge drivers and maintains full compatibility with platform color capabilities:

- **colorTemperature**: `clampKelvin()` automatically handles [1–30000K] range
- **colorControl**: Hue/saturation ranges [0–100] with automatic clamping
- **CIE xy**: Full xyY support for color bulb integration
- **No schema violations**: Compatible with developer.smartthings.com capability definitions

```lua
-- Import only what you need for minimal bundle size
local rgb_to_cct = require 'color.rgb_to_cct'
local clampKelvin = require 'color.format.cct'

-- Kelvin values are automatically clamped to SmartThings range
local kelvin = rgb_to_cct(r, g, b, true)  -- Already in [1, 30000] range
local clamped = clampKelvin(kelvin)      -- Extra safety if needed
```

## Edge Driver Integration Guide

### 🚀 Performance Optimization for Drivers

**Use the fast algorithm by default** - it's ~200x faster and suitable for most driver use cases:

```lua
local color = require 'color'

-- ✅ RECOMMENDED: Fast algorithm for hot paths (fade effects, frequent updates)
local cct = color.rgb_to_cct(r, g, b)  -- Default is fast

-- ⚠️  Use accurate only when precision is critical
local cct = color.rgb_to_cct(r, g, b, true)  -- 200x slower
```

**Direct HSV↔HSL conversions** eliminate unnecessary RGB intermediate steps for better performance:

```lua
local color = require 'color'

-- ✅ RECOMMENDED: Direct conversion (more efficient)
local h, s, l = color.hsv_to_hsl(hue, saturation, value)
local h, s, v = color.hsl_to_hsv(hue, saturation, lightness)

-- ⚠️  Avoid: Indirect conversion through RGB (slower)
local r, g, b = color.hsv_to_rgb(hue, saturation, value)
local h, s, l = color.rgb_to_hsl(r, g, b)
```

### 🎯 Driver Integration Points

**setColorTemperature Command:**
```lua
function driver_handler.setColorTemperature(driver, device, command)
  local kelvin = command.args.temperature
  local r, g, b = color.cct_to_rgb(kelvin)
  -- Convert to device-specific format and send command
end
```

**setColor Command:**
```lua
function driver_handler.setColor(driver, device, command)
  local args = command.args
  local r, g, b

  if args.colorMode == "RGB" then
    -- Convert from 8-bit RGB [0,255] to normalized [0,1]
    r, g, b = color.from_rgb8(args.color.r, args.color.g, args.color.b)
  elseif args.colorMode == "HSV" then
    -- Convert from HSV to RGB
    r, g, b = color.hsv_to_rgb(args.color.hue/100, args.color.saturation/100, args.color.value/100)
  end

  -- Update colorTemperature attribute if bulb supports both modes
  local cct = color.rgb_to_cct(r, g, b)  -- Fast algorithm
  device:emit_event(capabilities.colorTemperature.colorTemperature(cct))

  -- Send device command in appropriate format
end
```

**Color Mode Handling:**
```lua
-- Check supportedColorModes capability
local supported_modes = device:get_field("supportedColorModes") or {}

if utils.table_contains(supported_modes, "RGB") then
  -- Use RGB mode
  local r8, g8, b8 = color.to_rgb8(r, g, b)
  -- Send RGB command
elseif utils.table_contains(supported_modes, "CT") then
  -- Use color temperature mode
  local cct = color.rgb_to_cct(r, g, b)
  -- Send CCT command
end
```

### 🔍 Debug Logging for Production

Add optional debug logging for significant value clamping:

```lua
local function setColorTemperature(driver, device, command)
  local kelvin = command.args.temperature

  -- Check for significant clamping
  local clamped_kelvin = color.clampKelvin(kelvin)
  if math.abs(kelvin - clamped_kelvin) > 500 then
    driver:debug(string.format("Color temperature clamped: %dK -> %dK", kelvin, clamped_kelvin))
  end

  -- Continue with clamped value...
end
```

### 🧠 Memory Considerations

- **No temporary table allocation** in hot paths - all algorithms use scalar operations
- **Pre-computed lookup tables** loaded at module initialization
- **GC-friendly** - suitable for resource-constrained Edge hubs

### 🔧 Floating-Point Determinism

The library uses standard Lua math operations that are deterministic across platforms. No platform-specific floating-point differences expected with LuaJIT.

### RGB to Color Temperature Conversion

The `rgb_to_cct()` function provides two algorithms optimized for different use cases:

```lua
local color = require 'color'

-- ✅ RECOMMENDED: Fast approximation (default, ~200x faster, ~10-20K accuracy)
local cct_fast = color.rgb_to_cct(1, 0.8, 0.6)  -- Default behavior

-- Self-documenting code using the constant
assert(color.RGB_TO_CCT_DEFAULT_FAST == true)  -- Confirms fast is default

-- ⚠️  Use accurate only when precision is critical (~200x slower)
local cct_accurate = color.rgb_to_cct(1, 0.8, 0.6, true)
```

**Algorithm Details:**
- **Fast (Default)**: Lookup table interpolation with 78 reference points (optimized for performance)
- **Accurate**: Distance-based minimization using golden section search (optimized for precision)
- **Performance**: Fast algorithm is ~200x faster - critical for Edge driver hot paths
- **Recommendation**: Use fast algorithm for UI responsiveness, accurate only for calibration

## Testing

This library includes comprehensive test coverage using the [busted](https://lunarmodules.github.io/busted/) testing framework.

```bash
busted
```

All 220+ tests should pass, covering:
- **Round-trip conversion accuracy** with exact equality assertions
- **Industry standard benchmarks** against CIE illuminants (A, D50, D65, 30000K)
- **Dual-algorithm validation** for RGB to CCT (fast approximation vs accurate distance-based)
- **Edge cases** (black, white, grayscale, boundary conditions)
- **Input validation and error handling** with type enforcement
- **Performance characteristics** and algorithm accuracy tradeoffs

### 🤖 Automated Generation & Testing

This library uses **code generation** to create conversion modules and comprehensive tests. GitHub Actions automatically:

- **Generates convert modules** (`color/convert/`) and tests (`spec/convert/`) on pull requests
- **Commits generated code** only when changes are detected (avoids empty commits)
- **Runs full test suite** (460+ tests) on generated code to ensure accuracy
- **Validates PR changes** before merging to maintain quality

To generate locally:
```bash
lua generate_chains.lua --generate  # Generate conversion modules
lua generate_tests.lua --generate   # Generate test files
busted                                # Run all tests
```

## Quality Assurance

This library implements professional color mathematics standards with rigorous validation:

### 🧪 Comprehensive Test Suite
- **460+ automated tests** covering all conversion functions and edge cases
- **Industry standard benchmarks** against CIE standard illuminants (A, D50, D65, 30000K)
- **SmartThings platform validation** ensuring full compatibility with Edge driver requirements

### 🎯 Precision-Appropriate Tolerances
- **Exact matching** for integer conversions (8/16-bit channels, Kelvin values)
- **Floating-point precision** (1e-6 ε) for color space transformations
- **Domain-aware tolerances** for CCT algorithms (10-100K practical ranges)
- **No unrealistic expectations** - acknowledges inherent limitations of color space conversions

### 🔬 Algorithm Validation
- **Dual RGB to CCT algorithms**: Fast approximation (10-20x speed) + accurate distance-based
- **Performance characterization**: Documented speed vs accuracy tradeoffs
- **Roundtrip validation**: Ensures mathematical consistency within practical limits
- **Industry compliance**: CIE illuminant testing validates real-world color temperature accuracy

### 🏆 Professional Standards
- **No schema violations** against SmartThings capability definitions
- **Platform-optimized ranges** ([1,30000] Kelvin, [33,1000000] Mired)
- **Comprehensive error handling** with clear validation messages
- **Production-ready** for SmartThings Edge driver development

## API Reference

See the individual function files in the `color/core/` directory for detailed documentation and parameter descriptions of core conversion functions. Format utilities are documented in `color/format/`.

## License

See LICENSE file for details.
