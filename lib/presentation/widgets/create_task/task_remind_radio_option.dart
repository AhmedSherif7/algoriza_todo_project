import 'package:algoriza_todo/core/extensions.dart';
import 'package:algoriza_todo/presentation/managers/create_task/create_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskRemindRadioOption extends StatelessWidget {
  final int value;

  const TaskRemindRadioOption(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CreateTaskCubit, CreateTaskState, int>(
      selector: (state) {
        return context.read<CreateTaskCubit>().taskRemind;
      },
      builder: (context, remind) {
        return RadioListTile<int>(
          value: value,
          groupValue: remind,
          onChanged: (value) {
            context.read<CreateTaskCubit>().changeTaskRemind(value!);
          },
          title: Text(value.getTaskReminder()),
        );
      },
    );
  }
}
