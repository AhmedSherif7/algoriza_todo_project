import 'package:algoriza_todo/core/constants.dart';
import 'package:algoriza_todo/data/error/failure.dart';
import 'package:algoriza_todo/data/models/task_model.dart';
import 'package:algoriza_todo/domain/use_cases/create_task_use_case.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalDataSource {
  Future<List<TaskModel>> getAllTasks();

  Future<int> createTask(CreateTaskInput task);

  Future<void> completeTask(int taskId);

  Future<void> unCompleteTask(int taskId);

  Future<void> addTaskToFavorites(int taskId);

  Future<void> removeTaskFromFavorites(int taskId);

  Future<void> deleteTask(int taskId);

  Future<void> setTaskNotification(int taskId);

  Future<void> removeTaskNotification(int taskId);

  Future<void> removeAllNotifications();
}

class LocalDataSourceImpl implements LocalDataSource {
  final Database database;

  LocalDataSourceImpl(this.database);

  @override
  Future<List<TaskModel>> getAllTasks() async {
    List<TaskModel> tasks = [];
    final result = await database.rawQuery('SELECT * FROM $kTasksTable');
    tasks = result.map((json) => TaskModel.fromJson(json)).toList();
    return tasks;
  }

  @override
  Future<int> createTask(CreateTaskInput task) async {
    late int taskId;
    await database.transaction(
      (txn) async {
        taskId = await txn.rawInsert(
          'INSERT INTO $kTasksTable(title, isCompleted, date, startTime,'
          ' endTime, remindMinutes, repeat,'
          ' isFavorite, color, hasNotifications) '
          'VALUES("${task.title}", 0, "${task.date}", "${task.startTime}", '
          '"${task.endTime}", ${task.remind}, "${task.repeat}", 0, '
          '${task.color}, 0)',
        );
      },
    );

    if (taskId > 0) {
      return taskId;
    }

    throw const Failure(message: 'Failed to create task');
  }

  @override
  Future<void> completeTask(int taskId) async {
    await database.rawUpdate(
      'UPDATE $kTasksTable SET isCompleted = ? WHERE id = ?',
      [1, taskId],
    );
  }

  @override
  Future<void> unCompleteTask(int taskId) async {
    await database.rawUpdate(
      'UPDATE $kTasksTable SET isCompleted = ? WHERE id = ?',
      [0, taskId],
    );
  }

  @override
  Future<void> addTaskToFavorites(int taskId) async {
    await database.rawUpdate(
      'UPDATE $kTasksTable SET isFavorite = ? WHERE id = ?',
      [1, taskId],
    );
  }

  @override
  Future<void> removeTaskFromFavorites(int taskId) async {
    await database.rawUpdate(
      'UPDATE $kTasksTable SET isFavorite = ? WHERE id = ?',
      [0, taskId],
    );
  }

  @override
  Future<void> deleteTask(int taskId) async {
    await database.rawDelete(
      'DELETE FROM $kTasksTable WHERE id = ?',
      [taskId],
    );
  }

  @override
  Future<void> setTaskNotification(int taskId) async {
    await database.rawUpdate(
      'UPDATE $kTasksTable SET hasNotifications = ? WHERE id = ?',
      [1, taskId],
    );
  }

  @override
  Future<void> removeTaskNotification(int taskId) async {
    await database.rawUpdate(
      'UPDATE $kTasksTable SET hasNotifications = ? WHERE id = ?',
      [0, taskId],
    );
  }

  @override
  Future<void> removeAllNotifications() async {
    await database.rawUpdate(
      'UPDATE $kTasksTable SET hasNotifications = ?',
      [0],
    );
  }
}
