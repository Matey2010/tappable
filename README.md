# Tappable

A collection of highly customizable, tree-shakable Flutter widgets with Material Design integration. Build beautiful, interactive UIs with minimal code while keeping your bundle size optimal.

## Features

- **🎯 Tappable** - Base widget with Material ink effects and customizable splash colors
- **📦 TappableContainer** - Combines Tappable with Container, auto-syncing border radius
- **🔘 TButton** - Fully customizable button with disabled states and extensive styling options
- **☑️ TCheckbox** - Customizable checkbox with builder pattern support
- **🔄 TSwitch** - Animated switch with smooth transitions and custom styling
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
Tappable(
  onTap: () => print('Tapped!'),
  borderRadius: BorderRadius.circular(12),
  splashColor: Colors.blue.withValues(alpha: 0.3),
  child: Text('Tap me!'),
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
| **Tappable** | Base interactive widget with Material ink effects |
| **TappableContainer** | Combines Tappable with Container, auto-syncs border radius |
| **TButton** | Highly customizable button built on TappableContainer |
| **TCheckbox** | Customizable checkbox with Stack-based architecture |
| **TSwitch** | Animated switch with smooth transitions |

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
