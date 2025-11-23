import 'package:flutter/material.dart';
import 'tappable.dart';
import 'tap_mechanics/tap_mechanic.dart';

class TappableContainer extends StatelessWidget {
  // Tappable parameters
  final VoidCallback? onTap;

  /// The tap mechanics to apply to this container.
  ///
  /// See [Tappable.tapMechanics] for more details.
  final List<TapMechanic>? tapMechanics;

  /// @deprecated Use [RippleTapMechanic] in [tapMechanics] instead.
  @Deprecated('Use RippleTapMechanic in tapMechanics instead')
  final Color? splashColor;

  /// @deprecated Use [RippleTapMechanic] in [tapMechanics] instead.
  @Deprecated('Use RippleTapMechanic in tapMechanics instead')
  final Color? highlightColor;

  /// @deprecated Use [RippleTapMechanic] in [tapMechanics] instead.
  @Deprecated('Use RippleTapMechanic in tapMechanics instead')
  final double? splashRadius;

  /// @deprecated Use [RippleTapMechanic] in [tapMechanics] instead.
  @Deprecated('Use RippleTapMechanic in tapMechanics instead')
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
    this.tapMechanics,
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
      tapMechanics: tapMechanics,
      // ignore: deprecated_member_use_from_same_package
      splashColor: splashColor,
      // ignore: deprecated_member_use_from_same_package
      highlightColor: highlightColor,
      // ignore: deprecated_member_use_from_same_package
      splashRadius: splashRadius,
      // ignore: deprecated_member_use_from_same_package
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
