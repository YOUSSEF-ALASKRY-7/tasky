import 'dart:convert';

import 'package:flutter/material.dart';

import '../core/services/preferences_manger.dart';
import '../core/widgets/costumformfiled.dart';
import '../models/task_model.dart';
import '../widgets/task_lest_widgets.dart';

class CompletedScrean extends StatefulWidget {
  const CompletedScrean({super.key});

  @override
  State<CompletedScrean> createState() => _CompletedScreanState();
}

class _CompletedScreanState extends State<CompletedScrean> {
  int iscjecked = 0;
  List<TaskModel> todo_tasks = [];
  List<TaskModel> task = [];

  void To_Do(List<TaskModel> tasklist) {
    todo_tasks.clear();
    for (int i = 0; i < tasklist.length; i++) {
      if (tasklist[i].isChecked == true) {
        todo_tasks.add(tasklist[i]);
      }
    }
  }

  Future<void> saveTasks() async {
    final taskslist = task.map((t) => t.convert_to_map()).toList();
    await PreferencesManger().setString("tasks", jsonEncode(taskslist));
  }

  // تحميل الـ Tasks
  Future<void> loedTask() async {
    final tasks = PreferencesManger().getString("tasks");

    if (tasks != null) {
      final taskafterdecode = jsonDecode(tasks) as List<dynamic>;
      final tasklist = taskafterdecode.map((element) {
        return TaskModel.fromjson(element);
      }).toList();

      if (!mounted) return;

      setState(() {
        task = tasklist;
        To_Do(task);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
      body: SafeArea(
        child: todo_tasks.isEmpty
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Completed Tasks",
                    style: TextStyle(color: Color(0xffA0A0A0), fontSize: 16),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: TaskLestWidgets(
                  task: todo_tasks,
                  ontap: (TaskModel? changedTask, bool? value) {
                    setState(() {
                      changedTask!.isChecked = value ?? true;
                    });
                    saveTasks();
                    loedTask();
                  },
                  delete_task: (TaskModel? currentTask) {
                    setState(() {
                      task.remove(currentTask);
                    });
                    saveTasks();
                    loedTask();
                  },
                  edit_task: (TaskModel ?currentTask, BuildContext context) {
                    // الـ variables برا الـ builder عشان متتصفرش مع كل rebuild
                    TextEditingController controller1 = TextEditingController(text: currentTask!.TaskName);
                    TextEditingController controller2 = TextEditingController(text: currentTask!.TaskDesc);
                    GlobalKey<FormState> formKey = GlobalKey<FormState>();
                    bool highPriority = currentTask!.pero;

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // عشان الكيبورد والـ sheet ياخدوا الحجم الصح
                      builder: (sheetContext) {
                        // StatefulBuilder بيخلي الـ setState تعمل rebuild للـ sheet نفسه
                        return StatefulBuilder(
                          builder: (context, setSheetState) {
                            return Padding(
                              // بيرفع الـ sheet فوق الكيبورد
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                              ),
                              child: Form(
                                key: formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min, // ياخد حجم المحتوى بس
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Task Name",
                                          style: Theme.of(context).textTheme.titleSmall,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Costumformfiled(
                                        controller1: controller1,
                                        hintText: "Finish UI design for login screen",
                                        validator: (String? value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return "Please Enter the title ";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Task Description",
                                          style: Theme.of(context).textTheme.titleSmall,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Costumformfiled(
                                        controller1: controller2,
                                        hintText:
                                        "Finish onboarding UI and hand off to devs by Thursday.",
                                        maxLines: 5,
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "High Priority",
                                            style: Theme.of(context).textTheme.titleSmall,
                                          ),
                                          Switch(
                                            value: highPriority,
                                            onChanged: (value) {
                                              setSheetState(() {
                                                highPriority = value;
                                              });
                                            },
                                            activeTrackColor: const Color(0xff15B86C),
                                            activeThumbColor: Colors.white,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          if (formKey.currentState?.validate() ?? false) {
                                            setState(() {
                                              currentTask.TaskName = controller1.text;
                                              currentTask.TaskDesc = controller2.text;
                                              currentTask.pero = highPriority;
                                            });
                                            saveTasks();
                                            Navigator.pop(sheetContext);
                                          }
                                        },
                                        icon: const Icon(Icons.edit),
                                        label: const Text(
                                          "Edit Task",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(MediaQuery.of(context).size.width, 40),
                                          foregroundColor: Colors.white,
                                          backgroundColor: const Color(0xff15B86C),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
