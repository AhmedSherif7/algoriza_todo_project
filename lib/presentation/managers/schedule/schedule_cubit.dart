import 'package:algoriza_todo/core/extensions.dart';
import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/domain/use_cases/base_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/get_all_tasks_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final GetAllTasksUseCase getAllTaskUseCase;

  ScheduleCubit(this.getAllTaskUseCase) : super(ScheduleInitial());

  List<Task> tasks = [];
  List<Task> selectedTasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getAllTasks() async {
    emit(ScheduleTaskLoadingState());

    final result = await getAllTaskUseCase(NoParams());
    result.fold(
      (error) {
        emit(ScheduleTaskErrorState(error.message));
      },
      (allTasks) {
        tasks = allTasks;
        setTasksList();
        emit(ScheduleTaskSuccessState());
      },
    );
  }

  void changeSelectedDate(DateTime dateTime) {
    selectedDate = dateTime;
    setTasksList();
    emit(SelectedDateChange());
  }

  void setTasksList() {
    selectedTasks.clear();

    for (var task in tasks) {
      switch (task.repeat) {
        case 'None':
          if (task.date.formatDate() == selectedDate.formatDate()) {
            selectedTasks.add(task);
          }
          break;
        case 'Daily':
          selectedTasks.add(task);
          break;
        case 'Weekly':
          if (task.date.formatDate() == selectedDate.formatDate()) {
            selectedTasks.add(task);
          } else {
            final daysDifference =
                selectedDate.difference(DateTime.parse(task.date)).inDays;
            if (daysDifference % 7 == 0 && daysDifference > 0) {
              selectedTasks.add(task);
            }
          }
          break;
        case 'Monthly':
          if (task.date.formatDate() == selectedDate.formatDate()) {
            selectedTasks.add(task);
          } else {
            final daysDifference =
                selectedDate.difference(DateTime.parse(task.date)).inDays;
            if (daysDifference % 30 == 0 && daysDifference > 0) {
              selectedTasks.add(task);
            }
          }
          break;
      }
    }
  }
}
