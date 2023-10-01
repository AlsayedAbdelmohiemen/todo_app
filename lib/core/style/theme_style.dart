import 'package:flutter/material.dart';

class MyTheme {
  static ThemeMode themeMode = ThemeMode.light;
  static Color lightPrimary = const Color(0xFF5D9CEC);
  static Color darkPrimary = const Color(0xFF5D9CEC);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFDFECDB),
    primaryColor: const Color(0xFF5D9CEC),
    canvasColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF5D9CEC)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: Color(0xFF5D9CEC),
        size: 25,
      ),
      selectedItemColor: Color(0xFF5D9CEC),
      showSelectedLabels: true,
    ),
    textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 20,
          color: Color(0xFF5D9CEC),
        ),
        bodySmall: TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF060E1E),
    primaryColor: darkPrimary,
    canvasColor: const Color(0xFF141922),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF141922),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: Color(0xFF5D9CEC),
        size: 25,
      ),
      selectedItemColor: Color(0xFF5D9CEC),
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
        size: 26,
      ),
      showSelectedLabels: true,
    ),
    textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 20,
          color: Color(0xFF5D9CEC),
        ),
        bodySmall: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
  );
}
