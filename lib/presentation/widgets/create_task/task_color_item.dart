import 'package:algoriza_todo/core/extensions.dart';
import 'package:algoriza_todo/presentation/managers/create_task/create_task_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskColorItem extends StatelessWidget {
  const TaskColorItem({
    required this.index,
    required this.color,
    Key? key,
  }) : super(key: key);

  final int index;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        onTap: () {
          context.read<CreateTaskCubit>().changeTaskColor(index);
        },
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: index.getTaskColor(),
            shape: BoxShape.circle,
          ),
          child: ConditionalBuilder(
            condition: index == color,
            builder: (context) {
              return const Icon(
                Icons.check,
                color: Colors.white,
              );
            },
            fallback: (context) {
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
