import 'package:algoriza_todo/data/error/failure.dart';
import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/domain/repositories/task_repository.dart';
import 'package:algoriza_todo/domain/use_cases/base_use_case.dart';
import 'package:dartz/dartz.dart' hide Task;

class GetAllTasksUseCase extends BaseUseCase<NoParams, List<Task>> {
  final TaskRepository repository;

  GetAllTasksUseCase(this.repository);

  @override
  Future<Either<Failure, List<Task>>> call(input) async {
    return await repository.getAllTasks();
  }
}
