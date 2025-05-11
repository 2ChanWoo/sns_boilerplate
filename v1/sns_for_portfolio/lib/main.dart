import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_for_portfolio/app/router/router.dart';
import 'package:sns_for_portfolio/app/theme/app_theme.dart';
import 'package:sns_for_portfolio/app/theme/app_theme_data.dart';
import 'package:sns_for_portfolio/data/repository_impl/auth_repository_impl.dart';
import 'package:sns_for_portfolio/data/repository_impl/quote_repository_impl.dart';
import 'package:sns_for_portfolio/domain/repository/auth_repository.dart';
import 'package:sns_for_portfolio/domain/repository/quote_repository.dart';
import 'package:sns_for_portfolio/domain/usecase/fetch_quote_list_page_usecase.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
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
