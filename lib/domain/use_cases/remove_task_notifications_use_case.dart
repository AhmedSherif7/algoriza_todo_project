import 'package:algoriza_todo/data/error/failure.dart';
import 'package:algoriza_todo/domain/repositories/task_repository.dart';
import 'package:algoriza_todo/domain/use_cases/base_use_case.dart';
import 'package:dartz/dartz.dart';

class RemoveTaskNotificationsUseCase extends BaseUseCase<int, NoOutput> {
  final TaskRepository repository;

  RemoveTaskNotificationsUseCase(this.repository);

  @override
  Future<Either<Failure, NoOutput>> call(int input) async {
    return repository.removeTaskNotifications(input);
  }
}
