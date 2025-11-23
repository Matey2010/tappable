import 'package:flutter/material.dart';
import 'tap_mechanics/tap_mechanic.dart';
import 'tap_mechanics/ripple_tap_mechanic.dart';

class Tappable extends StatelessWidget {
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Widget? child;

  /// The tap mechanics to apply to this widget.
  ///
  /// Tap mechanics define the visual feedback when the widget is tapped.
  /// Multiple mechanics can be combined and will be applied in order
  /// (the first mechanic wraps the child, the second wraps the first, etc.).
  ///
  /// If null, defaults to [RippleTapMechanic] for backward compatibility.
  ///
  /// Example:
  /// ```dart
  /// // Single mechanic
  /// Tappable(
  ///   onTap: () {},
  ///   tapMechanics: [ScaleTapMechanic()],
  ///   child: Text('Scale on tap'),
  /// )
  ///
  /// // Combined mechanics
  /// Tappable(
  ///   onTap: () {},
  ///   tapMechanics: [
  ///     RippleTapMechanic(splashColor: Colors.blue),
  ///     ScaleTapMechanic(scaleFactor: 0.95),
  ///   ],
  ///   child: Text('Ripple + Scale'),
  /// )
  /// ```
  final List<TapMechanic>? tapMechanics;

  /// @deprecated Use [RippleTapMechanic] in [tapMechanics] instead.
  ///
  /// Example:
  /// ```dart
  /// // Old way (deprecated):
  /// Tappable(
  ///   onTap: () {},
  ///   splashColor: Colors.blue,
  ///   child: Text('Tap me'),
  /// )
  ///
  /// // New way:
  /// Tappable(
  ///   onTap: () {},
  ///   tapMechanics: [
  ///     RippleTapMechanic(splashColor: Colors.blue),
  ///   ],
  ///   child: Text('Tap me'),
  /// )
  /// ```
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
  final EdgeInsetsGeometry? padding;

  const Tappable({
    super.key,
    this.onTap,
    this.borderRadius,
    this.child,
    this.tapMechanics,
    this.splashColor,
    this.highlightColor,
    this.splashRadius,
    this.splashFactory,
    this.fillParent = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = child ?? Container();

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    if (fillParent) {
      content = SizedBox.expand(child: content);
    }

    // If onTap is null, return just the content without interactive effects
    if (onTap == null) {
      return content;
    }

    // Determine which tap mechanics to use
    List<TapMechanic> effectiveMechanics = _getEffectiveMechanics();

    // Apply tap mechanics in order (first mechanic wraps child, second wraps first, etc.)
    Widget result = content;
    for (final mechanic in effectiveMechanics) {
      result = mechanic.build(
        context: context,
        onTap: onTap,
        child: result,
        borderRadius: borderRadius,
      );
    }

    return result;
  }

  /// Determines which tap mechanics to use, with backward compatibility.
  List<TapMechanic> _getEffectiveMechanics() {
    // If tapMechanics is explicitly provided, use it
    if (tapMechanics != null) {
      return tapMechanics!;
    }

    // For backward compatibility: if deprecated parameters are used, create RippleTapMechanic
    // ignore: deprecated_member_use_from_same_package
    if (splashColor != null ||
        // ignore: deprecated_member_use_from_same_package
        highlightColor != null ||
        // ignore: deprecated_member_use_from_same_package
        splashRadius != null ||
        // ignore: deprecated_member_use_from_same_package
        splashFactory != null) {
      return [
        RippleTapMechanic(
          // ignore: deprecated_member_use_from_same_package
          splashColor: splashColor,
          // ignore: deprecated_member_use_from_same_package
          highlightColor: highlightColor,
          // ignore: deprecated_member_use_from_same_package
          splashRadius: splashRadius,
          // ignore: deprecated_member_use_from_same_package
          splashFactory: splashFactory,
        ),
      ];
    }

    // Default to RippleTapMechanic for backward compatibility
    return [RippleTapMechanic()];
  }
}
