import 'package:algoriza_todo/core/utils/notifications.dart';
import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/domain/use_cases/create_task_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final CreateTaskUseCase createTaskUseCase;

  int taskColor = 0;
  int taskRemind = -1;
  String taskRepeat = '';
  DateTime taskDate = DateTime.now();
  TimeOfDay taskStartTime = TimeOfDay.now();
  TimeOfDay taskEndTime = TimeOfDay.now();
  final formKey = GlobalKey<FormState>();

  CreateTaskCubit(this.createTaskUseCase) : super(CreateTaskInitialState());

  void changeTaskColor(int color) {
    taskColor = color;
    emit(TaskColorChangeState());
  }

  void changeTaskRemind(int remind) {
    taskRemind = remind;
    emit(TaskRemindChangeState());
  }

  void changeTaskRepeat(String repeat) {
    taskRepeat = repeat;
    emit(TaskRepeatChangeState());
  }

  void changeTaskDate(DateTime? date) {
    if (date != null) {
      taskDate = date;
      emit(TaskDateChangeState());
    }
  }

  void changeTaskStartTime(TimeOfDay? time) {
    if (time != null) {
      taskStartTime = time;
      emit(TaskStartTimeChangeState());
    }
  }

  void changeTaskEndTime(TimeOfDay? time) {
    if (time != null) {
      taskEndTime = time;
      emit(TaskEndTimeChangeState());
    }
  }

  Future<void> createTask({
    required String title,
  }) async {
    if (formKey.currentState!.validate()) {
      emit(CreateTaskLoadingState());

      final result = await createTaskUseCase(
        CreateTaskInput(
          title: title,
          date: taskDate.toString(),
          startTime: taskStartTime.toString(),
          endTime: taskEndTime.toString(),
          remind: taskRemind,
          repeat: taskRepeat,
          color: taskColor,
        ),
      );

      result.fold(
        (error) {
          emit(CreateTaskErrorState(error.message));
        },
        (id) async {
          var newTask = Task(
            id: id,
            title: title,
            isCompleted: 0,
            date: taskDate.toString(),
            startTime: taskStartTime.toString(),
            endTime: taskEndTime.toString(),
            remindMinutes: taskRemind,
            repeat: taskRepeat,
            isFavorite: 0,
            color: taskColor,
            hasNotifications: 0,
          );

          final hasNotification = await _setTaskNotifications(newTask);
          if (hasNotification) {
            newTask = newTask.copyWith(
              hasNotifications: 1,
            );
          }

          emit(CreateTaskSuccessState(newTask));
        },
      );
    }
  }

  Future<bool> _setTaskNotifications(Task task) async {
    return await scheduleNotification(task: task);
  }
}
