# 📋 Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0] - 2025-11-17

### ✨ Added

- **Pluggable Tap Mechanics System**
  - New `tapMechanics` parameter on `Tappable` and `TappableContainer` widgets
  - Support for multiple mechanics on a single widget
  - Mechanics compose together for rich interactive experiences

- **Built-in Tap Mechanics**
  - `RippleTapMechanic`: Material Design ink ripple effect (default)
    - Supports custom splash color, highlight color, splash radius
    - Support for InkSparkle (Material 3) and InkRipple splash factories
  - `ScaleTapMechanic`: Scale animation on press
    - Configurable scale factor, duration, and animation curve
    - Default shrinks to 95% (0.95 scale factor)
  - `PressTapMechanic`: 3D press effect with shadow animation
    - Configurable press depth, shadow color, and blur radius
    - Simulates realistic button press interaction
  - `OpacityTapMechanic`: Opacity fade on press (iOS-style)
    - Configurable opacity level
    - Smooth fade in/out animation
  - `BevelTapMechanic`: 3D trapezoid/raised button effect
    - Realistic physical button simulation with beveled edges
    - Configurable bevel direction (top, bottom, left, right)
    - Adjustable bevel height for different depth effects
    - Support for solid color or gradient on bevel edge
    - Content perspective transform that matches 3D surface
    - Animated borders on raised edge and diagonal beveled sides
    - Smooth animation between raised (trapezoid) and pressed (flat) states
    - Perfect for retro UIs, game interfaces, and realistic button designs
  - `NoneTapMechanic`: No visual feedback
    - Pure gesture detection without visual effects

- **Example Application**
  - Comprehensive example app showcasing all widgets and mechanics
  - Individual demo pages for Tappable, TappableContainer, and Tap Mechanics
  - Live examples of single and combined mechanics
  - Real-world use cases and patterns
  - Located in `example/` directory

- **Base Classes for Extensibility**
  - `TapMechanic` abstract class for custom mechanics
  - Easy to create custom tap effects by extending `TapMechanic`
  - Full control over tap animation and visual feedback

### 🗑️ Deprecated

- **Ripple-specific parameters on Tappable**
  - `splashColor` → Use `RippleTapMechanic(splashColor: ...)` in `tapMechanics`
  - `highlightColor` → Use `RippleTapMechanic(highlightColor: ...)` in `tapMechanics`
  - `splashRadius` → Use `RippleTapMechanic(splashRadius: ...)` in `tapMechanics`
  - `splashFactory` → Use `RippleTapMechanic(splashFactory: ...)` in `tapMechanics`
  - Will be removed in version 1.0.0

- **Ripple-specific parameters on TappableContainer**
  - Same deprecations as Tappable
  - Use `tapMechanics` parameter instead
  - Will be removed in version 1.0.0

### 🔄 Changed

- **Tappable widget architecture**
  - Refactored to use composition-based tap mechanics system
  - Mechanics are applied in order (first wraps child, second wraps first, etc.)
  - Maintains full backward compatibility with deprecated parameters

### 📝 Migration Guide

```dart
// Before (0.2.0) - Still works but deprecated
Tappable(
  onTap: () {},
  splashColor: Colors.blue.withValues(alpha: 0.3),
  highlightColor: Colors.blue.withValues(alpha: 0.1),
  child: Text('Tap me'),
)

// After (0.3.0) - Recommended approach
Tappable(
  onTap: () {},
  tapMechanics: [
    RippleTapMechanic(
      splashColor: Colors.blue.withValues(alpha: 0.3),
      highlightColor: Colors.blue.withValues(alpha: 0.1),
    ),
  ],
  child: Text('Tap me'),
)

// New: Combine multiple mechanics
Tappable(
  onTap: () {},
  tapMechanics: [
    RippleTapMechanic(),
    ScaleTapMechanic(scaleFactor: 0.95),
  ],
  child: Text('Ripple + Scale'),
)

// New: Use different mechanics
Tappable(
  onTap: () {},
  tapMechanics: [
    PressTapMechanic(
      pressDepth: 4.0,
      shadowColor: Colors.black26,
    ),
  ],
  child: Text('3D Press'),
)
```

### 🎯 Rationale

- **Flexibility**: Support for different design systems (Material, Cupertino, custom)
- **Composability**: Combine multiple tap effects for richer interactions
- **Extensibility**: Easy to create custom tap mechanics
- **Tree-shakable**: Unused mechanics won't be included in final bundle
- **Modern UX**: Support for popular interaction patterns (scale, press, fade)
- **Future-proof**: Architecture ready for additional tap mechanics

### 📚 Documentation

- Updated README.md with tap mechanics section and examples
- Added comprehensive example app with live demos
- Documented all tap mechanics with parameters and use cases
- Migration guide for deprecated parameters

## [0.2.0] - 2025-11-12

### 🗑️ Deprecated

- **TButton**: Moved to `tappable_elements` package as `TeButton`
  - Use `package:tappable_elements` for button components
  - Will be removed in version 1.0.0
- **TCheckbox**: Moved to `tappable_elements` package as `TeCheckbox`
  - Use `package:tappable_elements` for checkbox components
  - Will be removed in version 1.0.0
- **TSwitch**: Moved to `tappable_elements` package as `TeSwitch`
  - Use `package:tappable_elements` for switch components
  - Will be removed in version 1.0.0

### 📦 Package Restructuring

- **Core widgets remain**: `Tappable` and `TappableContainer` are still part of this package
- **UI elements extracted**: Button, Checkbox, and Switch widgets moved to dedicated `tappable_elements` package
- **Better separation**: Core touch/tap functionality separated from UI components

### 📝 Migration Guide

```dart
// Before (tappable 0.0.1)
import 'package:tappable/tappable.dart';

TButton(onPressed: () {}, child: Text('Click me'))

// After (tappable 0.2.0)
import 'package:tappable/tappable.dart';  // For Tappable and TappableContainer
import 'package:tappable_elements/tappable_elements.dart';  // For UI elements

TeButton(onPressed: () {}, child: Text('Click me'))
```

### 🎯 Rationale

- Improves package modularity and maintainability
- Allows independent versioning of UI components
- Reduces dependencies for apps only needing core tap functionality
- Prepares for future expansion of UI element library

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
- Haptic feedback support for tap mechanics
- Accessibility improvements (focus, keyboard navigation, semantic labels)
- Additional tap mechanics (bounce, rotate, slide)
- Theme support with InheritedWidget for default mechanics
- Comprehensive test coverage
- Performance benchmarks for combined mechanics

---

[0.0.1]: https://github.com/Matey2010/tappable/releases/tag/v0.0.1
