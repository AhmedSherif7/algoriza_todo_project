import 'package:algoriza_todo/data/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<Input, Output> {
  Future<Either<Failure, Output>> call(Input input);
}

class NoParams {}

class NoOutput {}
