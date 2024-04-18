import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sns_for_portfolio/presentation/ui/component/paltform_widgets.dart';

typedef _FutureCallback<T> = Future<T> Function();

Future exceptionIndicatorDialog(BuildContext context, String content, _FutureCallback func) async {
  return await PlatformWidgets.dialog(context,
      barrierDismissible: false,
      content: Text(content),
      actions: [
        TextButton(
          child: Text("Try Again!"),
          onPressed: () async {
            context.pop();
            try {
              await func();
            } catch (e) {
              exceptionIndicatorDialog(context, content, func);
            }
          },
        )
      ]);
}

class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator({
    this.title,
    this.message,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final String? title;
  final String? message;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 48,
            ),
            const SizedBox(
              height: 48,
            ),
            Text(
              title ?? "Something went wrong",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              message ?? "There has been an error. Plese, check your internet connection and try again later.",
              textAlign: TextAlign.center,
            ),
            if (onTryAgain != null)
              const SizedBox(
                height: 64,
              ),
            if (onTryAgain != null)
              ExpandedElevatedButton(
                onTap: onTryAgain,
                icon: const Icon(
                  Icons.refresh,
                ),
                label: 'Try Again!',
              ),
          ],
        ),
      ),
    );
  }
}

class ExpandedElevatedButton extends StatelessWidget {
  static const double _elevatedButtonHeight = 48;

  const ExpandedElevatedButton({
    required this.label,
    this.onTap,
    this.icon,
    Key? key,
  }) : super(key: key);

  ExpandedElevatedButton.inProgress({
    required String label,
    Key? key,
  }) : this(
          label: label,
          icon: Transform.scale(
            scale: 0.5,
            child: const CircularProgressIndicator(),
          ),
          key: key,
        );

  final VoidCallback? onTap;
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    return SizedBox(
      height: _elevatedButtonHeight,
      width: double.infinity,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // theme.brandColor,
                shape: const StadiumBorder(),
              ),
              label: Text(
                label,
              ),
              icon: icon,
            )
          : ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, //theme.brandColor,
                shape: const StadiumBorder(),
              ),
              child: Text(
                label,
              ),
            ),
    );
  }
}
