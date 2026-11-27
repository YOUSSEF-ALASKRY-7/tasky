


import 'dart:math';

import 'package:flutter/material.dart';

class AchievedTasks extends StatelessWidget {

   AchievedTasks({super.key,required this.doneTask,required this.totalTask});

int doneTask;
int ?totalTask;




  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: double.infinity,
      decoration: BoxDecoration(
        color:  Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Achieved Tasks",
                    style:   Theme.of(context).textTheme.titleSmall
                ),
                Text(
                  "$doneTask Out of $totalTask Done",
                  style:  Theme.of(context).textTheme.titleMedium
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Transform.rotate(
                    angle: pi/2,
                    child: CircularProgressIndicator(
                      value:totalTask==null || totalTask==0 ? 0 : (doneTask / totalTask!),
                      // نسبة التقدم 50%
                      strokeWidth: 6,
                      backgroundColor: Colors.grey.shade700,
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(
                        Color(0xff35C69A),
                      ),
                    ),
                  ),
                ),

                Text(
                  "${totalTask==null || totalTask==0 ? 0 : ((doneTask / totalTask!) * 100).floor()}%",
                  style:  Theme.of(context).textTheme.labelSmall
                ),
              ],
            ),
          ),
        ],
      ),
    )
    ;
  }
}
