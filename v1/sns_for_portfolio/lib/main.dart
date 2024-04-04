import 'package:flutter/material.dart';
import 'package:sns_for_portfolio/app/router/router.dart';
import 'package:sns_for_portfolio/app/theme/app_theme.dart';
import 'package:sns_for_portfolio/app/theme/app_theme_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _lightTheme = LightThemeData();

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      lightTheme: _lightTheme,
      child: MaterialApp.router(
        theme: _lightTheme.materialThemeData,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
