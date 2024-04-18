
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void showSnackBar(BuildContext context, Widget content, {Duration? duration, bool? showCloseIcon}) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: content,
        duration: duration ?? const Duration(seconds: 2),
        showCloseIcon: showCloseIcon,
        closeIconColor: Colors.white,
      ));
  });
}