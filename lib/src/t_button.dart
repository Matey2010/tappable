import 'package:flutter/material.dart';
import 'tappable_container.dart';

@Deprecated(
  'TButton has been moved to the tappable_elements package as TeButton. '
  'Use TeButton from package:tappable_elements instead. '
  'This class will be removed in version 1.0.0.',
)
class TButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPressed;

  // TappableContainer parameters
  final Color? splashColor;
  final Color? highlightColor;
  final double? splashRadius;
  final InteractiveInkFeatureFactory? splashFactory;
  final bool fillParent;
  final EdgeInsetsGeometry? tappablePadding;

  // Container styling parameters
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;

  // Disabled state parameters
  final Color? disabledBackgroundColor;
  final Decoration? disabledDecoration;
  final double disabledOpacity;

  const TButton({
    super.key,
    this.child,
    this.onPressed,
    // TappableContainer parameters
    this.splashColor,
    this.highlightColor,
    this.splashRadius,
    this.splashFactory,
    this.fillParent = false,
    this.tappablePadding,
    // Container styling parameters
    this.alignment,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.backgroundColor,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    // Disabled state parameters
    this.disabledBackgroundColor,
    this.disabledDecoration,
    this.disabledOpacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    Decoration? effectiveDecoration = decoration;
    Color? effectiveBackgroundColor = backgroundColor;

    if (!isEnabled) {
      if (disabledDecoration != null) {
        effectiveDecoration = disabledDecoration;
      }
      if (disabledBackgroundColor != null) {
        effectiveBackgroundColor = disabledBackgroundColor;
      }
    }

    Widget buttonWidget = TappableContainer(
      onTap: onPressed,
      splashColor: splashColor,
      highlightColor: highlightColor,
      splashRadius: splashRadius,
      splashFactory: splashFactory,
      fillParent: fillParent,
      tappablePadding: tappablePadding,
      alignment: alignment,
      padding: padding,
      color: effectiveBackgroundColor,
      decoration: effectiveDecoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      child: child,
    );

    if (!isEnabled && disabledOpacity < 1.0) {
      buttonWidget = Opacity(
        opacity: disabledOpacity,
        child: buttonWidget,
      );
    }

    return buttonWidget;
  }
}
