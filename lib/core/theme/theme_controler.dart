import 'package:flutter/material.dart';

import '../services/preferences_manger.dart';

class ThemeControler {
  static ValueNotifier<ThemeMode> themenotifier = ValueNotifier(
    ThemeMode.light,
  );

  void init() {
    bool? darkmood = PreferencesManger().getBool("darkmood");
    themenotifier.value = darkmood! ? ThemeMode.dark : ThemeMode.light;
  }

  static toggle() async {
    if (themenotifier.value == ThemeMode.dark) {
      themenotifier.value = ThemeMode.light;
      await PreferencesManger().setBool("darkmood", false);
    } else {
      themenotifier.value = ThemeMode.dark;
      await PreferencesManger().setBool("darkmood", true);
    }
  }

  static bool isLight(){
    return ThemeControler.themenotifier == ThemeMode.light;
  }
}
