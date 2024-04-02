import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sns_for_portfolio/app/util/extension.dart';

import 'constant.dart';

enum LogLevel {
  v, // explain: many logs
  d, // explain: connection, data logs
  i, // explain: class lifecycle, method call
  w, // explain: except case but not error
  e, // explain: runtime error / exception
}

class Log {
  static void log(String text, String prefix) {
    if (!kReleaseMode) {
      try {
        if (Platform.isAndroid) {
          // explain: android log length limit - sub text
          final pattern = RegExp('.{1,800}');
          pattern
              .allMatches(text)
              .forEach((match) => print(prefix + match.group(0)!));

          // print(prefix + text);
        } else if (Platform.isIOS) {
          print(prefix + text);
        }
      } catch (error) {}
    }
  }

  static void v(String? text) {
    switch (Const.logLevel) {
      case LogLevel.v:
        log("$text", "devlog_v >> ");
        break;
      case LogLevel.d:
      case LogLevel.i:
      case LogLevel.w:
      case LogLevel.e:
        break;
    }
  }

  static void d(String text) {
    switch (Const.logLevel) {
      case LogLevel.v:
      case LogLevel.d:
        log("$text", "devlog_d >> ");
        break;
      case LogLevel.i:
      case LogLevel.w:
      case LogLevel.e:
        break;
    }
  }

  static void i(String text) {
    switch (Const.logLevel) {
      case LogLevel.v:
      case LogLevel.d:
      case LogLevel.i:
        if (!text.isNullOrEmpty) {
          log("$text", "devlog_i >> ");

          /// 파이어베이스 크래시리틱스 오류보고 로그 write.
          // FirebaseCrashlytics.instance.log(text);
        }
        break;
      case LogLevel.w:
      case LogLevel.e:
        break;
    }
  }

  static void w(String text) {
    switch (Const.logLevel) {
      case LogLevel.v:
      case LogLevel.d:
      case LogLevel.i:
      case LogLevel.w:
        if (!text.isNullOrEmpty) {
          log("$text", "devlog_w >> ");
        }
        var exception = OtherException("$text");
        var stack = StackTrace.current;

        log("${exception.toString()}", "devlog_w >> ");
        log("${stack.toString()}", "devlog_w >> ");
        break;
      case LogLevel.e:
        break;
    }
  }

  static void e(exception, StackTrace stack, {String? text}) async {
    switch (Const.logLevel) {
      case LogLevel.v:
      case LogLevel.d:
      case LogLevel.i:
      case LogLevel.w:
      case LogLevel.e:
        if (!text.isNullOrEmpty) {
          log("$text", "devlog_e >> ");
        }
        log("${exception.toString()}", "devlog_e >> ");
        log("${stack.toString()}", "devlog_e >> ");

        // if (text != null) await FirebaseCrashlytics.instance.log(text);
        // await FirebaseCrashlytics.instance.log(exception.toString());
        // await FirebaseCrashlytics.instance.log(stack.toString());
        // await FirebaseCrashlytics.instance.recordError(exception, stack, fatal: false);
        // await FirebaseCrashlytics.instance.sendUnsentReports();
        // break;
    }
  }
}

class OtherException implements Exception {
  String cause;

  OtherException(this.cause);

  @override
  String toString() {
    return cause;
  }
}
