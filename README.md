# Tappable

A collection of highly customizable, tree-shakable Flutter widgets with Material Design integration. Build beautiful, interactive UIs with minimal code while keeping your bundle size optimal.

## Features

- **🎯 Tappable** - Base widget with flexible tap mechanics system
- **📦 TappableContainer** - Combines Tappable with Container, auto-syncing border radius
- **✨ Tap Mechanics** - Pluggable tap effects: Ripple, Scale, Press, Opacity, and more
- **🔗 Composable** - Combine multiple tap mechanics for rich interactions
- **🔘 TButton** - Fully customizable button with disabled states (DEPRECATED - use tappable_elements)
- **☑️ TCheckbox** - Customizable checkbox with builder pattern (DEPRECATED - use tappable_elements)
- **🔄 TSwitch** - Animated switch with smooth transitions (DEPRECATED - use tappable_elements)
- **🌳 Tree-shakable** - Import only what you need to minimize bundle size
- **🎨 Highly customizable** - Builder patterns and extensive parameters for complete control
- **♿ Material Design** - Proper ink effects, theming, and platform integration

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tappable:
    path: ../tappable
```

Or if published to pub.dev:

```yaml
dependencies:
  tappable: ^0.0.1
```

## Quick Start

### Import

```dart
// Import all widgets
import 'package:tappable/tappable.dart';

// Or import individually for tree-shaking
import 'package:tappable/widgets/tappable.dart';
import 'package:tappable/widgets/t_button.dart';
```

### Basic Usage

**Tappable Widget**
```dart
// Default ripple effect
Tappable(
  onTap: () => print('Tapped!'),
  borderRadius: BorderRadius.circular(12),
  child: Text('Tap me!'),
)

// With custom tap mechanics
Tappable(
  onTap: () => print('Tapped!'),
  tapMechanics: [
    RippleTapMechanic(
      splashColor: Colors.blue.withValues(alpha: 0.3),
    ),
  ],
  child: Text('Custom ripple!'),
)

// Combine multiple mechanics
Tappable(
  onTap: () => print('Tapped!'),
  tapMechanics: [
    RippleTapMechanic(),
    ScaleTapMechanic(scaleFactor: 0.95),
  ],
  child: Text('Ripple + Scale!'),
)
```

**TButton Widget**
```dart
TButton(
  onPressed: () => print('Pressed!'),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text('Click Me', style: TextStyle(color: Colors.white)),
)
```

**TCheckbox Widget**
```dart
bool isChecked = false;

TCheckbox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value),
)
```

**TSwitch Widget**
```dart
bool isSwitched = false;

TSwitch(
  value: isSwitched,
  onChanged: (value) => setState(() => isSwitched = value),
)
```

**TappableContainer Widget**
```dart
TappableContainer(
  onTap: () => print('Container tapped!'),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(16),
  ),
  padding: EdgeInsets.all(20),
  child: Text('Beautiful Card'),
)
```

## Tap Mechanics

Tap mechanics define how widgets respond visually when tapped. Multiple mechanics can be combined to create rich, interactive experiences.

### Available Mechanics

| Mechanic | Description | Use Case |
|----------|-------------|----------|
| **RippleTapMechanic** | Material Design ink ripple | Default Material Design apps |
| **ScaleTapMechanic** | Scales widget on press | iOS-style buttons, modern UIs |
| **PressTapMechanic** | 3D press effect with shadow | Elevated buttons, realistic interactions |
| **OpacityTapMechanic** | Fades opacity on press | iOS-style, minimal feedback |
| **BevelTapMechanic** | 3D trapezoid/raised button | Realistic physical buttons, retro UIs |
| **NoneTapMechanic** | No visual feedback | Custom interactions, invisible tap areas |

### Single Mechanics

```dart
// Material ripple (default)
Tappable(
  onTap: () {},
  tapMechanics: [RippleTapMechanic()],
  child: Text('Ripple'),
)

// Scale animation
Tappable(
  onTap: () {},
  tapMechanics: [ScaleTapMechanic(scaleFactor: 0.95)],
  child: Text('Scale'),
)

// 3D press effect
Tappable(
  onTap: () {},
  tapMechanics: [
    PressTapMechanic(
      pressDepth: 4.0,
      shadowColor: Colors.black26,
    ),
  ],
  child: Text('Press'),
)

// Opacity fade (iOS-style)
Tappable(
  onTap: () {},
  tapMechanics: [OpacityTapMechanic(opacity: 0.6)],
  child: Text('Fade'),
)

// 3D Bevel effect
Tappable(
  onTap: () {},
  tapMechanics: [
    BevelTapMechanic(
      bevelHeight: 8.0,
      bevelColor: Colors.blue.shade700,
    ),
  ],
  child: Container(
    padding: EdgeInsets.all(16),
    color: Colors.blue,
    child: Text('3D Button'),
  ),
)
```

### Combined Mechanics

The real power comes from combining multiple mechanics:

```dart
// Ripple + Scale: Material feel with modern animation
Tappable(
  onTap: () {},
  tapMechanics: [
    RippleTapMechanic(splashColor: Colors.blue.withValues(alpha: 0.3)),
    ScaleTapMechanic(scaleFactor: 0.95),
  ],
  child: Text('Ripple + Scale'),
)

// Press + Opacity: Realistic 3D button
Tappable(
  onTap: () {},
  tapMechanics: [
    PressTapMechanic(pressDepth: 4.0, shadowColor: Colors.black26),
    OpacityTapMechanic(opacity: 0.8),
  ],
  child: Text('Press + Fade'),
)

// Triple combo: Maximum feedback
Tappable(
  onTap: () {},
  tapMechanics: [
    RippleTapMechanic(),
    ScaleTapMechanic(scaleFactor: 0.92),
    OpacityTapMechanic(opacity: 0.7),
  ],
  child: Text('All Effects'),
)
```

### Custom Configuration

Each mechanic accepts custom parameters:

```dart
ScaleTapMechanic(
  scaleFactor: 0.85,              // Scale to 85%
  duration: Duration(milliseconds: 300),  // Slow animation
  curve: Curves.elasticOut,       // Bouncy curve
)

PressTapMechanic(
  pressDepth: 8.0,                // Deep press
  shadowColor: Colors.red.withValues(alpha: 0.4),
  shadowBlurRadius: 12.0,         // Large shadow
  pressedShadowBlurRadius: 4.0,   // Small when pressed
)

RippleTapMechanic(
  splashFactory: InkSparkle.splashFactory,  // Material 3 sparkle
  splashColor: Colors.purple.withValues(alpha: 0.3),
)

BevelTapMechanic(
  bevelHeight: 12.0,                 // Large bevel
  bevelColor: Colors.indigo.shade900,
  bevelGradient: LinearGradient(    // Optional gradient
    colors: [Colors.indigo.shade900, Colors.indigo.shade700],
  ),
  duration: Duration(milliseconds: 150),
)
```

## Advanced Examples

### Custom Button with Gradient
```dart
TButton(
  onPressed: () {},
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.purple, Colors.deepPurple],
    ),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.purple.withValues(alpha: 0.4),
        blurRadius: 12,
        offset: Offset(0, 6),
      ),
    ],
  ),
  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.rocket_launch, color: Colors.white),
      SizedBox(width: 8),
      Text('Launch', style: TextStyle(color: Colors.white)),
    ],
  ),
)
```

### Custom Checkbox with Builders
```dart
TCheckbox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value),
  size: 28,
  buildBackground: (context, value) {
    return Container(
      decoration: BoxDecoration(
        gradient: value
            ? LinearGradient(colors: [Colors.purple, Colors.blue])
            : null,
        color: value ? null : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  },
  buildThumb: (context, value) {
    return Icon(Icons.check_circle, size: 20, color: Colors.white);
  },
)
```

## Documentation

For complete documentation with detailed API reference, advanced usage patterns, and best practices, see [CLAUDE.md](CLAUDE.md).

The full documentation includes:
- Complete parameter tables for all widgets
- Multiple examples from basic to advanced
- Design philosophy and architecture decisions
- Advanced usage patterns and combinations
- Best practices and recommendations

## Widgets Overview

| Widget | Description |
|--------|-------------|
| **Tappable** | Base interactive widget with pluggable tap mechanics |
| **TappableContainer** | Combines Tappable with Container, auto-syncs border radius |
| **RippleTapMechanic** | Material Design ripple effect |
| **ScaleTapMechanic** | Scale animation on press |
| **PressTapMechanic** | 3D press effect with shadow |
| **OpacityTapMechanic** | Opacity fade on press |
| **BevelTapMechanic** | 3D trapezoid/raised button effect |
| **NoneTapMechanic** | No visual feedback |
| **TButton** | Highly customizable button (DEPRECATED) |
| **TCheckbox** | Customizable checkbox (DEPRECATED) |
| **TSwitch** | Animated switch (DEPRECATED) |

## Why Tappable?

- **Tree-shakable**: Import only the widgets you use
- **Customizable**: Every widget is built for maximum flexibility
- **Composable**: Widgets work together seamlessly
- **Material Design**: Proper integration with Flutter's Material Design
- **Well-documented**: Comprehensive documentation and examples
- **Type-safe**: Full TypeScript-like type safety with Dart

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed history of changes.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues, feature requests, or questions, please file an issue on [GitHub](https://github.com/Matey2010/tappable/issues).
