import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'tap_mechanic.dart';

/// A tap mechanic that creates a 3D raised button effect with a bottom edge.
///
/// This mechanic simulates a realistic 3D button by adding a visible raised
/// bottom. When pressed, the button moves down and the bottom shrinks,
/// creating a satisfying physical button press effect.
///
/// Example:
/// ```dart
/// Tappable(
///   onTap: () => print('Pressed!'),
///   tapMechanics: [
///     RaisedEdgeTapMechanic(
///       raisedEdgeHeight: 8.0,
///       raisedEdgeColor: Colors.blue.shade700,
///     ),
///   ],
///   child: Container(
///     padding: EdgeInsets.all(16),
///     color: Colors.blue,
///     child: Text('3D Button'),
///   ),
/// )
/// ```
class RaisedEdgeTapMechanic extends TapMechanic {
  /// The height of the raised bottom in pixels.
  ///
  /// This determines how much the button appears to be raised.
  /// When pressed, this animates to 0 (flat).
  ///
  /// Defaults to 6.0 pixels.
  final double raisedEdgeHeight;

  /// The color of the raised bottom edge.
  ///
  /// Typically a darker shade of the main surface color to create depth.
  final Color raisedEdgeColor;

  /// Optional gradient for the bottom edge instead of a solid color.
  ///
  /// If provided, this overrides [raisedEdgeColor].
  final Gradient? raisedEdgeGradient;

  /// The duration of the press animation.
  ///
  /// Defaults to 100 milliseconds.
  final Duration duration;

  /// The animation curve.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve curve;

  /// Creates a raised edge tap mechanic.
  RaisedEdgeTapMechanic({
    this.raisedEdgeHeight = 6.0,
    required this.raisedEdgeColor,
    this.raisedEdgeGradient,
    this.duration = const Duration(milliseconds: 200),
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

    return _RaisedEdgeAnimation(
      onTap: onTap,
      raisedEdgeHeight: raisedEdgeHeight,
      raisedEdgeColor: raisedEdgeColor,
      raisedEdgeGradient: raisedEdgeGradient,
      duration: duration,
      curve: curve,
      borderRadius: borderRadius,
      child: child,
    );
  }
}

/// Stateful widget that handles the raised edge animation.
class _RaisedEdgeAnimation extends StatefulWidget {
  final VoidCallback onTap;
  final double raisedEdgeHeight;
  final Color raisedEdgeColor;
  final Gradient? raisedEdgeGradient;
  final Duration duration;
  final Curve curve;
  final BorderRadius? borderRadius;
  final Widget child;

  const _RaisedEdgeAnimation({
    required this.onTap,
    required this.raisedEdgeHeight,
    required this.raisedEdgeColor,
    required this.raisedEdgeGradient,
    required this.duration,
    required this.curve,
    required this.borderRadius,
    required this.child,
  });

  @override
  State<_RaisedEdgeAnimation> createState() => _RaisedEdgeAnimationState();
}

class _RaisedEdgeAnimationState extends State<_RaisedEdgeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Calculate scale: when unpressed (animation=0), compressed; when pressed (animation=1), full 100%
          // Compression factor based on raisedEdgeHeight relative to typical button size
          final compressionFactor = widget.raisedEdgeHeight / 100.0;
          final contentScale =
              1.0 - (compressionFactor * (1.0 - _animation.value));

          return Container(
            decoration: BoxDecoration(
              color: widget.raisedEdgeColor,
              borderRadius: widget.borderRadius,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Main button content (top stays fixed, expands downward when pressed)
                Transform(
                  transform: Matrix4.diagonal3Values(1.0, contentScale, 1.0),
                  alignment: Alignment.topCenter,
                  child: widget.child,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
