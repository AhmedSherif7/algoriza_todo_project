import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/domain/use_cases/add_task_to_favorites_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/base_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/cancel_all_notifications_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/complete_task_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/delete_task_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/get_all_tasks_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/remove_task_from_favorites_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/remove_task_notifications_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/set_task_notifications_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/un_complete_task_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  final CompleteTaskUseCase completeTaskUseCase;
  final UnCompleteTaskUseCase unCompleteTaskUseCase;
  final AddTaskToFavoritesUseCase addTaskToFavoritesUseCase;
  final RemoveTaskFromFavoritesUseCase removeTaskFromFavoritesUseCase;
  final SetTaskNotificationsUseCase setTaskNotificationsUseCase;
  final RemoveTaskNotificationsUseCase removeTaskNotificationsUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final CancelAllNotificationsUseCase cancelAllNotificationsUseCase;

  TaskCubit(
    this.getAllTasksUseCase,
    this.completeTaskUseCase,
    this.unCompleteTaskUseCase,
    this.addTaskToFavoritesUseCase,
    this.removeTaskFromFavoritesUseCase,
    this.setTaskNotificationsUseCase,
    this.removeTaskNotificationsUseCase,
    this.deleteTaskUseCase,
    this.cancelAllNotificationsUseCase,
  ) : super(TaskInitialState());

  List<Task> tasks = [];
  List<Task> completedTasks = [];
  List<Task> unCompletedTasks = [];
  List<Task> favoriteTasks = [];

  Future<void> getTasks() async {
    emit(TaskLoadingState());

    final result = await getAllTasksUseCase(NoParams());
    result.fold(
      (error) {
        emit(TaskGetErrorState(error.message));
      },
      (newTasks) {
        tasks = newTasks;
        _setTasksFilters();
        _setFavorites();
        emit(TaskGetSuccessState());
      },
    );
  }

  void _setTasksFilters() {
    completedTasks = tasks.where((task) => task.isCompleted == 1).toList();
    unCompletedTasks = tasks.where((task) => task.isCompleted == 0).toList();
  }

  void _setFavorites() {
    favoriteTasks = tasks.where((task) => task.isFavorite == 1).toList();
  }

  Future<void> updateTaskStatus(int taskId, bool value) async {
    if (value) {
      _setTaskCompleted(taskId);
    } else {
      _setTaskUnCompleted(taskId);
    }
  }

  Future<void> _setTaskCompleted(int taskId) async {
    final result = await completeTaskUseCase(taskId);

    result.fold(
      (error) {
        emit(TaskCompleteErrorState(error.message));
      },
      (_) {
        final oldTaskIndex = tasks.indexWhere((task) => task.id == taskId);
        final newTask = tasks[oldTaskIndex].copyWith(isCompleted: 1);
        tasks[oldTaskIndex] = newTask;

        _setTasksFilters();
        _setFavorites();
        emit(TaskCompleteSuccessState('Marked as completed'));
      },
    );
  }

  Future<void> _setTaskUnCompleted(int taskId) async {
    final result = await unCompleteTaskUseCase(taskId);

    result.fold(
      (error) {
        emit(TaskUnCompleteErrorState(error.message));
      },
      (_) {
        final oldTaskIndex = tasks.indexWhere((task) => task.id == taskId);
        final newTask = tasks[oldTaskIndex].copyWith(isCompleted: 0);
        tasks[oldTaskIndex] = newTask;

        _setTasksFilters();
        _setFavorites();
        emit(TaskUnCompleteSuccessState('Marked as uncompleted'));
      },
    );
  }

  void changeAllTasks(Task task) {
    tasks.add(task);
    _setTasksFilters();
    emit(NewTaskAddedState());
  }

  bool _isTaskFavorite(int taskId) =>
      tasks.firstWhere((task) => task.id == taskId).isFavorite == 1;

  void makeTaskFavoriteAction(int taskId) {
    if (_isTaskFavorite(taskId)) {
      _removeTaskFromFavorites(taskId);
    } else {
      _addTaskToFavorites(taskId);
    }
  }

  Future<void> _addTaskToFavorites(int taskId) async {
    final result = await addTaskToFavoritesUseCase(taskId);

    result.fold(
      (error) {
        emit(TaskAddToFavoritesError(error.message));
      },
      (_) {
        final oldTaskIndex = tasks.indexWhere((task) => task.id == taskId);
        final newTask = tasks[oldTaskIndex].copyWith(isFavorite: 1);
        tasks[oldTaskIndex] = newTask;

        _setTasksFilters();
        _setFavorites();
        emit(TaskAddToFavoritesSuccess('Added to favorites'));
      },
    );
  }

  Future<void> _removeTaskFromFavorites(int taskId) async {
    final result = await removeTaskFromFavoritesUseCase(taskId);

    result.fold(
      (error) {
        emit(TaskRemoveFromFavoritesError(error.message));
      },
      (_) {
        final oldTaskIndex = tasks.indexWhere((task) => task.id == taskId);
        final newTask = tasks[oldTaskIndex].copyWith(isFavorite: 0);
        tasks[oldTaskIndex] = newTask;

        _setTasksFilters();
        _setFavorites();
        emit(TaskRemoveFromFavoritesSuccess('Removed from favorites'));
      },
    );
  }

  void makeTaskNotificationsAction(Task task) {
    if (task.hasNotifications == 0) {
      _setNotifications(task);
    } else {
      _removeNotifications(task.id);
    }
  }

  Future<void> _setNotifications(Task task) async {
    final result = await setTaskNotificationsUseCase(task);
    result.fold(
      (error) {
        emit(TaskSetNotificationError(error.message));
      },
      (_) {
        final oldTaskIndex =
            tasks.indexWhere((element) => element.id == task.id);
        final newTask = tasks[oldTaskIndex].copyWith(hasNotifications: 1);
        tasks[oldTaskIndex] = newTask;

        emit(TaskSetNotificationSuccess());
      },
    );
  }

  Future<void> _removeNotifications(int taskId) async {
    final result = await removeTaskNotificationsUseCase(taskId);
    result.fold(
      (error) {
        emit(TaskRemoveNotificationError(error.message));
      },
      (_) {
        final oldTaskIndex = tasks.indexWhere((task) => task.id == taskId);
        final newTask = tasks[oldTaskIndex].copyWith(hasNotifications: 0);
        tasks[oldTaskIndex] = newTask;

        emit(TaskRemoveNotificationSuccess());
      },
    );
  }

  Future<void> deleteTask(int taskId) async {
    await removeTaskNotificationsUseCase(taskId);

    final result = await deleteTaskUseCase(taskId);

    result.fold(
      (error) {
        emit(TaskDeleteError(error.message));
      },
      (_) {
        final oldTaskIndex = tasks.indexWhere((task) => task.id == taskId);
        tasks.removeAt(oldTaskIndex);
        _setTasksFilters();
        _setFavorites();
        emit(TaskDeleteSuccess('Deleted successfully'));
      },
    );
  }

  Future<void> cancelAllNotifications() async {
    final result = await cancelAllNotificationsUseCase(NoParams());
    result.fold(
      (error) {
        emit(CancelAllNotificationsError(error.message));
      },
      (_) {
        for (var task in tasks) {
          _removeNotifications(task.id);
        }
        emit(CancelAllNotificationsSuccess());
      },
    );
  }
}
