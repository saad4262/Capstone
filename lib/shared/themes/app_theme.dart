import 'package:capstone/shared/themes/color_scheme.dart';
import 'package:capstone/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColorScheme.lightColorScheme,
    textTheme: AppTextTheme.textTheme,
    scaffoldBackgroundColor: AppColorScheme.lightColorScheme.surface,
    appBarTheme: const AppBarTheme(elevation: 0),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: AppColorScheme.darkColorScheme,
    textTheme: AppTextTheme.textTheme,
    scaffoldBackgroundColor: AppColorScheme.darkColorScheme.surface,
    appBarTheme: const AppBarTheme(elevation: 0),
    useMaterial3: true,
  );
}
