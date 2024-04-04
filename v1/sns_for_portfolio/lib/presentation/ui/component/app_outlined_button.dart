import 'package:flutter/material.dart';
import 'package:sns_for_portfolio/app/theme/app_theme.dart';

class AppOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const AppOutlinedButton({Key? key, this.onPressed, this.padding, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // shape: const StadiumBorder(),
        side: const BorderSide(width: 1, color: Colors.grey),
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
