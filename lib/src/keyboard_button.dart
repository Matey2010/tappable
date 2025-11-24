import 'package:flutter/material.dart';

/// Perspective angle for the keyboard button
enum KeyboardButtonPerspective {
  /// View from the left - shows top, left, and bottom bevels
  left,

  /// View from the center - shows all bevels
  center,

  /// View from the right - shows top, right, and bottom bevels
  right,
}

/// A button that resembles a mechanical keyboard key with isometric 3D perspective.
///
/// This widget creates a realistic keyboard key appearance with:
/// - Isometric perspective (~70 degrees)
/// - Physical bevels on visible edges
/// - Rounded corners throughout
/// - Smooth press animation on tap
///
/// Example:
/// ```dart
/// TKeyboardButton(
///   onPressed: () => print('Key pressed!'),
///   width: 100,
///   height: 100,
///   topColor: Colors.grey.shade200,
///   bevelColor: Colors.grey.shade400,
///   perspective: KeyboardButtonPerspective.center,
///   child: Text('A', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
/// )
/// ```
class TKeyboardButton extends StatefulWidget {
  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  /// The child widget to display on the button face.
  final Widget? child;

  /// Width of the button face (before perspective).
  final double width;

  /// Height of the button face (before perspective).
  final double height;

  /// Color of the top face of the button.
  final Color topColor;

  /// Color of the beveled edges.
  final Color bevelColor;

  /// How deep the button appears in 3D space (affects bevel thickness).
  final double depth;

  /// How far the button depresses when pressed.
  final double pressDepth;

  /// Duration of the press animation.
  final Duration animationDuration;

  /// Animation curve for the press.
  final Curve curve;

  /// Border radius for rounded corners.
  final double borderRadius;

  /// Perspective angle - which bevels are visible
  final KeyboardButtonPerspective perspective;

  const TKeyboardButton({
    super.key,
    this.onPressed,
    this.child,
    this.width = 80,
    this.height = 80,
    this.topColor = const Color(0xFFE0E0E0),
    this.bevelColor = const Color(0xFF9E9E9E),
    this.depth = 12.0,
    this.pressDepth = 8.0,
    this.animationDuration = const Duration(milliseconds: 150),
    this.curve = Curves.easeInOut,
    this.borderRadius = 8.0,
    this.perspective = KeyboardButtonPerspective.center,
  });

  @override
  State<TKeyboardButton> createState() => _TKeyboardButtonState();
}

class _TKeyboardButtonState extends State<TKeyboardButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      _controller.reverse();
      widget.onPressed!();
    }
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate maximum height for layout (button at rest position)
    final maxHeight = widget.height + widget.depth * 0.5 + widget.pressDepth * 0.5;

    return SizedBox(
      width: widget.width,
      height: maxHeight,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final pressOffset = widget.pressDepth * _animation.value;
            final currentDepth = widget.depth - pressOffset;

            return Transform.translate(
              offset: Offset(0, pressOffset * 0.5), // Move button down when pressed
              child: CustomPaint(
                painter: _KeyboardButtonPainter(
                  topColor: widget.onPressed == null
                      ? widget.topColor.withOpacity(0.5)
                      : widget.topColor,
                  bevelColor: widget.onPressed == null
                      ? widget.bevelColor.withOpacity(0.5)
                      : widget.bevelColor,
                  depth: currentDepth,
                  borderRadius: widget.borderRadius,
                  perspective: widget.perspective,
                ),
                child: Container(
                  width: widget.width,
                  height: widget.height + currentDepth * 0.5, // Adjust for perspective
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    top: currentDepth * 0.3, // Offset for top face in perspective
                  ),
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Custom painter that draws the isometric keyboard button.
class _KeyboardButtonPainter extends CustomPainter {
  final Color topColor;
  final Color bevelColor;
  final double depth;
  final double borderRadius;
  final KeyboardButtonPerspective perspective;

  _KeyboardButtonPainter({
    required this.topColor,
    required this.bevelColor,
    required this.depth,
    required this.borderRadius,
    required this.perspective,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Dimensions
    final w = size.width;
    final h = size.height - depth * 0.5;
    final d = depth;
    final topHeightOffset = d * 0.5;
    final r = borderRadius;

    // Bevel offset based on perspective
    final leftOffset = perspective == KeyboardButtonPerspective.right ? 0.0 : d * 0.3;
    final rightOffset = perspective == KeyboardButtonPerspective.left ? 0.0 : d * 0.3;
    final topOffset = d * 0.3;
    final bottomOffset = d * 0.3;

    // Draw one continuous bevel (all visible sides as one shape)
    final bevelPath = Path();

    // Start from top-left outer corner
    bevelPath.moveTo(r, topHeightOffset);

    // Top edge (outer)
    bevelPath.lineTo(w - r, topHeightOffset);
    bevelPath.arcToPoint(
      Offset(w, topHeightOffset + r),
      radius: Radius.circular(r),
      clockwise: true,
    );

    // Right edge (outer)
    bevelPath.lineTo(w, h + topHeightOffset - r);
    bevelPath.arcToPoint(
      Offset(w - r, h + topHeightOffset),
      radius: Radius.circular(r),
      clockwise: true,
    );

    // Bottom edge (outer)
    bevelPath.lineTo(r, h + topHeightOffset);
    bevelPath.arcToPoint(
      Offset(0, h + topHeightOffset - r),
      radius: Radius.circular(r),
      clockwise: true,
    );

    // Left edge (outer)
    bevelPath.lineTo(0, topHeightOffset + r);
    bevelPath.arcToPoint(
      Offset(r, topHeightOffset),
      radius: Radius.circular(r),
      clockwise: true,
    );

    // Now cut out the inner (top face) with rounded corners
    bevelPath.moveTo(leftOffset + r, topHeightOffset - topOffset);

    // Inner top edge
    bevelPath.lineTo(w - rightOffset - r, topHeightOffset - topOffset);
    bevelPath.arcToPoint(
      Offset(w - rightOffset, topHeightOffset - topOffset + r),
      radius: Radius.circular(r),
      clockwise: false,
    );

    // Inner right edge
    bevelPath.lineTo(w - rightOffset, h + topHeightOffset - bottomOffset - r);
    bevelPath.arcToPoint(
      Offset(w - rightOffset - r, h + topHeightOffset - bottomOffset),
      radius: Radius.circular(r),
      clockwise: false,
    );

    // Inner bottom edge
    bevelPath.lineTo(leftOffset + r, h + topHeightOffset - bottomOffset);
    bevelPath.arcToPoint(
      Offset(leftOffset, h + topHeightOffset - bottomOffset - r),
      radius: Radius.circular(r),
      clockwise: false,
    );

    // Inner left edge
    bevelPath.lineTo(leftOffset, topHeightOffset - topOffset + r);
    bevelPath.arcToPoint(
      Offset(leftOffset + r, topHeightOffset - topOffset),
      radius: Radius.circular(r),
      clockwise: false,
    );

    bevelPath.close();
    bevelPath.fillType = PathFillType.evenOdd;

    // Draw bevel as one continuous surface
    paint.color = bevelColor;
    canvas.drawPath(bevelPath, paint);

    // Draw top face (main button surface) with rounded corners
    final topFaceRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        leftOffset,
        topHeightOffset - d * 0.3,
        w - leftOffset - rightOffset,
        h,
      ),
      Radius.circular(r),
    );

    paint.color = topColor;
    canvas.drawRRect(topFaceRect, paint);

    // Add subtle shadow/depth to top face
    paint.color = Colors.black.withOpacity(0.15);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.0;
    canvas.drawRRect(topFaceRect, paint);
  }

  @override
  bool shouldRepaint(_KeyboardButtonPainter oldDelegate) {
    return oldDelegate.topColor != topColor ||
        oldDelegate.bevelColor != bevelColor ||
        oldDelegate.depth != depth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.perspective != perspective;
  }
}