import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/Screens/Home_Screan.dart';
import 'package:tasky/Screens/Profile.dart';
import 'package:tasky/Screens/Todo_screan.dart';

import '../core/theme/theme_controler.dart';
import 'Completed_screan.dart';

class main_screan extends StatefulWidget {
  const main_screan({super.key});

  @override
  State<main_screan> createState() => _main_screanState();
}

class _main_screanState extends State<main_screan> {
  final List<Widget> _screans = [
    HomeScrean(),
    TodoScrean(),
    CompletedScrean(),
    Profile(),
  ];

  int _current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        onTap: (int? i) {
          setState(() {
            _current_index = i ?? 0;
          });
        },
        currentIndex: _current_index,
        type: BottomNavigationBarType.fixed,

        unselectedItemColor: Theme.of(context).iconTheme.color!,
        selectedItemColor: Color(0xff15B86C),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/home_Icon.svg",
              colorFilter: ColorFilter.mode(
                _current_index == 0 ? Color(0xff15B86C) :Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/todo_icon.svg",
              colorFilter: ColorFilter.mode(
                _current_index == 1 ? Color(0xff15B86C) :Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
            label: "to do",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/compeleted_Icon.svg",
              colorFilter: ColorFilter.mode(
                _current_index == 2 ? Color(0xff15B86C) :Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
            label: "compeleted",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/profile_Icon.svg",
              colorFilter: ColorFilter.mode(
                _current_index == 3 ? Color(0xff15B86C) : Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
            label: "profile",
          ),
        ],
      ),

      body: _screans[_current_index],
    );
  }
}
