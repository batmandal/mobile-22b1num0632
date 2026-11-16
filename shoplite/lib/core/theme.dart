import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const seed = Colors.indigo;

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: brightness);
    return ThemeData(
      colorScheme: scheme,
      cardTheme: const CardThemeData(margin: EdgeInsets.zero),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scheme.surface,
      ),
    );
  }
}
