import 'package:algoriza_todo/data/error/failure.dart';
import 'package:algoriza_todo/domain/repositories/task_repository.dart';
import 'package:algoriza_todo/domain/use_cases/base_use_case.dart';
import 'package:dartz/dartz.dart' hide Task;

class CreateTaskUseCase extends BaseUseCase<CreateTaskInput, int> {
  final TaskRepository repository;

  CreateTaskUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(input) async {
    return await repository.createTask(input);
  }
}

class CreateTaskInput {
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final int remind;
  final String repeat;
  final int color;

  CreateTaskInput({
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.remind,
    required this.repeat,
    required this.color,
  });
}
