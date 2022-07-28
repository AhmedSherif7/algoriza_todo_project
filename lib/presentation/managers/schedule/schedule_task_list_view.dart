import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/presentation/widgets/schedule/schedule_task_list_item.dart';
import 'package:flutter/material.dart';

class ScheduleTaskListView extends StatelessWidget {
  const ScheduleTaskListView(this.tasks, {Key? key}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ScheduleTaskListItem(tasks[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 20,
            );
          },
        ),
      ),
    );
  }
}
