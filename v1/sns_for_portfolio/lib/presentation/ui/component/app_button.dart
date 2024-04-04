import 'package:flutter/material.dart';
import 'package:sns_for_portfolio/app/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const AppButton({Key? key, this.onPressed, this.padding, required this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: theme.buttonDefaultPaddingVertical,
              horizontal: theme.buttonDefaultPaddingHorizontalSmall,
            ),
        child: child,
      ),
    );
  }
}
