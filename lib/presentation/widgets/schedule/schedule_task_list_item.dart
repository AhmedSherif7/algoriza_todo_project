import 'package:algoriza_todo/core/extensions.dart';
import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:flutter/material.dart';

class ScheduleTaskListItem extends StatelessWidget {
  const ScheduleTaskListItem(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final taskTime = 'From ${task.startTime.getStringTime()} '
        'to ${task.endTime.getStringTime()}';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: task.color.getTaskColor(),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  taskTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  task.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  task.repeat,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 15.0,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 14.0,
              backgroundColor: task.color.getTaskColor(),
              child: task.isCompleted.isTaskCompleted()
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 22.0,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
