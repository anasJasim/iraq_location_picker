import 'package:flutter/material.dart';

/// App color scheme with a green theme
final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 0, 11, 1),
  brightness: Brightness.light,
);

/// Primary green color for consistency across the app
final primaryGreenColor = lightColorScheme.primary;

/// App theme configuration
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      );
}
