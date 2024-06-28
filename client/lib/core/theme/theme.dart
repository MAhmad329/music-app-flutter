import 'package:flutter/material.dart';

import 'app_palette.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Palette.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: _border(
        Palette.gradient2,
      ),
      enabledBorder: _border(
        Palette.borderColor,
      ),
    ),
  );
}
