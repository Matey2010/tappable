# Tappable Package

A collection of highly customizable, interactive Flutter widgets built with tree-shaking support. Each widget can be imported individually to keep your bundle size minimal.

## Features

- **Tree-shakable exports** - Import only what you need
- **Highly customizable** - Every widget is built to be flexible
- **Material Design integration** - Proper ink effects and Material theming
- **Builder pattern support** - Custom builders for advanced use cases
- **Consistent API** - Similar patterns across all widgets

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tappable:
    path: ../tappable
```

## Usage

### Import Options

```dart
// Import all widgets
import 'package:tappable/tappable.dart';

// Or import individually for tree-shaking
import 'package:tappable/widgets/tappable.dart';
import 'package:tappable/widgets/tappable_container.dart';
import 'package:tappable/widgets/t_button.dart';
import 'package:tappable/widgets/t_checkbox.dart';
import 'package:tappable/widgets/t_switch.dart';
```

---

## Widgets

### 1. Tappable

The base widget that provides Material ink effects with customizable splash and highlight colors.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `onTap` | `VoidCallback?` | `null` | Callback when widget is tapped |
| `borderRadius` | `BorderRadius?` | `null` | Border radius for ink effects |
| `child` | `Widget?` | `null` | Child widget |
| `splashColor` | `Color?` | `null` | Color of the splash effect |
| `highlightColor` | `Color?` | `null` | Color when pressed |
| `splashRadius` | `double?` | `null` | Radius of the splash |
| `splashFactory` | `InteractiveInkFeatureFactory?` | `null` | Custom splash factory |
| `fillParent` | `bool` | `false` | Whether to expand to fill parent |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding around the child |

#### Example

```dart
Tappable(
  onTap: () {
    print('Tapped!');
  },
  borderRadius: BorderRadius.circular(12),
  splashColor: Colors.blue.withValues(alpha: 0.3),
  highlightColor: Colors.blue.withValues(alpha: 0.1),
  padding: const EdgeInsets.all(16),
  child: Text('Tap me!'),
)
```

#### Features

- Returns non-interactive child when `onTap` is `null`
- Automatic Material and Ink wrapping for proper effects
- Support for custom splash factories

---

### 2. TappableContainer

A powerful combination of `Tappable` and `Container` that automatically syncs the container's border radius with the tap effect.

#### Parameters

**Tappable Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `onTap` | `VoidCallback?` | `null` | Callback when tapped |
| `splashColor` | `Color?` | `null` | Splash effect color |
| `highlightColor` | `Color?` | `null` | Highlight color |
| `splashRadius` | `double?` | `null` | Splash radius |
| `splashFactory` | `InteractiveInkFeatureFactory?` | `null` | Custom splash factory |
| `fillParent` | `bool` | `false` | Fill parent size |
| `tappablePadding` | `EdgeInsetsGeometry?` | `null` | Padding for tappable area |

**Container Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `alignment` | `AlignmentGeometry?` | `null` | Child alignment |
| `padding` | `EdgeInsetsGeometry?` | `null` | Container padding |
| `color` | `Color?` | `null` | Background color |
| `decoration` | `Decoration?` | `null` | Container decoration |
| `foregroundDecoration` | `Decoration?` | `null` | Foreground decoration |
| `width` | `double?` | `null` | Container width |
| `height` | `double?` | `null` | Container height |
| `constraints` | `BoxConstraints?` | `null` | Size constraints |
| `margin` | `EdgeInsetsGeometry?` | `null` | External margin |
| `transform` | `Matrix4?` | `null` | Transform matrix |
| `transformAlignment` | `AlignmentGeometry?` | `null` | Transform alignment |
| `clipBehavior` | `Clip` | `Clip.none` | Clip behavior |
| `child` | `Widget?` | `null` | Child widget |

#### Example

```dart
TappableContainer(
  onTap: () => print('Container tapped!'),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  padding: const EdgeInsets.all(20),
  splashColor: Colors.white.withValues(alpha: 0.3),
  child: Text('Beautiful Card'),
)
```

#### Key Feature

The widget automatically extracts `BorderRadius` from `BoxDecoration` and passes it to the `Tappable` wrapper, ensuring tap effects respect the container's rounded corners.

---

### 3. TCheckbox

A customizable checkbox widget with Stack-based architecture for complete control over appearance.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `bool` | required | Current checkbox state |
| `onChanged` | `ValueChanged<bool>?` | `null` | Callback when value changes |
| `buildBackground` | `CheckboxBuilder?` | `null` | Custom background builder |
| `buildThumb` | `CheckboxBuilder?` | `null` | Custom checkmark builder |
| `size` | `double` | `24.0` | Size of the checkbox |
| `borderRadius` | `BorderRadius?` | `BorderRadius.circular(4)` | Border radius |
| `splashColor` | `Color?` | `null` | Tap splash color |
| `highlightColor` | `Color?` | `null` | Tap highlight color |

#### Type Definitions

```dart
typedef CheckboxBuilder = Widget Function(BuildContext context, bool value);
```

#### Default Behavior

- **Background**: Blue when checked, transparent with grey border when unchecked
- **Thumb**: White checkmark icon when checked

#### Examples

**Basic Usage:**
```dart
bool isChecked = false;

TCheckbox(
  value: isChecked,
  onChanged: (newValue) {
    setState(() {
      isChecked = newValue;
    });
  },
)
```

**Custom Styling:**
```dart
TCheckbox(
  value: isChecked,
  onChanged: (newValue) => setState(() => isChecked = newValue),
  size: 28,
  borderRadius: BorderRadius.circular(8),
  buildBackground: (context, value) {
    return Container(
      decoration: BoxDecoration(
        gradient: value
            ? LinearGradient(
                colors: [Colors.purple, Colors.blue],
              )
            : null,
        color: value ? null : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: value ? Colors.purple : Colors.grey,
          width: 2,
        ),
      ),
    );
  },
  buildThumb: (context, value) {
    return Icon(
      Icons.check_circle,
      size: 20,
      color: Colors.white,
    );
  },
)
```

---

### 4. TSwitch

An animated switch widget with full customization support for background and thumb.

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `bool` | required | Current switch state |
| `onChanged` | `ValueChanged<bool>?` | `null` | Callback when value changes |
| `buildBackground` | `SwitchBuilder?` | `null` | Custom background builder |
| `buildThumb` | `SwitchBuilder?` | `null` | Custom thumb builder |
| `width` | `double` | `51.0` | Switch width |
| `height` | `double` | `31.0` | Switch height |
| `borderRadius` | `BorderRadius?` | `BorderRadius.circular(height / 2)` | Border radius |
| `splashColor` | `Color?` | `null` | Tap splash color |
| `highlightColor` | `Color?` | `null` | Tap highlight color |
| `animationDuration` | `Duration` | `Duration(milliseconds: 200)` | Animation duration |

#### Type Definitions

```dart
typedef SwitchBuilder = Widget Function(BuildContext context, bool value);
```

#### Default Behavior

- **Background**: Animated color transition (blue when on, grey when off)
- **Thumb**: Circular white thumb with shadow, animated position
- **Animation**: Smooth 200ms transition

#### Examples

**Basic Usage:**
```dart
bool isSwitched = false;

TSwitch(
  value: isSwitched,
  onChanged: (newValue) {
    setState(() {
      isSwitched = newValue;
    });
  },
)
```

**Custom Size and Colors:**
```dart
TSwitch(
  value: isSwitched,
  onChanged: (newValue) => setState(() => isSwitched = newValue),
  width: 60,
  height: 35,
  animationDuration: Duration(milliseconds: 300),
  buildBackground: (context, value) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: value
            ? LinearGradient(colors: [Colors.green, Colors.teal])
            : LinearGradient(colors: [Colors.grey.shade400, Colors.grey.shade300]),
        borderRadius: BorderRadius.circular(35 / 2),
      ),
    );
  },
  buildThumb: (context, value) {
    return Container(
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: value
          ? Icon(Icons.check, size: 16, color: Colors.green)
          : null,
    );
  },
)
```

---

### 5. TButton

A fully customizable button widget built on `TappableContainer` with support for disabled states.

#### Parameters

**Core Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `child` | `Widget?` | `null` | Button content |
| `onPressed` | `VoidCallback?` | `null` | Callback when pressed (null = disabled) |

**TappableContainer Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `splashColor` | `Color?` | `null` | Splash effect color |
| `highlightColor` | `Color?` | `null` | Highlight color |
| `splashRadius` | `double?` | `null` | Splash radius |
| `splashFactory` | `InteractiveInkFeatureFactory?` | `null` | Custom splash factory |
| `fillParent` | `bool` | `false` | Fill parent size |
| `tappablePadding` | `EdgeInsetsGeometry?` | `null` | Tappable area padding |

**Container Styling:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `alignment` | `AlignmentGeometry?` | `null` | Content alignment |
| `padding` | `EdgeInsetsGeometry?` | `EdgeInsets.symmetric(horizontal: 16, vertical: 12)` | Button padding |
| `backgroundColor` | `Color?` | `null` | Background color |
| `decoration` | `Decoration?` | `null` | Container decoration |
| `foregroundDecoration` | `Decoration?` | `null` | Foreground decoration |
| `width` | `double?` | `null` | Button width |
| `height` | `double?` | `null` | Button height |
| `constraints` | `BoxConstraints?` | `null` | Size constraints |
| `margin` | `EdgeInsetsGeometry?` | `null` | External margin |
| `transform` | `Matrix4?` | `null` | Transform matrix |
| `transformAlignment` | `AlignmentGeometry?` | `null` | Transform alignment |
| `clipBehavior` | `Clip` | `Clip.none` | Clip behavior |

**Disabled State:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `disabledBackgroundColor` | `Color?` | `null` | Background when disabled |
| `disabledDecoration` | `Decoration?` | `null` | Decoration when disabled |
| `disabledOpacity` | `double` | `0.5` | Opacity when disabled |

#### Examples

**Basic Button:**
```dart
TButton(
  onPressed: () => print('Button pressed!'),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text(
    'Click Me',
    style: TextStyle(color: Colors.white),
  ),
)
```

**Elevated Button Style:**
```dart
TButton(
  onPressed: () => print('Elevated!'),
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
  splashColor: Colors.white.withValues(alpha: 0.3),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.rocket_launch, color: Colors.white),
      SizedBox(width: 8),
      Text('Launch', style: TextStyle(color: Colors.white, fontSize: 16)),
    ],
  ),
)
```

**Disabled State:**
```dart
TButton(
  onPressed: null, // null means disabled
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  disabledBackgroundColor: Colors.grey.shade300,
  disabledOpacity: 0.6,
  child: Text('Disabled Button'),
)
```

**Icon Button:**
```dart
TButton(
  onPressed: () => print('Icon tapped!'),
  decoration: BoxDecoration(
    color: Colors.blue,
    shape: BoxShape.circle,
  ),
  padding: EdgeInsets.all(12),
  width: 48,
  height: 48,
  child: Icon(Icons.favorite, color: Colors.white),
)
```

**Full Width Button:**
```dart
TButton(
  onPressed: () => print('Full width!'),
  decoration: BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(8),
  ),
  width: double.infinity,
  child: Text(
    'Continue',
    style: TextStyle(color: Colors.white, fontSize: 16),
  ),
)
```

---

## Design Philosophy

### Tree-Shaking Support

Each widget is exported individually, allowing you to import only what you need:

```dart
// Only imports TButton, reducing bundle size
import 'package:tappable/widgets/t_button.dart';
```

### Builder Pattern

Widgets like `TCheckbox` and `TSwitch` use builder functions for maximum flexibility:

```dart
typedef CheckboxBuilder = Widget Function(BuildContext context, bool value);
typedef SwitchBuilder = Widget Function(BuildContext context, bool value);
```

This pattern allows you to:
- Build completely custom UI based on state
- Access BuildContext for theme data
- Maintain reactive updates

### Material Integration

All widgets properly integrate with Material Design:
- Ink effects respect border radius
- Splash colors follow Material guidelines
- Widgets work seamlessly in Material apps

### Disabled State Handling

Buttons and interactive widgets handle disabled states gracefully:
- `onPressed: null` or `onChanged: null` disables the widget
- Custom styling for disabled state via `disabled*` parameters
- Opacity control for visual feedback

---

## Advanced Usage

### Custom Splash Factory

```dart
Tappable(
  onTap: () {},
  splashFactory: InkRipple.splashFactory,
  borderRadius: BorderRadius.circular(12),
  child: YourWidget(),
)
```

### Combining Widgets

```dart
// Checkbox with custom label
Row(
  children: [
    TCheckbox(
      value: agreedToTerms,
      onChanged: (value) => setState(() => agreedToTerms = value),
    ),
    SizedBox(width: 8),
    Text('I agree to the terms'),
  ],
)

// Button with loading state
TButton(
  onPressed: isLoading ? null : () => handleSubmit(),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  child: isLoading
      ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: Colors.white),
        )
      : Text('Submit'),
)
```

### Responsive Buttons

```dart
LayoutBuilder(
  builder: (context, constraints) {
    return TButton(
      onPressed: () {},
      width: constraints.maxWidth > 600 ? 200 : double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('Responsive Button'),
    );
  },
)
```

---

## Best Practices

1. **Use individual imports** for production apps to minimize bundle size
2. **Leverage builders** for complex custom styling
3. **Set borderRadius consistently** between decoration and tappable properties
4. **Handle disabled states** explicitly with custom styling
5. **Use const constructors** where possible for better performance
6. **Combine with Material widgets** for consistent theming

---

## License

This package is part of the flutter-projects monorepo.
