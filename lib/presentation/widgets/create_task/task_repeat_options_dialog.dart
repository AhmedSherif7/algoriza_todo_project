import 'package:algoriza_todo/presentation/widgets/create_task/task_repeat_radio_option.dart';
import 'package:flutter/material.dart';

class TaskRepeatOptionsDialog extends StatelessWidget {
  const TaskRepeatOptionsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Repeat Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TaskRepeatRadioOption('None'),
          TaskRepeatRadioOption('Daily'),
          TaskRepeatRadioOption('Weekly'),
          TaskRepeatRadioOption('Monthly'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
