import 'package:algoriza_todo/presentation/managers/create_task/create_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskRepeatRadioOption extends StatelessWidget {
  final String value;

  const TaskRepeatRadioOption(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CreateTaskCubit, CreateTaskState, String>(
      selector: (state) {
        return context.read<CreateTaskCubit>().taskRepeat;
      },
      builder: (context, repeat) {
        return RadioListTile<String>(
          value: value,
          groupValue: repeat,
          onChanged: (value) {
            context.read<CreateTaskCubit>().changeTaskRepeat(value!);
          },
          title: Text(value),
        );
      },
    );
  }
}
