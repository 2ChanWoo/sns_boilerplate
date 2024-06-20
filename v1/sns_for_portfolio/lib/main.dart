import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sns_for_portfolio/app/router/router.dart';
import 'package:sns_for_portfolio/app/theme/app_theme.dart';
import 'package:sns_for_portfolio/app/theme/app_theme_data.dart';
import 'package:sns_for_portfolio/data/repository_impl/auth_repository_impl.dart';
import 'package:sns_for_portfolio/data/repository_impl/quote_repository_impl.dart';
import 'package:sns_for_portfolio/domain/repository/auth_repository.dart';
import 'package:sns_for_portfolio/domain/repository/quote_repository.dart';
import 'package:sns_for_portfolio/domain/usecase/fetch_quote_list_page_usecase.dart';
import 'package:sns_for_portfolio/presentation/bloc/quote_list/quote_list_bloc.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<QuoteServiceRepository>(
            create: (context) => QuoteServiceRepository_impl()),
        RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository_impl()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _lightTheme = LightThemeData();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuoteListBloc(FetchQuoteListPageUseCase(context.read()))),
      ],
      child: AppTheme(
        lightTheme: _lightTheme,
        child: MaterialApp.router(
          theme: _lightTheme.materialThemeData,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}
