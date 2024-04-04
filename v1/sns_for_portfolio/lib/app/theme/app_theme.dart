import 'package:flutter/material.dart';

import 'app_theme_data.dart';

class AppTheme extends InheritedWidget {
  const AppTheme({
    required Widget child,
    required this.lightTheme,
    // required this.darkTheme,
    Key? key,
  }) : super(
    key: key,
    child: child,
  );

  final AppThemeData lightTheme;
  // final RideusThemeData darkTheme;

  @override
  /// 상속하는 모든 위젯에 알림을 보내, Theme을 재구축. 변경사항을 반영한다.
  /// 기존 위젯의 어둡거나 밝은 테마가 변경될 테마와 다른 경우에만 단독으로 알려준다! - 불필요한 리빌드 방지
  bool updateShouldNotify(
      AppTheme oldWidget,
      ) => false;
  // oldWidget.lightTheme != lightTheme || oldWidget.darkTheme != darkTheme;

  static AppThemeData of(BuildContext context) {
    /// 위젯 트리에서 가장 가까운 위젯을 가져와 변수에 저장합니다.
    final AppTheme? inheritedTheme = context.dependOnInheritedWidgetOfExactType<AppTheme>();

    /// 해당 유형의 위젯이 위젯트리에 없으면 중단됩니다.
    assert(inheritedTheme != null, 'No AppTheme found in context');

    /// 현재 밝기를 저장합니다.
    // final currentBrightness = Theme.of(context).brightness;
    return inheritedTheme!.lightTheme;

    /// 현재 밝기에 따라, 밝거나 어두운 테마를 변환합니다.
    // return currentBrightness == Brightness.dark
    //     ? inheritedTheme!.darkTheme
    //     : inheritedTheme!.lightTheme;
  }
}

extension AppThemeExtension on BuildContext {
  AppThemeData get theme => AppTheme.of(this);
}