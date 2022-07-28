import 'package:algoriza_todo/presentation/widgets/create_task/task_remind_radio_option.dart';
import 'package:flutter/material.dart';

class TaskRemindOptionsDialog extends StatelessWidget {
  const TaskRemindOptionsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Task Reminder'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TaskRemindRadioOption(0),
          TaskRemindRadioOption(10),
          TaskRemindRadioOption(30),
          TaskRemindRadioOption(60),
          TaskRemindRadioOption(24),
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
