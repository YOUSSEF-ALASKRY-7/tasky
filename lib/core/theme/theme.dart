import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
  ),
  popupMenuTheme: PopupMenuThemeData(
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xff181818),
  ),
  splashFactory: NoSplash.splashFactory,
  colorScheme: ColorScheme.dark(primaryContainer: Color(0xff282828)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    extendedTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    foregroundColor: Colors.white,
    backgroundColor: const Color(0xff15B86C),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  ),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
  brightness: Brightness.dark,
  dividerTheme: DividerThemeData(color: Color(0xff6E6E6E)),
  iconTheme: IconThemeData(color: Color(0xffC6C6C6)),

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
    foregroundColor: Color(0xffFFFCFC),
    backgroundColor: Color(0xff181818),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
      fontSize: 20,
    ),
  ),
  scaffoldBackgroundColor: Color(0xff181818),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 24,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 28,
    ),
    displayLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 32,
    ),
    labelSmall: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: 16),
    titleSmall: TextStyle(color: Color(0xffFFFCFC), fontSize: 16),
    titleMedium: TextStyle(color: Color(0xffC6C6C6), fontSize: 14),
    titleLarge: TextStyle(color: Color(0xffFFFCFC), fontSize: 20),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xffA0A0A0),
      color: Color(0xffA0A0A0),
    ),
    bodyMedium: TextStyle(color: Color(0xffFFFCFC)),
    bodySmall: TextStyle(color: Color(0xffC6C6C6)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xff282828),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    hintStyle: const TextStyle(color: Color(0xff6D6D6D)),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xff6E6E6E), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  useMaterial3: true,
);
