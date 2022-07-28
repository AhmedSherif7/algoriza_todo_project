import 'package:algoriza_todo/presentation/managers/create_task/create_task_cubit.dart';
import 'package:algoriza_todo/presentation/widgets/create_task/task_color_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskColorPicker extends StatelessWidget {
  const TaskColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        BlocSelector<CreateTaskCubit, CreateTaskState, int>(
          selector: (state) {
            return context.read<CreateTaskCubit>().taskColor;
          },
          builder: (context, color) {
            return SizedBox(
              width: double.infinity,
              height: 40.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return TaskColorItem(
                    index: index,
                    color: color,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 4.0,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
