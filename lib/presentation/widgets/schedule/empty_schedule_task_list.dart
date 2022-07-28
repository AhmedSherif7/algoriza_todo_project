import 'package:flutter/material.dart';

class EmptyScheduleTaskList extends StatelessWidget {
  const EmptyScheduleTaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text(
          'No tasks for today',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
