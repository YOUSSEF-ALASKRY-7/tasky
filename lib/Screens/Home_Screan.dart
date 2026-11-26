import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tasky/Screens/Add_text.dart';
import 'package:tasky/core/theme/theme_controler.dart';
import 'package:tasky/models/task_model.dart';

import '../core/enum/enumforactions.dart';
import '../core/services/preferences_manger.dart';
import '../core/widgets/costumformfiled.dart';
import '../core/widgets/coustemchickbox.dart';
import 'Achieved_Tasks.dart';
import 'High_per.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  String? name;
  String? qoute;
  int iscjecked = 0;
  String ?imagepath;
  List<TaskModel> task = [];
  List<TaskModel> high_task = [];

  // عدد الـ Tasks اللي خلصت
  int done_num() {
    int count = 0;
    for (int i = 0; i < task.length; i++) {
      if (task[i].isChecked == true) {
        count++;
      }
    }
    return count;
  }

  // بنمسح high_task الأول قبل ما نملاها تاني
  void High_per(List<TaskModel> task) {
    high_task.clear();
    for (int i = 0; i < task.length; i++) {
      if (task[i].pero == true) {
        high_task.add(task[i]);
      }
    }
  }

  // جلب اسم المستخدم
  Future<void> get_name() async {
    if (!mounted) return;
    setState(() {
      name = PreferencesManger().getString("name") ?? "gust";
      qoute =
          PreferencesManger().getString("quote") ??
          "One task at a time.One step closer.";
    });
    imagepath=PreferencesManger().getString("userImage");
  }

  // حفظ الـ Tasks
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
        iscjecked = done_num();
        High_per(task);
      });
    }
  }

  // بتغيّر حالة تاسك معين بالـ reference نفسه مش بالـ index
  void toggleTask(TaskModel changedTask, bool value) {
    setState(() {
      changedTask.isChecked = value;
      iscjecked = done_num();
    });
    saveTasks();
  }

  @override
  void initState() {
    super.initState();
    get_name();
    loedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // Floating Action Button
      // =========================
      floatingActionButton: SizedBox(
        width: 167,
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final added = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddText();
                },
              ),
            );

            if (added == true) {
              await loedTask();
            }
          },
          icon: const Icon(Icons.add),
          label: const Text("Add New Task"),
        ),
      ),

      // =========================
      // Body
      // =========================
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              // ==========================================
              // 1) الجزء العلوي كله
              // ==========================================
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---- Header ----
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                           CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: imagepath == null
                                ? AssetImage("assets/Thumbnail.png")
                                : FileImage(File(imagepath!)),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Evening ,${name ?? "gust"}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  qoute ??
                                      "One task at a time.One step closer.",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(34, 34),
                              padding: EdgeInsets.zero,
                              backgroundColor: const Color(0xff282828),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: const Icon(
                              Icons.sunny,
                              color: Color(0xffFFFCFC),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ---- Welcome Text ----
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Yuhuu ,Your work Is",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Row(
                            children: [
                              Text(
                                "almost done !",
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const SizedBox(width: 8),
                              SvgPicture.asset(
                                "assets/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg",
                                width: 28,
                                height: 28,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ---- Achieved Tasks ----
                    AchievedTasks(doneTask: iscjecked, totalTask: task.length),

                    const SizedBox(height: 8),

                    // ---- High Priority Tasks ----
                    Container(
                      // ارتفاع مبني على 4 عناصر ظاهرة كحد أقصى
                      height: high_task.isEmpty
                          ? 100
                          : (high_task.length > 4 ? 4 : high_task.length) * 47 +
                                40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "High Priority Tasks",
                                    style: TextStyle(
                                      color: Color(0xff15B86C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: high_task.isEmpty
                                        ? Center(
                                            child: Text(
                                              "No high priority tasks",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium,
                                            ),
                                          )
                                        : ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: high_task.length > 4
                                                ? 4
                                                : high_task.length,
                                            itemBuilder: (context, index) {
                                              final currentTask =
                                                  high_task[index];
                                              return Row(
                                                children: [
                                                  Coustemchickbox(
                                                    value:
                                                        currentTask.isChecked,
                                                    onChanged: (value) {
                                                      toggleTask(
                                                        currentTask,
                                                        value ?? false,
                                                      );
                                                    },
                                                  ),

                                                  Expanded(
                                                    child: Text(
                                                      currentTask.TaskName,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          currentTask.isChecked
                                                          ? Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge
                                                          : Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 12,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const HighPer(),
                                      ),
                                    );
                                    // نعيد التحميل بعد الرجوع
                                    loedTask();
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: ThemeControler.isLight()
                                            ? Color(0xffD1DAD6)
                                            : Color(0xff6E6E6E),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.north_east,
                                      color: ThemeControler.isLight()
                                          ? Color(0xff3A4640)
                                          : Color(0xffC6C6C6),
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ---- My Tasks title ----
                    Text(
                      "My Tasks",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),

              // ==========================================
              // 2) قائمة المهام
              // ==========================================
              if (task.isEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "No tasks yet",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final currentTask = task[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Row(
                          children: [
                            Coustemchickbox(
                              value: currentTask.isChecked,
                              onChanged: (value) {
                                toggleTask(currentTask, value ?? false);
                              },
                            ),

                            const SizedBox(width: 16),
                            Expanded(
                              child: currentTask.isChecked
                                  ? Text(
                                      currentTask.TaskName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentTask.TaskName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                        Text(
                                          currentTask.TaskDesc,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                            ),
                            PopupMenuButton<EnumForActions>(
                              onSelected: (value) {
                                switch (value) {
                                  case EnumForActions.edit:
                                    edit_task(currentTask, context);

                                  case EnumForActions.delete:
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Delete Task"),
                                          content: Text(
                                            "are you sure you want to delete this task ?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                delete_task(currentTask);
                                                Navigator.pop(context);
                                              },
                                              child: Text("Delete"),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.red,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancle"),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                  case EnumForActions.markasdone:
                                    toggleTask(
                                      currentTask,
                                      !currentTask.isChecked,
                                    );
                                }
                              },
                              icon: Icon(
                                Icons.more_vert,
                                size: 30,
                                color: ThemeControler.isLight()
                                    ? (currentTask.isChecked
                                          ? const Color(0xffA0A0A0)
                                          : const Color(0xffC6C6C6))
                                    : (currentTask.isChecked
                                          ? const Color(0xff6A6A6A)
                                          : const Color(0xff3A4640)),
                              ),
                              itemBuilder: (context) => EnumForActions.values
                                  .map(
                                    (e) => PopupMenuItem(
                                      value: e,
                                      child: Text(e.name),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }, childCount: task.length),
                ),

              // ==========================================
              // 3) مساحة أسفل الشاشة عشان الـ FAB
              // ==========================================
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }

  void delete_task(TaskModel currentTask) {
    setState(() {
      task.remove(currentTask);
      high_task.remove(currentTask);
      iscjecked = done_num();
    });
    saveTasks();
  }

  void edit_task(TaskModel currentTask, BuildContext context) {
    // الـ variables برا الـ builder عشان متتصفرش مع كل rebuild
    TextEditingController controller1 = TextEditingController(
      text: currentTask.TaskName,
    );
    TextEditingController controller2 = TextEditingController(
      text: currentTask.TaskDesc,
    );
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool highPriority = currentTask.pero;

    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                              High_per(task);
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
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
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
  }
}
