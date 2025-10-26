# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2025-10-26

### Added
- Initial release of the tappable package
- `Tappable` widget with Material Design ink effects
  - Support for custom splash and highlight colors
  - Configurable border radius for ink effects
  - Optional padding and fill parent functionality
  - Support for custom splash factories
- `TappableContainer` widget combining Tappable with Container
  - Automatic border radius extraction from BoxDecoration
  - Full Container parameter support
  - Seamless integration of tap effects with container styling
- `TCheckbox` widget with customizable appearance
  - Stack-based architecture with background and thumb layers
  - Builder pattern support via `buildBackground` and `buildThumb`
  - Configurable size and border radius
  - Default Material Design-like styling
- `TSwitch` widget with smooth animations
  - Animated thumb position and background color
  - Customizable via builder pattern
  - Configurable animation duration
  - Default toggle switch appearance with shadow effects
- `TButton` widget for highly customizable buttons
  - Built on TappableContainer foundation
  - Support for disabled states with custom styling
  - Configurable disabled opacity
  - Full Container and Tappable parameter exposure
- Tree-shakable exports for optimal bundle size
  - Main export file for all widgets
  - Individual widget exports in `widgets/` directory
- Comprehensive documentation in CLAUDE.md
  - Complete API reference for all widgets
  - Multiple examples from basic to advanced
  - Design philosophy and best practices
  - Advanced usage patterns
- MIT License
- README with package overview

### Architecture Decisions
- Chose Stack-based approach for checkbox and switch to maximize customization
- Separated tappable logic from container logic for better composition
- Used builder pattern for custom rendering to provide maximum flexibility
- Implemented tree-shakable exports to support minimal bundle sizes

## [Unreleased]

### Planned
- Haptic feedback support
- Accessibility improvements (focus, keyboard navigation, semantic labels)
- Additional widgets (TRadio, TSlider, TSegmentedControl)
- Theme support with InheritedWidget
- Example application
- Comprehensive test coverage

---

[0.0.1]: https://github.com/Matey2010/tappable/releases/tag/v0.0.1
