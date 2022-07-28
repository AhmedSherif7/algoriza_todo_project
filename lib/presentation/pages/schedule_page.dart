import 'package:algoriza_todo/core/di.dart';
import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/presentation/managers/schedule/schedule_cubit.dart';
import 'package:algoriza_todo/presentation/managers/schedule/schedule_task_list_view.dart';
import 'package:algoriza_todo/presentation/widgets/schedule/date_time_line.dart';
import 'package:algoriza_todo/presentation/widgets/schedule/empty_schedule_task_list.dart';
import 'package:algoriza_todo/presentation/widgets/schedule/selected_day.dart';
import 'package:algoriza_todo/presentation/widgets/shared/failure_widget.dart';
import 'package:algoriza_todo/presentation/widgets/shared/loading_widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage(this.tasks, {Key? key}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleCubit>(
      create: (_) => di<ScheduleCubit>()..getAllTasks(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('Schedule'),
        ),
        body: BlocBuilder<ScheduleCubit, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleTaskLoadingState) {
              return const LoadingWidget();
            } else if (state is ScheduleTaskErrorState) {
              return FailureWidget(state.error);
            }
            return Column(
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                const DateTimeLine(),
                const Divider(
                  color: Colors.grey,
                ),
                const SelectedDay(),
                ConditionalBuilder(
                  condition: context.read<ScheduleCubit>().selectedTasks.isNotEmpty,
                  builder: (context) {
                    return ScheduleTaskListView(
                      context.read<ScheduleCubit>().selectedTasks,
                    );
                  },
                  fallback: (context) {
                    return const EmptyScheduleTaskList();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
