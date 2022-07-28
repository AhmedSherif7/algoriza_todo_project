part of 'task_cubit.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskGetErrorState extends TaskState {
  final String error;

  TaskGetErrorState(this.error);
}

class TaskGetSuccessState extends TaskState {}

class TaskCompleteErrorState extends TaskState {
  final String error;

  TaskCompleteErrorState(this.error);
}

class TaskCompleteSuccessState extends TaskState {
  final String message;

  TaskCompleteSuccessState(this.message);
}

class TaskUnCompleteErrorState extends TaskState {
  final String error;

  TaskUnCompleteErrorState(this.error);
}

class TaskUnCompleteSuccessState extends TaskState {
  final String message;

  TaskUnCompleteSuccessState(this.message);
}

class NewTaskAddedState extends TaskState {}

class TaskAddToFavoritesSuccess extends TaskState {
  final String message;

  TaskAddToFavoritesSuccess(this.message);
}

class TaskAddToFavoritesError extends TaskState {
  final String error;

  TaskAddToFavoritesError(this.error);
}

class TaskRemoveFromFavoritesSuccess extends TaskState {
  final String message;

  TaskRemoveFromFavoritesSuccess(this.message);
}

class TaskRemoveFromFavoritesError extends TaskState {
  final String error;

  TaskRemoveFromFavoritesError(this.error);
}

class TaskDeleteSuccess extends TaskState {
  final String message;

  TaskDeleteSuccess(this.message);
}

class TaskDeleteError extends TaskState {
  final String error;

  TaskDeleteError(this.error);
}

class TaskSetNotificationSuccess extends TaskState {}

class TaskSetNotificationError extends TaskState {
  final String error;

  TaskSetNotificationError(this.error);
}

class TaskRemoveNotificationSuccess extends TaskState {}

class TaskRemoveNotificationError extends TaskState {
  final String error;

  TaskRemoveNotificationError(this.error);
}

class CancelAllNotificationsSuccess extends TaskState {}

class CancelAllNotificationsError extends TaskState {
  final String error;

  CancelAllNotificationsError(this.error);
}
