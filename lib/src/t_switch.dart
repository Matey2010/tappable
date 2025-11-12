import 'package:flutter/material.dart';
import 'tappable.dart';

typedef SwitchBuilder = Widget Function(BuildContext context, bool value);

@Deprecated(
  'TSwitch has been moved to the tappable_elements package as TeSwitch. '
  'Use TeSwitch from package:tappable_elements instead. '
  'This class will be removed in version 1.0.0.',
)
class TSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final SwitchBuilder? buildBackground;
  final SwitchBuilder? buildThumb;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? highlightColor;
  final Duration animationDuration;

  const TSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.buildBackground,
    this.buildThumb,
    this.width = 51.0,
    this.height = 31.0,
    this.borderRadius,
    this.splashColor,
    this.highlightColor,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            // Background
            Positioned.fill(
              child: buildBackground?.call(context, value) ??
                  _defaultBackground(context),
            ),
            // Thumb
            AnimatedPositioned(
              duration: animationDuration,
              curve: Curves.easeInOut,
              left: value ? width - height : 0,
              top: 0,
              bottom: 0,
              width: height,
              child: buildThumb?.call(context, value) ?? _defaultThumb(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultBackground(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      decoration: BoxDecoration(
        color: value ? Colors.blue : Colors.grey.shade300,
        borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
        border: Border.all(
          color: value ? Colors.blue : Colors.grey.shade400,
          width: 2,
        ),
      ),
    );
  }

  Widget _defaultThumb(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
