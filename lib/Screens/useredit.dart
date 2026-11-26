import 'package:flutter/material.dart';


import '../core/services/preferences_manger.dart';
import '../core/widgets/costumformfiled.dart';

class Useredit extends StatefulWidget {
  const Useredit({super.key});

  @override
  State<Useredit> createState() => _UsereditState();
}

class _UsereditState extends State<Useredit> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? name;



  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {

    if (!mounted) return;
    controller1.text = PreferencesManger().getString('name') ?? '';
    controller2.text = PreferencesManger().getString('quote') ?? '';
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "User Name",
                            style: Theme.of(context).textTheme.titleSmall
                        ),
                      ),
                      SizedBox(height: 8),
                      Costumformfiled(
                        controller1: controller1,
                        hintText: "Usama Elgendy",
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter the User Name ";
                          }
                          return null;
                        },
                      ),

                      SizedBox(width: 16, height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Motivation Quote",
                            style: Theme.of(context).textTheme.titleSmall
                        ),
                      ),
                      SizedBox(height: 8),
                      Costumformfiled(
                        controller1: controller2,
                        hintText: "One task at a time. One step closer.",
                        maxLines: 6,
                      ),

                      SizedBox(width: 16, height: 20),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {

                    await PreferencesManger().setString('name', controller1.text.trim());
                    await PreferencesManger().setString('quote', controller2.text.trim());

                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  }
                },
                icon: SizedBox(),
                label: Text(
                  "Save Changes",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(
                      Radius.circular(100),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
