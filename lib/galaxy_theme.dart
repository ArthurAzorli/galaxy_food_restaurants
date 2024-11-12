import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class GalaxyFoodTheme {

  static FluentThemeData get normal {
    return FluentThemeData(
      brightness: Brightness.dark,
      activeColor: const Color(0xfff10404),
      inactiveColor: const Color(0xff9e1414),
      acrylicBackgroundColor: const Color(0xca000000),
      micaBackgroundColor: const Color(0x67040404),
      scaffoldBackgroundColor: const Color(0xff202020),
      inactiveBackgroundColor: const Color(0xff2c2c2c),
      cardColor: const Color(0xff353535),
      fontFamily: 'Montserrat',
    );
  }

  static TextTheme get text {
    return const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xff000000),
        fontSize: 57,
        fontWeight: FontWeight.w600,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xff000000),
        fontSize: 45,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xffffffff),
        fontSize: 36,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xffffffff),
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xffffffff),
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xffffffff),
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 22,
          fontWeight: FontWeight.w600
      ),
      titleMedium: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 16,
          fontWeight: FontWeight.w600
      ),
      titleSmall: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 14,
          fontWeight: FontWeight.w600
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xffffffff),
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xffffffff),
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xffffffff),
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xffffffff),
        fontSize: 14,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xffafafaf),
        fontSize: 12,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Montserrat',
        color: Color(0xffcccccc),
        fontSize: 11,
      ),
    );
  }
}