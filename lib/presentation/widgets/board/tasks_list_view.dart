import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/presentation/widgets/board/task_list_item.dart';
import 'package:flutter/material.dart';

class TasksListView extends StatelessWidget {
  const TasksListView(this.tasks, {Key? key}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskListItem(tasks[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 20.0,
        );
      },
    );
  }
}
