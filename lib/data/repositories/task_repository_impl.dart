import 'package:algoriza_todo/core/utils/notifications.dart';
import 'package:algoriza_todo/data/data_sources/local_data_source.dart';
import 'package:algoriza_todo/data/error/failure.dart';
import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/domain/repositories/task_repository.dart';
import 'package:algoriza_todo/domain/use_cases/base_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/create_task_use_case.dart';
import 'package:dartz/dartz.dart' hide Task;

class TaskRepositoryImpl implements TaskRepository {
  final LocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Task>>> getAllTasks() async {
    List<Task> tasks = [];
    try {
      final taskModels = await localDataSource.getAllTasks();
      tasks.addAll(taskModels);
      return Right(tasks);
    } catch (_) {
      return const Left(Failure(message: 'Failed to get tasks'));
    }
  }

  @override
  Future<Either<Failure, int>> createTask(CreateTaskInput task) async {
    try {
      final newTaskId = await localDataSource.createTask(task);
      return Right(newTaskId);
    } catch (_) {
      return const Left(Failure(message: 'Failed to create task'));
    }
  }

  @override
  Future<Either<Failure, NoOutput>> setTaskCompleted(int taskId) async {
    try {
      await localDataSource.completeTask(taskId);
      return Right(NoOutput());
    } catch (_) {
      return const Left(Failure(message: 'Failed to mark task as completed'));
    }
  }

  @override
  Future<Either<Failure, NoOutput>> setTaskUnCompleted(int taskId) async {
    try {
      await localDataSource.unCompleteTask(taskId);
      return Right(NoOutput());
    } catch (_) {
      return const Left(Failure(message: 'Failed to mark task as uncompleted'));
    }
  }

  @override
  Future<Either<Failure, NoOutput>> addTaskToFavorites(int taskId) async {
    try {
      await localDataSource.addTaskToFavorites(taskId);
      return Right(NoOutput());
    } catch (_) {
      return const Left(Failure(message: 'Failed to add task to favorites'));
    }
  }

  @override
  Future<Either<Failure, NoOutput>> removeTaskFromFavorites(int taskId) async {
    try {
      await localDataSource.removeTaskFromFavorites(taskId);
      return Right(NoOutput());
    } catch (_) {
      return const Left(
        Failure(message: 'Failed to remove task from favorites'),
      );
    }
  }

  @override
  Future<Either<Failure, NoOutput>> deleteTask(int taskId) async {
    try {
      await localDataSource.deleteTask(taskId);
      return Right(NoOutput());
    } catch (_) {
      return const Left(Failure(message: 'Failed to delete task'));
    }
  }

  @override
  Future<Either<Failure, NoOutput>> setTaskNotifications(Task task) async {
    try {
      await scheduleNotification(task: task);
      await localDataSource.setTaskNotification(task.id);
      return Right(NoOutput());
    } catch (_) {
      return const Left(Failure(message: 'Failed to set notifications'));
    }
  }

  @override
  Future<Either<Failure, NoOutput>> removeTaskNotifications(int taskId) async {
    try {
      await cancelTaskNotifications(taskId);
      await localDataSource.removeTaskNotification(taskId);
      return Right(NoOutput());
    } catch (_) {
      return const Left(Failure(message: 'Failed to remove notifications'));
    }
  }

  @override
  Future<Either<Failure, NoOutput>> removeAllNotifications() async {
    try {
      await cancelAllNotifications();
      await localDataSource.removeAllNotifications();
      return Right(NoOutput());
    } catch (_) {
      return const Left(Failure(message: 'Failed to cancel notifications'));
    }
  }
}
