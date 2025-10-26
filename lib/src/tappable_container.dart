import 'package:flutter/material.dart';
import 'tappable.dart';

class TappableContainer extends StatelessWidget {
  // Tappable parameters
  final VoidCallback? onTap;
  final Color? splashColor;
  final Color? highlightColor;
  final double? splashRadius;
  final InteractiveInkFeatureFactory? splashFactory;
  final bool fillParent;
  final EdgeInsetsGeometry? tappablePadding;

  // Container parameters
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Widget? child;
  final Clip clipBehavior;

  const TappableContainer({
    super.key,
    // Tappable parameters
    this.onTap,
    this.splashColor,
    this.highlightColor,
    this.splashRadius,
    this.splashFactory,
    this.fillParent = false,
    this.tappablePadding,
    // Container parameters
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    // Extract borderRadius from decoration if available
    BorderRadius? borderRadius;
    if (decoration is BoxDecoration) {
      final boxDecoration = decoration as BoxDecoration;
      if (boxDecoration.borderRadius is BorderRadius) {
        borderRadius = boxDecoration.borderRadius as BorderRadius;
      }
    }

    return Tappable(
      onTap: onTap,
      borderRadius: borderRadius,
      splashColor: splashColor,
      highlightColor: highlightColor,
      splashRadius: splashRadius,
      splashFactory: splashFactory,
      fillParent: fillParent,
      padding: tappablePadding,
      child: Container(
        alignment: alignment,
        padding: padding,
        color: color,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
        width: width,
        height: height,
        constraints: constraints,
        margin: margin,
        transform: transform,
        transformAlignment: transformAlignment,
        clipBehavior: clipBehavior,
        child: child,
      ),
    );
  }
}
