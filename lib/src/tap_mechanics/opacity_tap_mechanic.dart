import 'package:flutter/widgets.dart';

import 'tap_mechanic.dart';

/// A tap mechanic that changes opacity when pressed.
///
/// This creates a simple fade effect commonly seen in iOS interfaces,
/// where tappable elements become semi-transparent when pressed.
///
/// Example:
/// ```dart
/// Tappable(
///   onTap: () => print('Tapped!'),
///   tapMechanics: [
///     OpacityTapMechanic(
///       opacity: 0.6,  // Fade to 60% opacity
///       duration: Duration(milliseconds: 100),
///     ),
///   ],
///   child: Text('Tap me'),
/// )
/// ```
class OpacityTapMechanic extends TapMechanic {
  /// The opacity when pressed.
  ///
  /// A value between 0.0 (fully transparent) and 1.0 (fully opaque).
  /// Defaults to 0.7 (70% opacity).
  final double opacity;

  /// The duration of the opacity animation.
  ///
  /// Defaults to 100 milliseconds.
  final Duration duration;

  /// The animation curve.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve curve;

  /// Creates an opacity tap mechanic.
  OpacityTapMechanic({
    this.opacity = 0.7,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.easeInOut,
  }) : assert(opacity >= 0.0 && opacity <= 1.0, 'Opacity must be between 0.0 and 1.0');

  @override
  Widget build({
    required BuildContext context,
    required VoidCallback? onTap,
    required Widget child,
    BorderRadius? borderRadius,
  }) {
    if (onTap == null) return child;

    return _OpacityAnimation(
      onTap: onTap,
      opacity: opacity,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}

class _OpacityAnimation extends StatefulWidget {
  final VoidCallback onTap;
  final double opacity;
  final Duration duration;
  final Curve curve;
  final Widget child;

  const _OpacityAnimation({
    required this.onTap,
    required this.opacity,
    required this.duration,
    required this.curve,
    required this.child,
  });

  @override
  State<_OpacityAnimation> createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<_OpacityAnimation> {
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
      child: AnimatedOpacity(
        opacity: _isPressed ? widget.opacity : 1.0,
        duration: widget.duration,
        curve: widget.curve,
        child: widget.child,
      ),
    );
  }
}
