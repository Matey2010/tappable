import 'package:flutter/widgets.dart';

import 'tap_mechanic.dart';

/// Direction of the bevel effect.
///
/// Determines which edge of the widget appears raised/bulged toward the user.
enum BevelDirection {
  /// Bevel from top edge (top is wider, bottom is narrower)
  top,

  /// Bevel from bottom edge (bottom is wider, top is narrower)
  bottom,

  /// Bevel from left edge (left is taller, right is shorter)
  left,

  /// Bevel from right edge (right is taller, left is shorter)
  right,
}

/// A tap mechanic that creates a 3D beveled/raised button effect.
///
/// This mechanic simulates a realistic 3D button by creating a trapezoid shape
/// that appears to bulge toward the user. When pressed, the button flattens
/// to a rectangle, creating a satisfying physical button press effect.
///
/// The bevel can be applied from any direction (top, bottom, left, right),
/// and the appearance is highly customizable.
///
/// Example:
/// ```dart
/// Tappable(
///   onTap: () => print('Pressed!'),
///   tapMechanics: [
///     BevelTapMechanic(
///       direction: BevelDirection.top,
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
  /// The direction of the bevel effect.
  ///
  /// Determines which edge appears raised toward the user.
  final BevelDirection direction;

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
    this.direction = BevelDirection.top,
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
      direction: direction,
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
  final BevelDirection direction;
  final double bevelHeight;
  final Color bevelColor;
  final Gradient? bevelGradient;
  final Duration duration;
  final Curve curve;
  final BorderRadius? borderRadius;
  final Widget child;

  const _BevelAnimation({
    required this.onTap,
    required this.direction,
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

          // Create perspective transform matrix with offset based on direction
          final transform = _createTransformMatrix(
            widget.direction,
            currentBevelHeight,
            widget.bevelHeight,
          );

          // Get offset for content movement (moves toward raised side when pressed)
          final contentOffset = _getContentOffset(
            widget.direction,
            currentBevelHeight,
          );

          return CustomPaint(
            painter: currentBevelHeight > 0
                ? _BevelBackgroundPainter(
                    direction: widget.direction,
                    bevelHeight: currentBevelHeight,
                    color: widget.bevelColor,
                    gradient: widget.bevelGradient,
                  )
                : null,
            child: ClipPath(
              clipper: _BevelClipper(
                direction: widget.direction,
                bevelHeight: currentBevelHeight,
              ),
              child: Transform.translate(
                offset: contentOffset,
                child: Transform(
                  transform: transform,
                  alignment: _getTransformAlignment(widget.direction),
                  child: widget.child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Creates a perspective/skew transform based on bevel direction
  Matrix4 _createTransformMatrix(
    BevelDirection direction,
    double currentBevelHeight,
    double maxBevelHeight,
  ) {
    if (currentBevelHeight == 0) return Matrix4.identity();

    final skewFactor = currentBevelHeight / maxBevelHeight * 0.002;

    switch (direction) {
      case BevelDirection.top:
        // Perspective: top closer, bottom further
        return Matrix4.identity()..setEntry(3, 1, skewFactor);
      case BevelDirection.bottom:
        // Perspective: bottom closer, top further
        return Matrix4.identity()..setEntry(3, 1, -skewFactor);
      case BevelDirection.left:
        // Perspective: left closer, right further
        return Matrix4.identity()..setEntry(3, 0, skewFactor);
      case BevelDirection.right:
        // Perspective: right closer, left further
        return Matrix4.identity()..setEntry(3, 0, -skewFactor);
    }
  }

  /// Gets the alignment point for transformation
  Alignment _getTransformAlignment(BevelDirection direction) {
    switch (direction) {
      case BevelDirection.top:
        return Alignment.bottomCenter;
      case BevelDirection.bottom:
        return Alignment.topCenter;
      case BevelDirection.left:
        return Alignment.centerRight;
      case BevelDirection.right:
        return Alignment.centerLeft;
    }
  }

  /// Gets the content offset based on bevel direction
  /// Content expands to fill full space when pressed (no offset)
  Offset _getContentOffset(
    BevelDirection direction,
    double currentBevelHeight,
  ) {
    // No offset needed - content area is defined by clipper
    return Offset.zero;
  }
}

/// Custom clipper that creates the trapezoid shape.
class _BevelClipper extends CustomClipper<Path> {
  final BevelDirection direction;
  final double bevelHeight;

  _BevelClipper({
    required this.direction,
    required this.bevelHeight,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final bh = bevelHeight;

    switch (direction) {
      case BevelDirection.top:
        // Top is wider (raised), bottom is narrower
        // Content area: wide at top, narrow at bottom
        path.moveTo(0, bh);           // top left at y=bh
        path.lineTo(w, bh);           // top right at y=bh
        path.lineTo(w - bh, h);       // bottom right (narrower)
        path.lineTo(bh, h);           // bottom left (narrower)
        path.close();
        break;

      case BevelDirection.bottom:
        // Bottom is raised, top is narrower
        // Content area: wide at top, narrow at bottom
        path.moveTo(0, 0);            // top left (full width)
        path.lineTo(w, 0);            // top right (full width)
        path.lineTo(w - bh, h - bh);  // bottom right (narrower)
        path.lineTo(bh, h - bh);      // bottom left (narrower)
        path.close();
        break;

      case BevelDirection.left:
        // Left is taller (raised), right is shorter
        // Content area: tall on left, short on right
        path.moveTo(bh, 0);           // top left at x=bh
        path.lineTo(w, bh);           // top right (shorter)
        path.lineTo(w, h - bh);       // bottom right (shorter)
        path.lineTo(bh, h);           // bottom left at x=bh
        path.close();
        break;

      case BevelDirection.right:
        // Right is taller (raised), left is shorter
        // Content area: short on left, tall on right
        path.moveTo(0, bh);           // top left (shorter)
        path.lineTo(w - bh, 0);       // top right at x=w-bh
        path.lineTo(w - bh, h);       // bottom right at x=w-bh
        path.lineTo(0, h - bh);       // bottom left (shorter)
        path.close();
        break;
    }

    return path;
  }

  @override
  bool shouldReclip(_BevelClipper oldClipper) {
    return oldClipper.bevelHeight != bevelHeight ||
        oldClipper.direction != direction;
  }
}

/// Custom painter that draws the beveled background (visible side of button).
class _BevelBackgroundPainter extends CustomPainter {
  final BevelDirection direction;
  final double bevelHeight;
  final Color color;
  final Gradient? gradient;

  _BevelBackgroundPainter({
    required this.direction,
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

    switch (direction) {
      case BevelDirection.top:
        // Top is raised (wider), bottom is narrower
        // Draw left diagonal side
        path.moveTo(0, bh);
        path.lineTo(bh, bh);
        path.lineTo(bh, h);
        path.lineTo(0, h);
        path.close();

        // Draw right diagonal side
        path.moveTo(w - bh, bh);
        path.lineTo(w, bh);
        path.lineTo(w, h);
        path.lineTo(w - bh, h);
        path.close();

        // Draw top edge (horizontal raised edge)
        path.moveTo(0, 0);
        path.lineTo(w, 0);
        path.lineTo(w, bh);
        path.lineTo(0, bh);
        path.close();
        break;

      case BevelDirection.bottom:
        // Bottom is raised, top is narrower
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
        break;

      case BevelDirection.left:
        // Left is raised (taller), right is shorter
        // Draw top diagonal side
        path.moveTo(0, 0);
        path.lineTo(w, bh);
        path.lineTo(w, bh);
        path.lineTo(bh, 0);
        path.close();

        // Draw bottom diagonal side
        path.moveTo(bh, h);
        path.lineTo(w, h - bh);
        path.lineTo(w, h);
        path.lineTo(0, h);
        path.close();

        // Draw left edge (vertical raised edge)
        path.moveTo(0, 0);
        path.lineTo(bh, 0);
        path.lineTo(bh, h);
        path.lineTo(0, h);
        path.close();
        break;

      case BevelDirection.right:
        // Right is raised (taller), left is shorter
        // Draw top diagonal side
        path.moveTo(0, bh);
        path.lineTo(w - bh, 0);
        path.lineTo(w, 0);
        path.lineTo(0, bh);
        path.close();

        // Draw bottom diagonal side
        path.moveTo(0, h - bh);
        path.lineTo(w, h);
        path.lineTo(w - bh, h);
        path.lineTo(0, h - bh);
        path.close();

        // Draw right edge (vertical raised edge)
        path.moveTo(w - bh, 0);
        path.lineTo(w, 0);
        path.lineTo(w, h);
        path.lineTo(w - bh, h);
        path.close();
        break;
    }

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
        oldDelegate.direction != direction ||
        oldDelegate.color != color ||
        oldDelegate.gradient != gradient;
  }
}
