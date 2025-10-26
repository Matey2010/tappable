import 'package:flutter/material.dart';
import 'tappable.dart';

typedef CheckboxBuilder = Widget Function(BuildContext context, bool value);

class TCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final CheckboxBuilder? buildBackground;
  final CheckboxBuilder? buildThumb;
  final double size;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? highlightColor;

  const TCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.buildBackground,
    this.buildThumb,
    this.size = 24.0,
    this.borderRadius,
    this.splashColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: borderRadius ?? BorderRadius.circular(4),
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            // Background
            Positioned.fill(
              child: buildBackground?.call(context, value) ??
                  _defaultBackground(context),
            ),
            // Thumb/Checkmark
            if (value)
              Positioned.fill(
                child: buildThumb?.call(context, value) ??
                    _defaultThumb(context),
              ),
          ],
        ),
      ),
    );
  }

  Widget _defaultBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: value ? Colors.blue : Colors.transparent,
        border: Border.all(
          color: value ? Colors.blue : Colors.grey,
          width: 2,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(4),
      ),
    );
  }

  Widget _defaultThumb(BuildContext context) {
    return Icon(
      Icons.check,
      size: size * 0.7,
      color: Colors.white,
    );
  }
}
