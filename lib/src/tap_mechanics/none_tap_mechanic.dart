import 'package:flutter/widgets.dart';

import 'tap_mechanic.dart';

/// A tap mechanic that provides no visual feedback.
///
/// This mechanic only handles the tap gesture without any visual effects.
/// Useful when you want tap detection but no animation or feedback.
///
/// Example:
/// ```dart
/// Tappable(
///   onTap: () => print('Tapped!'),
///   tapMechanics: [NoneTapMechanic()],
///   child: Text('Tap me (no effect)'),
/// )
/// ```
class NoneTapMechanic extends TapMechanic {
  /// Creates a tap mechanic with no visual effects.
  NoneTapMechanic();

  @override
  Widget build({
    required BuildContext context,
    required VoidCallback? onTap,
    required Widget child,
    BorderRadius? borderRadius,
  }) {
    if (onTap == null) return child;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
