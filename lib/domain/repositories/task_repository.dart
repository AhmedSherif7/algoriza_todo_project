import 'package:algoriza_todo/data/error/failure.dart';
import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/domain/use_cases/base_use_case.dart';
import 'package:algoriza_todo/domain/use_cases/create_task_use_case.dart';
import 'package:dartz/dartz.dart' hide Task;

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getAllTasks();

  Future<Either<Failure, int>> createTask(CreateTaskInput task);

  Future<Either<Failure, NoOutput>> setTaskCompleted(int taskId);

  Future<Either<Failure, NoOutput>> setTaskUnCompleted(int taskId);

  Future<Either<Failure, NoOutput>> addTaskToFavorites(int taskId);

  Future<Either<Failure, NoOutput>> removeTaskFromFavorites(int taskId);

  Future<Either<Failure, NoOutput>> setTaskNotifications(Task task);

  Future<Either<Failure, NoOutput>> removeTaskNotifications(int taskId);

  Future<Either<Failure, NoOutput>> deleteTask(int taskId);

  Future<Either<Failure, NoOutput>> removeAllNotifications();
}
