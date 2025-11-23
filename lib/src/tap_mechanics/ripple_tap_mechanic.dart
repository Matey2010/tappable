import 'package:flutter/material.dart';
import 'tap_mechanic.dart';

/// A tap mechanic that provides Material Design ripple/ink effects.
///
/// This is the default tap mechanic and uses Flutter's [InkWell] to provide
/// the familiar Material ripple animation when tapped.
///
/// Example:
/// ```dart
/// Tappable(
///   onTap: () => print('Tapped!'),
///   tapMechanics: [
///     RippleTapMechanic(
///       splashColor: Colors.blue.withOpacity(0.3),
///       highlightColor: Colors.blue.withOpacity(0.1),
///     ),
///   ],
///   child: Text('Tap me'),
/// )
/// ```
class RippleTapMechanic extends TapMechanic {
  /// The splash color of the ink response.
  ///
  /// If null, uses the theme's splash color.
  final Color? splashColor;

  /// The highlight color of the ink response when pressed.
  ///
  /// If null, uses the theme's highlight color.
  final Color? highlightColor;

  /// The radius of the ink splash.
  ///
  /// If null, the splash will expand to fill the bounds.
  final double? splashRadius;

  /// Defines the ink splash behavior.
  ///
  /// Common values:
  /// - [InkRipple.splashFactory] (default) - circular ripple
  /// - [InkSparkle.splashFactory] - sparkle effect (Material 3)
  final InteractiveInkFeatureFactory? splashFactory;

  /// Creates a Material ripple tap mechanic.
  RippleTapMechanic({
    this.splashColor,
    this.highlightColor,
    this.splashRadius,
    this.splashFactory,
  });

  @override
  Widget build({
    required BuildContext context,
    required VoidCallback? onTap,
    required Widget child,
    BorderRadius? borderRadius,
  }) {
    if (onTap == null) return child;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(borderRadius: borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          splashColor: splashColor,
          highlightColor: highlightColor,
          radius: splashRadius,
          splashFactory: splashFactory,
          child: child,
        ),
      ),
    );
  }
}
