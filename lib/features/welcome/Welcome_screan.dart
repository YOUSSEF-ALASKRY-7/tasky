import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tasky/features/main/main_screan.dart';

import '../../core/services/preferences_manger.dart';
import '../../core/widgets/costumformfiled.dart';

class WelcomeScrean extends StatefulWidget {
  const WelcomeScrean({super.key});

  @override
  State<WelcomeScrean> createState() => _WelcomeScreanState();
}

class _WelcomeScreanState extends State<WelcomeScrean> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/logo.svg", width: 42, height: 42),
                    const SizedBox(width: 16),
                    Text(
                      "Tasky",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 108),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      "Welcome To Tasky ",
                      style: Theme.of(context).textTheme.displaySmall
                    ),
                    SvgPicture.asset(
                      "assets/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg",
                      width: 28,
                      height: 28,
                    ),
                  ],
                ),
                 Text(
                  "Your productivity journey starts here.",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16)
                ),
                const SizedBox(height: 24),
                SvgPicture.asset("assets/pana.svg", width: 215, height: 205),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                       Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Full Name",
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16)
                        ),
                      ),
                      const SizedBox(height: 3),
                      Costumformfiled(
                        controller1: controller,
                        hintText: "e.g. Sarah Khalid",
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your Full Name";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {

                          await PreferencesManger().setString("name", controller.text.trim());

                          if (!context.mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => main_screan(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        "Let’s Get Started",

                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}