import 'package:flutter/widgets.dart';

import 'tap_mechanic.dart';

/// A tap mechanic that creates a 3D press effect.
///
/// This mechanic simulates a button being pressed down by moving it slightly
/// downward and reducing its shadow, creating a realistic 3D press effect.
///
/// Example:
/// ```dart
/// Tappable(
///   onTap: () => print('Pressed!'),
///   tapMechanics: [
///     PressTapMechanic(
///       pressDepth: 4.0,  // How far to move down when pressed
///       shadowColor: Colors.black26,
///     ),
///   ],
///   child: Container(
///     padding: EdgeInsets.all(16),
///     decoration: BoxDecoration(
///       color: Colors.blue,
///       borderRadius: BorderRadius.circular(12),
///     ),
///     child: Text('Press me'),
///   ),
/// )
/// ```
class PressTapMechanic extends TapMechanic {
  /// The depth of the press effect in pixels.
  ///
  /// This determines how far the widget moves down when pressed.
  /// Defaults to 4.0 pixels.
  final double pressDepth;

  /// The duration of the press animation.
  ///
  /// Defaults to 100 milliseconds.
  final Duration duration;

  /// The animation curve.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve curve;

  /// The color of the shadow.
  ///
  /// If null, no shadow animation is applied.
  final Color? shadowColor;

  /// The blur radius of the shadow when not pressed.
  ///
  /// Defaults to 8.0 pixels.
  final double shadowBlurRadius;

  /// The blur radius of the shadow when pressed.
  ///
  /// Defaults to 2.0 pixels (shadow reduces when pressed).
  final double pressedShadowBlurRadius;

  /// Creates a 3D press tap mechanic.
  PressTapMechanic({
    this.pressDepth = 4.0,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.easeInOut,
    this.shadowColor,
    this.shadowBlurRadius = 8.0,
    this.pressedShadowBlurRadius = 2.0,
  });

  @override
  Widget build({
    required BuildContext context,
    required VoidCallback? onTap,
    required Widget child,
    BorderRadius? borderRadius,
  }) {
    if (onTap == null) return child;

    return _PressAnimation(
      onTap: onTap,
      pressDepth: pressDepth,
      duration: duration,
      curve: curve,
      shadowColor: shadowColor,
      shadowBlurRadius: shadowBlurRadius,
      pressedShadowBlurRadius: pressedShadowBlurRadius,
      child: child,
    );
  }
}

class _PressAnimation extends StatefulWidget {
  final VoidCallback onTap;
  final double pressDepth;
  final Duration duration;
  final Curve curve;
  final Color? shadowColor;
  final double shadowBlurRadius;
  final double pressedShadowBlurRadius;
  final Widget child;

  const _PressAnimation({
    required this.onTap,
    required this.pressDepth,
    required this.duration,
    required this.curve,
    required this.shadowColor,
    required this.shadowBlurRadius,
    required this.pressedShadowBlurRadius,
    required this.child,
  });

  @override
  State<_PressAnimation> createState() => _PressAnimationState();
}

class _PressAnimationState extends State<_PressAnimation> {
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
      child: AnimatedContainer(
        duration: widget.duration,
        curve: widget.curve,
        transform: Matrix4.translationValues(
          0,
          _isPressed ? widget.pressDepth : 0,
          0,
        ),
        decoration: widget.shadowColor != null
            ? BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: widget.shadowColor!,
                    blurRadius: _isPressed
                        ? widget.pressedShadowBlurRadius
                        : widget.shadowBlurRadius,
                    offset: Offset(
                      0,
                      _isPressed ? widget.pressDepth / 2 : widget.pressDepth,
                    ),
                  ),
                ],
              )
            : null,
        child: widget.child,
      ),
    );
  }
}
