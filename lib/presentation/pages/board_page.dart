import 'package:algoriza_todo/core/di.dart';
import 'package:algoriza_todo/core/functions.dart';
import 'package:algoriza_todo/core/utils/notifications.dart';
import 'package:algoriza_todo/presentation/managers/task/task_cubit.dart';
import 'package:algoriza_todo/presentation/pages/create_task_page.dart';
import 'package:algoriza_todo/presentation/pages/schedule_page.dart';
import 'package:algoriza_todo/presentation/widgets/board/tab_bar.dart';
import 'package:algoriza_todo/presentation/widgets/board/task_list_layout.dart';
import 'package:algoriza_todo/presentation/widgets/shared/custom_button.dart';
import 'package:algoriza_todo/presentation/widgets/shared/failure_widget.dart';
import 'package:algoriza_todo/presentation/widgets/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    initNotifications(context);
    _controller = TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<TaskCubit>()..getTasks(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Board'),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return SchedulePage(context.read<TaskCubit>().tasks);
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                  tooltip: 'Schedule',
                );
              },
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    context.read<TaskCubit>().cancelAllNotifications();
                  },
                  icon: const Icon(Icons.notifications_off_outlined),
                  tooltip: 'Cancel Notifications',
                );
              },
            ),
          ],
          bottom: HomeTabBar(
            controller: _controller,
          ),
        ),
        body: BlocConsumer<TaskCubit, TaskState>(
          listener: (context, state) {
            if (state is TaskCompleteSuccessState) {
              showToast(
                message: state.message,
                state: ToastStates.success,
              );
            } else if (state is TaskUnCompleteSuccessState) {
              showToast(
                message: state.message,
                state: ToastStates.success,
              );
            } else if (state is TaskCompleteErrorState) {
              showToast(
                message: state.error,
                state: ToastStates.error,
              );
            } else if (state is TaskUnCompleteErrorState) {
              showToast(
                message: state.error,
                state: ToastStates.error,
              );
            } else if (state is TaskAddToFavoritesSuccess) {
              showToast(
                message: state.message,
                state: ToastStates.success,
              );
            } else if (state is TaskAddToFavoritesError) {
              showToast(
                message: state.error,
                state: ToastStates.error,
              );
            } else if (state is TaskRemoveFromFavoritesSuccess) {
              showToast(
                message: state.message,
                state: ToastStates.success,
              );
            } else if (state is TaskRemoveFromFavoritesError) {
              showToast(
                message: state.error,
                state: ToastStates.error,
              );
            } else if (state is TaskDeleteSuccess) {
              showToast(
                message: state.message,
                state: ToastStates.success,
              );
            } else if (state is TaskDeleteError) {
              showToast(
                message: state.error,
                state: ToastStates.error,
              );
            } else if (state is CancelAllNotificationsSuccess) {
              showToast(
                message: 'All notifications cancelled',
                state: ToastStates.success,
              );
            }
          },
          builder: (context, state) {
            final taskCubit = BlocProvider.of<TaskCubit>(context);

            if (state is TaskLoadingState) {
              return const LoadingWidget();
            } else if (state is TaskGetErrorState) {
              return FailureWidget(state.error);
            }
            return TabBarView(
              controller: _controller,
              children: [
                TaskListLayout(taskCubit.tasks),
                TaskListLayout(taskCubit.completedTasks),
                TaskListLayout(taskCubit.unCompletedTasks),
                TaskListLayout(taskCubit.favoriteTasks),
              ],
            );
          },
        ),
        bottomSheet: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Builder(
            builder: (context) {
              return CustomButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return BlocProvider.value(
                          value: context.read<TaskCubit>(),
                          child: const CreateTaskPage(),
                        );
                      },
                    ),
                  );
                },
                text: 'Add a Task',
                textColor: Colors.white,
              );
            },
          ),
        ),
      ),
    );
  }
}
