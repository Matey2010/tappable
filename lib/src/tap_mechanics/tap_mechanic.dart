import 'package:flutter/widgets.dart';

/// Base class for all tap mechanics.
///
/// A tap mechanic defines how a tappable widget responds visually when tapped.
/// Multiple mechanics can be combined together to create complex interactions.
///
/// Example:
/// ```dart
/// class MyCustomMechanic extends TapMechanic {
///   @override
///   Widget build({
///     required BuildContext context,
///     required VoidCallback? onTap,
///     required Widget child,
///     BorderRadius? borderRadius,
///   }) {
///     if (onTap == null) return child;
///     return GestureDetector(
///       onTap: onTap,
///       child: child,
///     );
///   }
/// }
/// ```
abstract class TapMechanic {
  /// Builds the interactive widget with tap effects.
  ///
  /// Parameters:
  /// - [context]: The build context
  /// - [onTap]: The callback to invoke when tapped. If null, should return non-interactive child.
  /// - [child]: The child widget to wrap with tap mechanics
  /// - [borderRadius]: Optional border radius for clipping tap effects
  ///
  /// Returns a widget that wraps [child] with the tap mechanic's visual effects.
  Widget build({
    required BuildContext context,
    required VoidCallback? onTap,
    required Widget child,
    BorderRadius? borderRadius,
  });
}
