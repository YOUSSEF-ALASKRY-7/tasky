import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/costumformfiled.dart';

import 'package:tasky/models/task_model.dart';

import '../../core/services/preferences_manger.dart';

class AddText extends StatefulWidget {
  const AddText({super.key});

  @override
  State<AddText> createState() => _AddTextState();
}

class _AddTextState extends State<AddText> {
  bool HighPriority = true;
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          title: Text(
            "New Task",

          ),
        ),


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
                            "Task Name",
                              style: Theme.of(context).textTheme.titleSmall
                          ),
                        ),
                        SizedBox(height: 8),
                        Costumformfiled(controller1: controller1, hintText: "Finish UI design for login screen",validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter the title ";
                          }
                          return null;
                        }),

                        SizedBox(width: 16, height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Task Description",
                              style: Theme.of(context).textTheme.titleSmall
                          ),
                        ),
                        SizedBox(height: 8),
                        Costumformfiled(controller1: controller2, hintText: "Finish onboarding UI and hand off to devs by Thursday.",maxLines: 5,),

                        SizedBox(width: 16, height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "High Priority",
                                style: Theme.of(context).textTheme.titleSmall
                            ),
                            Switch(
                              value: HighPriority,
                              onChanged: (value) {
                                setState(() {
                                  HighPriority = value;
                                });
                              },
                              activeTrackColor: Color(0xff15B86C),
                              activeThumbColor: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      TaskModel model = TaskModel(
                        TaskName: controller1.text,
                        TaskDesc: controller2.text,
                        pero: HighPriority,
                      );

                      final taskjson = PreferencesManger().getString("tasks");
                      List<dynamic> taskslist = [];
                      if (taskjson != null) {
                        taskslist = jsonDecode(taskjson);
                      }
                      taskslist.add(model.convert_to_map());
                      final taskencode = jsonEncode(taskslist);
                      await PreferencesManger().setString("tasks", taskencode);

                      if (context.mounted) {
                        Navigator.pop(context, true);
                      }
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    "Add Task",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff15B86C),
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
      ),
    );
  }
}
