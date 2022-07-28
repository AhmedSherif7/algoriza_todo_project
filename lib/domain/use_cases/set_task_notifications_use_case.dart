import 'package:algoriza_todo/data/error/failure.dart';
import 'package:algoriza_todo/domain/entities/task.dart';
import 'package:algoriza_todo/domain/repositories/task_repository.dart';
import 'package:algoriza_todo/domain/use_cases/base_use_case.dart';
import 'package:dartz/dartz.dart' hide Task;

class SetTaskNotificationsUseCase extends BaseUseCase<Task, NoOutput> {
  final TaskRepository repository;

  SetTaskNotificationsUseCase(this.repository);

  @override
  Future<Either<Failure, NoOutput>> call(Task input) async {
    return await repository.setTaskNotifications(input);
  }
}
