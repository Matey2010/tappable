import 'package:flutter/widgets.dart';

import 'tap_mechanic.dart';

/// A tap mechanic that scales the widget when pressed.
///
/// This creates a "shrink on press" effect commonly seen in iOS and modern
/// mobile interfaces.
///
/// Example:
/// ```dart
/// Tappable(
///   onTap: () => print('Tapped!'),
///   tapMechanics: [
///     ScaleTapMechanic(
///       scaleFactor: 0.95,  // Shrink to 95%
///       duration: Duration(milliseconds: 100),
///     ),
///   ],
///   child: Text('Tap me'),
/// )
/// ```
class ScaleTapMechanic extends TapMechanic {
  /// The scale factor when pressed.
  ///
  /// A value less than 1.0 shrinks the widget (e.g., 0.95 = 95% size).
  /// A value greater than 1.0 enlarges the widget (e.g., 1.1 = 110% size).
  ///
  /// Defaults to 0.95 (shrink to 95%).
  final double scaleFactor;

  /// The duration of the scale animation.
  ///
  /// Defaults to 100 milliseconds.
  final Duration duration;

  /// The animation curve.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve curve;

  /// Creates a scale tap mechanic.
  ScaleTapMechanic({
    this.scaleFactor = 0.95,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build({
    required BuildContext context,
    required VoidCallback? onTap,
    required Widget child,
    BorderRadius? borderRadius,
  }) {
    if (onTap == null) return child;

    return _ScaleAnimation(
      onTap: onTap,
      scaleFactor: scaleFactor,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}

class _ScaleAnimation extends StatefulWidget {
  final VoidCallback onTap;
  final double scaleFactor;
  final Duration duration;
  final Curve curve;
  final Widget child;

  const _ScaleAnimation({
    required this.onTap,
    required this.scaleFactor,
    required this.duration,
    required this.curve,
    required this.child,
  });

  @override
  State<_ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<_ScaleAnimation> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? widget.scaleFactor : 1.0,
        duration: widget.duration,
        curve: widget.curve,
        child: widget.child,
      ),
    );
  }
}
