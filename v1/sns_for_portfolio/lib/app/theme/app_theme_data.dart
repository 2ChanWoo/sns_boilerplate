import 'package:flutter/material.dart';

const _dividerThemeData = DividerThemeData(space: 0, color: Colors.black);

abstract class AppThemeData {
  ThemeData get materialThemeData;

  Color get backgroundColor;

  Color get contentColor;

  Color get componentBackgroundColor;

  Color get componentContentColor;

  Color get defaultScaffoldBackgroundColor;

  Color get selectedBottomNavigationItemColor;

  Color get unselectedBottomNavigationItemColor;

  Color get dividerColor;

  Color get textFieldSuffixIconColorLightGrey;

  Color get quoteSvgColor;

  ///

  double get buttonDefaultPaddingVertical;

  double get buttonDefaultPaddingHorizontalSmall;

  double get buttonDefaultPaddingHorizontalMedium;

  double get buttonDefaultPaddingHorizontalLarge;

  TextStyle get textStyle;

  TextStyle quoteTextStyle = const TextStyle(
    fontFamily: 'Fondamento',
  );
}

class LightThemeData extends AppThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: defaultScaffoldBackgroundColor,
      primarySwatch: componentBackgroundColor.toMaterialColor(),
      appBarTheme: AppBarTheme(
        backgroundColor: componentBackgroundColor,
        foregroundColor: componentContentColor,
      ),
      dividerTheme: _dividerThemeData,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: selectedBottomNavigationItemColor,
        unselectedItemColor: unselectedBottomNavigationItemColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: componentBackgroundColor, width: 2.0),
        ),
      ),
      // buttonTheme: ButtonThemeData(
      //     textTheme: ButtonTextTheme.primary
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: componentBackgroundColor,
        foregroundColor: componentContentColor, /// button의 Text(child)가 아래 TextStyle이 아닌 foregroundColor를 따른다.
        textStyle: textStyle.copyWith(fontSize: 16),
      ))
      // expansionTileTheme: ExpansionTileThemeData(
      //
      // ),
      // textTheme: TextTheme(
      //    // titleMedium: TextStyle(fontSize: 14) // textFeild hintText, tile title
      // )
      );

  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get contentColor => Colors.black;

  @override
  Color get componentBackgroundColor => Colors.black;

  @override
  Color get componentContentColor => Colors.white;

  @override
  Color get unselectedBottomNavigationItemColor => Colors.grey;

  @override
  Color get dividerColor => Colors.grey;

  @override
  Color get textFieldSuffixIconColorLightGrey => const Color(0xFFDDDDDD);

  @override
  Color get defaultScaffoldBackgroundColor => backgroundColor;

  @override
  Color get selectedBottomNavigationItemColor => componentBackgroundColor;

  @override
  Color get quoteSvgColor => Colors.black;

  @override
  double get buttonDefaultPaddingVertical => 12;

  @override
  double get buttonDefaultPaddingHorizontalSmall => 10;

  @override
  double get buttonDefaultPaddingHorizontalMedium => 20;

  @override
  double get buttonDefaultPaddingHorizontalLarge => 30;

  @override
  TextStyle get textStyle => TextStyle(
        color: contentColor,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      );
}

extension on Color {
  Map<int, Color> _toSwatch() => {
        50: withOpacity(0.1),
        100: withOpacity(0.2),
        200: withOpacity(0.3),
        300: withOpacity(0.4),
        400: withOpacity(0.5),
        500: withOpacity(0.6),
        600: withOpacity(0.7),
        700: withOpacity(0.8),
        800: withOpacity(0.9),
        900: this,
      };

  MaterialColor toMaterialColor() => MaterialColor(
        value,
        _toSwatch(),
      );
}
