import 'package:flutter/material.dart';

get lightTheme {
  // Color primary = const Color(0xFF9747FF);
  ThemeData lightTheme = ThemeData(
      // bottomNavigationBarTheme:
      //     const BottomNavigationBarThemeData(backgroundColor: Colors.red),
      primaryColor: const Color(0xFF6750A4),
      appBarTheme: const AppBarTheme(
          // backgroundColor: Color(0xFFE8DEF8),
          ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      dropdownMenuTheme: const DropdownMenuThemeData(menuStyle: MenuStyle()));
  return lightTheme;
}

get darkTheme {
  var p = const Color(0xFF0d1117);
  ThemeData darkTheme = ThemeData(
    primaryColor: p,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFE8DEF8),
  );
  return darkTheme;
}
