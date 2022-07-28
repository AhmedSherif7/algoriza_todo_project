import 'package:algoriza_todo/data/error/failure.dart';
import 'package:algoriza_todo/domain/repositories/task_repository.dart';
import 'package:algoriza_todo/domain/use_cases/base_use_case.dart';
import 'package:dartz/dartz.dart';

class CancelAllNotificationsUseCase extends BaseUseCase<NoParams, NoOutput> {
  final TaskRepository repository;

  CancelAllNotificationsUseCase(this.repository);

  @override
  Future<Either<Failure, NoOutput>> call(NoParams input) async {
    return await repository.removeAllNotifications();
  }
}