import 'package:flutter/widgets.dart';

import 'tap_mechanic.dart';

// Bevel direction enum removed - using single bottom bevel only

/// A tap mechanic that creates a 3D beveled/raised button effect.
///
/// This mechanic simulates a realistic 3D button by creating a trapezoid shape
/// that appears to bulge toward the user. The bottom edge is raised (wider at top,
/// narrower at bottom). When pressed, the button flattens to a rectangle,
/// creating a satisfying physical button press effect.
///
/// Example:
/// ```dart
/// Tappable(
///   onTap: () => print('Pressed!'),
///   tapMechanics: [
///     BevelTapMechanic(
///       bevelHeight: 8.0,
///       bevelColor: Colors.blue.shade700,
///     ),
///   ],
///   child: Container(
///     padding: EdgeInsets.all(16),
///     color: Colors.blue,
///     child: Text('3D Button'),
///   ),
/// )
/// ```
class BevelTapMechanic extends TapMechanic {
  /// The height of the bevel in pixels.
  ///
  /// This determines how much the button appears to bulge.
  /// When pressed, this animates to 0 (flat).
  ///
  /// Defaults to 6.0 pixels.
  final double bevelHeight;

  /// The color of the beveled edge (the visible "side" of the button).
  ///
  /// Typically a darker shade of the main surface color to create depth.
  final Color bevelColor;

  /// Optional gradient for the bevel edge instead of a solid color.
  ///
  /// If provided, this overrides [bevelColor].
  final Gradient? bevelGradient;

  /// The duration of the press animation.
  ///
  /// Defaults to 100 milliseconds.
  final Duration duration;

  /// The animation curve.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve curve;

  /// Creates a bevel tap mechanic.
  BevelTapMechanic({
    this.bevelHeight = 6.0,
    required this.bevelColor,
    this.bevelGradient,
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

    return _BevelAnimation(
      onTap: onTap,
      bevelHeight: bevelHeight,
      bevelColor: bevelColor,
      bevelGradient: bevelGradient,
      duration: duration,
      curve: curve,
      borderRadius: borderRadius,
      child: child,
    );
  }
}

/// Stateful widget that handles the bevel animation.
class _BevelAnimation extends StatefulWidget {
  final VoidCallback onTap;
  final double bevelHeight;
  final Color bevelColor;
  final Gradient? bevelGradient;
  final Duration duration;
  final Curve curve;
  final BorderRadius? borderRadius;
  final Widget child;

  const _BevelAnimation({
    required this.onTap,
    required this.bevelHeight,
    required this.bevelColor,
    required this.bevelGradient,
    required this.duration,
    required this.curve,
    required this.borderRadius,
    required this.child,
  });

  @override
  State<_BevelAnimation> createState() => _BevelAnimationState();
}

class _BevelAnimationState extends State<_BevelAnimation>
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
          final currentBevelHeight =
              widget.bevelHeight * (1.0 - _animation.value);

          if (currentBevelHeight == 0) {
            // No bevel when fully pressed - just return child
            return widget.child;
          }

          return CustomPaint(
            painter: _BevelBackgroundPainter(
              bevelHeight: currentBevelHeight,
              color: widget.bevelColor,
              gradient: widget.bevelGradient,
            ),
            child: ClipPath(
              clipper: _BevelClipper(bevelHeight: currentBevelHeight),
              child: Transform.scale(
                scaleY: 1.0 - (currentBevelHeight / 100.0), // Slightly compress vertically
                alignment: Alignment.center,
                child: widget.child,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Custom clipper that creates the trapezoid shape.
/// Bottom bevel: top is wider (full width), bottom is narrower.
class _BevelClipper extends CustomClipper<Path> {
  final double bevelHeight;

  _BevelClipper({required this.bevelHeight});

  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final bh = bevelHeight;

    // Bottom bevel: top is full width, bottom is narrower
    path.moveTo(0, 0); // top left (full width)
    path.lineTo(w, 0); // top right (full width)
    path.lineTo(w - bh, h - bh); // bottom right (narrower)
    path.lineTo(bh, h - bh); // bottom left (narrower)
    path.close();

    return path;
  }

  @override
  bool shouldReclip(_BevelClipper oldClipper) {
    return oldClipper.bevelHeight != bevelHeight;
  }
}

/// Custom painter that draws the beveled background (visible side of button).
/// Bottom bevel: draws left side, right side, and bottom edge.
class _BevelBackgroundPainter extends CustomPainter {
  final double bevelHeight;
  final Color color;
  final Gradient? gradient;

  _BevelBackgroundPainter({
    required this.bevelHeight,
    required this.color,
    this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (bevelHeight <= 0) return; // No bevel when fully pressed

    final paint = Paint()..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final bh = bevelHeight;

    // Draw the background that represents the visible "sides" of the button
    // These are the areas that get clipped away when the trapezoid is formed
    final path = Path();

    // Bottom bevel: bottom is raised
    // Draw left diagonal side
    path.moveTo(0, 0);
    path.lineTo(bh, h - bh);
    path.lineTo(bh, h);
    path.lineTo(0, h);
    path.close();

    // Draw right diagonal side
    path.moveTo(w, 0);
    path.lineTo(w - bh, h - bh);
    path.lineTo(w - bh, h);
    path.lineTo(w, h);
    path.close();

    // Draw bottom edge (horizontal raised edge)
    path.moveTo(bh, h - bh);
    path.lineTo(w - bh, h - bh);
    path.lineTo(w - bh, h);
    path.lineTo(bh, h);
    path.close();

    // Apply gradient or solid color
    if (gradient != null) {
      final rect = Rect.fromLTWH(0, 0, w, h);
      paint.shader = gradient!.createShader(rect);
    } else {
      paint.color = color;
    }

    // Draw the background (visible beveled sides)
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BevelBackgroundPainter oldDelegate) {
    return oldDelegate.bevelHeight != bevelHeight ||
        oldDelegate.color != color ||
        oldDelegate.gradient != gradient;
  }
}
