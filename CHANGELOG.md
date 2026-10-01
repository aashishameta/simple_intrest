# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0+1] - 2026-10-01

### Added
- Core `CalculatorService` class with basic arithmetic operations:
  - Addition (`add`)
  - Subtraction (`subtract`)
  - Multiplication (`multiply`)
  - Division (`divide`) with zero-division handling.
- Simple Interest formulas:
  - Simple Interest calculation: $SI = \frac{P \times R \times T}{100}$
  - Total Amount calculation: $Total = P + SI$
- Interactive Flutter Material 3 UI:
  - **Simple Interest Tab**: Inputs for Principal ($P$), Rate ($R\%$), and Time ($T$) with result cards.
  - **Basic Operations Tab**: Dual number inputs with operation buttons (`+`, `-`, `×`, `÷`).
- Unit and widget tests with 100% pass rate.
- Initial release under MIT License.
