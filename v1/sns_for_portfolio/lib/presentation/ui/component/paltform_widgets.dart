import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PlatformWidgets {
  static Future<dynamic> dialog(
    BuildContext context, {
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    bool? onlyAndroid,
    // bool returnByWidget = false,
    bool barrierDismissible = true,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (ctx) {
          return (Platform.isIOS && onlyAndroid != true)
              ? CupertinoAlertDialog(
                  title: title,
                  content: content,
                  actions: actions ?? [],
                )
              : AlertDialog(
                  title: title,
                  content: content,
                  actions: actions,
                );
        });
  }

  static Widget platformIndicator() {
    if (Platform.isIOS)
      return CupertinoActivityIndicator();
    else
      return CircularProgressIndicator();
  }
}
