import 'package:algoriza_todo/core/extensions.dart';
import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/presentation/managers/task/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted.isTaskCompleted(),
        onChanged: (value) {
          context.read<TaskCubit>().updateTaskStatus(task.id, value!);
        },
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.all(task.color.getTaskColor()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      title: Text(task.title),
      trailing: DropdownButton(
        icon: const Icon(Icons.more_vert),
        underline: const SizedBox.shrink(),
        items: [
          DropdownMenuItem(
            value: 'favorite',
            child: Row(
              children: [
                const Text('Favorite'),
                const SizedBox(
                  width: 4.0,
                ),
                Icon(
                  task.isFavorite.isTaskFavorite()
                      ? Icons.star
                      : Icons.star_outline,
                  color: task.isFavorite == 1
                      ? const Color(0xffFFD700)
                      : Colors.grey,
                ),
              ],
            ),
            onTap: () {
              context.read<TaskCubit>().makeTaskFavoriteAction(task.id);
            },
          ),
          DropdownMenuItem(
            value: 'delete',
            child: Row(
              children: const [
                Text('Delete'),
                SizedBox(
                  width: 4.0,
                ),
                Icon(Icons.delete_outline),
              ],
            ),
            onTap: () {
              context.read<TaskCubit>().deleteTask(task.id);
            },
          ),
          DropdownMenuItem(
            value: 'notification',
            child: Row(
              children: [
                Text(task.hasNotifications == 1 ? 'Mute' : 'Notify'),
                const SizedBox(
                  width: 4.0,
                ),
                Icon(
                  task.hasNotifications == 1
                      ? Icons.notifications_off_outlined
                      : Icons.notification_add_outlined,
                ),
              ],
            ),
            onTap: () {
              context.read<TaskCubit>().makeTaskNotificationsAction(task);
            },
          ),
        ],
        onChanged: (_) {},
      ),
    );
  }
}
