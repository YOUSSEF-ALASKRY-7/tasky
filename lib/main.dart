import 'package:flutter/material.dart';

import 'package:tasky/features/home/Home_Screan.dart';
import 'package:tasky/features/welcome/Welcome_screan.dart';
import 'package:tasky/features/main/main_screan.dart';
import 'package:tasky/core/theme/light.dart';
import 'package:tasky/core/theme/theme_controler.dart';

import 'core/services/preferences_manger.dart';
import 'core/theme/theme.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManger().init();
  ThemeControler().init();
  String? name = PreferencesManger().getString("name");

  runApp(MyApp(username: name,));
}

class MyApp extends StatelessWidget {
  final String? username;

  const MyApp({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeControler.themenotifier,
        builder: (BuildContext context,ThemeMode  value, Widget? child) {
          return MaterialApp(
            theme:  lightTheme,
            darkTheme: darkTheme,
            themeMode: value,
            debugShowCheckedModeBanner: false,
            title: 'Tasky',
            home: username == null ? WelcomeScrean() : main_screan(),
          );
        }
    );
    }
}
