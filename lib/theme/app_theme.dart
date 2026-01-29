import 'package:flutter/material.dart';
import '../core/constants.dart';

/// Tema customizado do aplicativo CodeConnect
class AppTheme {
  AppTheme._();
  // Cores
  static const primaryColor = Color(0xFF00FF88);
  static const backgroundColor = Color(0xFF0A0F1E);
  static const surfaceColor = Color(0xFF0F1419);
  static const textPrimary = Colors.white;
  static const textSecondary = Colors.white70;

  // Alias para compatibilidade
  static const textColor = textPrimary;
  static const cardColor = surfaceColor;
  static const borderColor = Color(0xFF2A2F3A);

  // Text Styles
  static const titleLarge = TextStyle(
    color: primaryColor,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const titleLargeWhite = TextStyle(
    color: textPrimary,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const titleMedium = TextStyle(
    color: primaryColor,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const bodyLarge = TextStyle(
    color: textPrimary,
    fontSize: 18,
    height: 1.4,
  );

  static const bodyMedium = TextStyle(
    color: textSecondary,
    fontSize: 14,
    height: 1.6,
  );

  static const logoCode = TextStyle(
    color: primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );

  static const logoConnect = TextStyle(
    color: textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryColor,
      surface: surfaceColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: false,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: primaryColor,
          width: UiConstants.borderWidthDefault,
        ),
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiConstants.borderRadiusSmall),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: UiConstants.paddingLarge,
          vertical: UiConstants.paddingSmall,
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
