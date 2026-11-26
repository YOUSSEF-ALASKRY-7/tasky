import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.black)),
  ),
  popupMenuTheme: PopupMenuThemeData(
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xffF6F7F9),
  ),
  splashFactory: NoSplash.splashFactory,
  colorScheme: ColorScheme.light(primaryContainer: Color(0xffFFFFFF)),
  brightness: Brightness.light,
  iconTheme: IconThemeData(color: Color(0xff3A4640)),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
  dividerTheme: DividerThemeData(color: Color(0xffD1DAD6)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    extendedTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    foregroundColor: Colors.white,
    backgroundColor: const Color(0xff15B86C),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.white),
      backgroundColor: WidgetStateProperty.all(Color(0xff15B86C)),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  ),
  switchTheme: SwitchThemeData(
    trackOutlineWidth: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return 0.0;
      } else {
        return 2.0;
      }
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Colors.transparent;
      } else {
        return Color(0xff9E9E9E);
      }
    }),
    thumbColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return Color(0xff9E9E9E);
      }
    }),
    trackColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      } else {
        return Colors.white;
      }
    }),
  ),
  appBarTheme: AppBarTheme(
    foregroundColor: Color(0xff161F1B),
    backgroundColor: Color(0xffF6F7F9),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
      fontSize: 20,
    ),
  ),
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  textTheme: TextTheme(
    displayMedium: TextStyle(
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 28,
    ),
    displayLarge: TextStyle(
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 32,
    ),
    displaySmall: TextStyle(
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 24,
    ),
    labelSmall: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    titleSmall: TextStyle(color: Color(0xff161F1B), fontSize: 16),
    titleMedium: TextStyle(color: Color(0xff3A4640), fontSize: 14),
    titleLarge: TextStyle(color: Color(0xff161F1B), fontSize: 20),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff6A6A6A),
      color: Color(0xff6A6A6A),
    ),
    bodyMedium: TextStyle(color: Color(0xff161F1B)),
    bodySmall: TextStyle(color: Color(0xff3A4640)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xffFFFFFF),
    focusColor: Color(0xffD1DAD6),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    hintStyle: const TextStyle(color: Color(0xff6D6D6D)),
  ),
  useMaterial3: true,
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xffD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
);
