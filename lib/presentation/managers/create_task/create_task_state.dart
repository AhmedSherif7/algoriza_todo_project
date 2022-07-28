part of 'create_task_cubit.dart';

abstract class CreateTaskState {}

class CreateTaskInitialState extends CreateTaskState {}

class CreateTaskLoadingState extends CreateTaskState {}

class CreateTaskSuccessState extends CreateTaskState {
  final Task task;

  CreateTaskSuccessState(this.task);
}

class CreateTaskErrorState extends CreateTaskState {
  final String error;

  CreateTaskErrorState(this.error);
}

class TaskColorChangeState extends CreateTaskState {}

class TaskRemindChangeState extends CreateTaskState {}

class TaskRepeatChangeState extends CreateTaskState {}

class TaskDateChangeState extends CreateTaskState {}

class TaskStartTimeChangeState extends CreateTaskState {}

class TaskEndTimeChangeState extends CreateTaskState {}
