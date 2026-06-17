# BFloat16 Processor Implementation
A complete **16-bit BFloat16 floating-point processor** based on the BFloat16 format (1 sign bit, 8 exponent bits, 7 mantissa bits). The design includes all control components required for floating-point addition, subtraction, and multiplication operations.

The processor was:
- Designed using Verilog HDL
- Simulated and verified using Icarus Verilog and GTKWave
- Synthesized and deployed on FPGA development boards
- Tested with various test cases for functional verification
- Integrated with fpga led's for real-time output monitoring

The design successfully performs **floating-point arithmetic operations** on BFloat16 format numbers, demonstrating correct unpacking, alignment, computation, normalization, and packing of results.
---
# Key Features
- 16-bit **BFloat16 processor implementation**
- Processor capable of executing **addition, subtraction, and multiplication** operations on BFloat16 format numbers
- Modular RTL design using **Verilog HDL**
- RTL modules including:
  - **Unpacker**: Extracts sign, exponent, and mantissa from BFloat16 input
  - **Comparator**: Determines larger operand and exponent difference
  - **Aligner**: Shifts mantissa based on exponent difference for alignment
  - **Math**: Performs addition and subtraction on aligned mantissas
  - **Multiplier**: Performs multiplication of two BFloat16 numbers
  - **Normalizer**: Normalizes results and handles exponent adjustments
  - **Packer**: Packs final result back into BFloat16 format
- Support for **special values** (zero, infinity)
- Successful **synthesized and verified** design
- **Operation selection** via sel input (00=pass-through, 01=add/sub, 10=multiply)

# Project Structure
| File | Description |
|------|-------------|
| `main.v` | Top-level processor module integrating all components |
| `unpacker.v` | BFloat16 unpacking module |
| `comparator.v` | Compares two BFloat16 numbers |
| `aligner.v` | Mantissa alignment for addition/subtraction |
| `math.v` | Arithmetic operations on mantissas |
| `multiplier.v` | BFloat16 multiplication module |
| `normalizer.v` | Result normalization module |
| `packer.v` | Final result packing module |

# BFloat16 Format
```
| Bit 15 | Bits 14-7 | Bits 6-0 |
|--------|-----------|----------|
| Sign   | Exponent  | Mantissa |
| 1 bit  | 8 bits    | 7 bits   |
```

# Operations
- **sel = 00**: Pass-through mode (output = input A)
- **sel = 01**: Addition/Subtraction (based on signs)
- **sel = 10**: Multiplication

# Technical Details
- Exponent bias: 127
- Special cases handled: Zero, Infinity, Normal numbers
- Maximum exponent: 254 (Infinity = 255)
- Mantissa representation: Leading 1 for normalized numbers
