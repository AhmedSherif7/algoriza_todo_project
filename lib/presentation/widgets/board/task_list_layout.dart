import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/presentation/widgets/board/empty_tasks_list.dart';
import 'package:algoriza_todo/presentation/widgets/board/tasks_list_view.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class TaskListLayout extends StatelessWidget {
  const TaskListLayout(this.tasks, {Key? key}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConditionalBuilder(
          condition: tasks.isNotEmpty,
          builder: (context) {
            return Expanded(
              child: TasksListView(tasks),
            );
          },
          fallback: (context) {
            return const EmptyTasksList();
          },
        ),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}
