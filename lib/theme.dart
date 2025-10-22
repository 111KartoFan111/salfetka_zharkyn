// lib/theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // --- Основные цвета ---
  static const Color primary = Color(0xFF030213); // --primary
  static const Color primaryForeground = Color(0xFFFFFFFF); // --primary-foreground
  static const Color destructive = Color(0xFFD4183D); // --destructive
  static const Color background = Color(0xFFFFFFFF); // --background
  static const Color card = Color(0xFFFFFFFF); // --card

  // Цвета из градиента
  static const Color gradientPink = Color(0xFFFF7BA9);
  static const Color gradientPurple = Color(0xFF8E5BFF);

  // Цвета из Oklch (конвертированные)
  static const Color secondary = Color(0xFFF2F0F5); // --secondary
  static const Color mutedForeground = Color(0xFF717182); // --muted-foreground
  static const Color accent = Color(0xFFE9EBEF); // --accent
  
  static const Color purple50 = Color(0xFFFBF8FF); // --color-purple-50
  static const Color pink50 = Color(0xFFFEF7FA); // --color-pink-50

  // --- Градиенты ---
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientPink, gradientPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, pink50, purple50],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // --- Тема ---
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: background,
    fontFamily: 'Inter', // Убедись, что добавил этот шрифт в pubspec.yaml и папку assets
    brightness: Brightness.light,
    
    // Цветовая схема
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: primaryForeground,
      secondary: secondary,
      onSecondary: primary,
      error: destructive,
      onError: primaryForeground,
      background: background,
      onBackground: primary,
      surface: card,
      onSurface: primary,
    ),

    // Типографика (H1, H2 и т.д.)
    textTheme: const TextTheme(
      // H1
      displayLarge: TextStyle(
        fontSize: 30, // 2xl
        fontWeight: FontWeight.w500, // medium
      ),
      // H2
      displayMedium: TextStyle(
        fontSize: 24, // xl
        fontWeight: FontWeight.w500,
      ),
      // H3
      displaySmall: TextStyle(
        fontSize: 20, // lg
        fontWeight: FontWeight.w500,
      ),
      // H4
      headlineMedium: TextStyle(
        fontSize: 16, // base
        fontWeight: FontWeight.w500,
      ),
      // p
      bodyLarge: TextStyle(
        fontSize: 16, // base
        fontWeight: FontWeight.w400, // normal
      ),
      bodyMedium: TextStyle(
        fontSize: 14, // sm
        fontWeight: FontWeight.w400,
      ),
      // label
      labelLarge: TextStyle(
        fontSize: 16, // base
        fontWeight: FontWeight.w500,
      ),
    ),

    // Стили кнопок
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary, // --primary
        foregroundColor: primaryForeground, // --primary-foreground
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100), // rounded-full
        ),
        padding: const EdgeInsets.symmetric(vertical: 20), // h-14
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: BorderSide(color: Colors.grey[300]!), // border-gray-200
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // rounded-2xl
        ),
        padding: const EdgeInsets.symmetric(vertical: 20), // h-14
      ),
    ),

    // Стили полей ввода
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100], // bg-gray-100
      hintStyle: TextStyle(color: mutedForeground),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), // h-14, px-6
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100), // rounded-full
        borderSide: BorderSide.none, // border-0
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(color: gradientPurple, width: 2), // focus ring
      ),
    ),
  );
}
