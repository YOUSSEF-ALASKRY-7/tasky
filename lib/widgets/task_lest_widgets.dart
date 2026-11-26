import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controler.dart';
import 'package:tasky/core/widgets/coustemchickbox.dart';
import 'package:tasky/models/task_model.dart';

import '../core/enum/enumforactions.dart';

class TaskLestWidgets extends StatelessWidget {
  const TaskLestWidgets({super.key, required this.task, required this.ontap, required this.delete_task, required this.edit_task});

  final List<TaskModel> task;
  final Function(TaskModel?, bool?) ontap;
  final Function(TaskModel?) delete_task;
  final Function(TaskModel?,BuildContext context) edit_task;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 40),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: task.length,
      itemBuilder: (context, index) {
        final currentTask = task[index];
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primaryContainer,
              border: Border.all(color: ThemeControler.isLight()? Color(0xffD1DAD6):Colors.transparent)
            ),
            child: Row(
              children: [
                Coustemchickbox(
                  value: currentTask.isChecked,
                  onChanged: (bool? value) {
                    ontap(currentTask, value);
                  },
                ),

                SizedBox(width: 16),
                Expanded(
                  child: currentTask.isChecked
                      ? Text(
                          currentTask.TaskName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentTask.TaskName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              currentTask.TaskDesc,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                ),
                PopupMenuButton<EnumForActions>(
                  onSelected: (value) {
                    switch (value) {
                      case EnumForActions.edit:
                        edit_task(currentTask,context);
                      case EnumForActions.delete:
                        delete_task(currentTask);
                      case EnumForActions.markasdone:
                        ontap(
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
      },
    );
  }
}
