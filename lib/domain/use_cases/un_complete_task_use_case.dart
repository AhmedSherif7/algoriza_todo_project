import 'package:algoriza_todo/data/error/failure.dart';
import 'package:algoriza_todo/domain/repositories/task_repository.dart';
import 'package:algoriza_todo/domain/use_cases/base_use_case.dart';
import 'package:dartz/dartz.dart';

class UnCompleteTaskUseCase extends BaseUseCase<int, NoOutput> {
  final TaskRepository repository;

  UnCompleteTaskUseCase(this.repository);

  @override
  Future<Either<Failure, NoOutput>> call(input) async {
    return await repository.setTaskUnCompleted(input);
  }
}
