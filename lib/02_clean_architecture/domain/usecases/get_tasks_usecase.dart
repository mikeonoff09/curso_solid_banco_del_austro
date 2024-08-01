import 'package:curso_solid_banco_del_austro/02_clean_architecture/domain/entities/task.dart';
import 'package:curso_solid_banco_del_austro/02_clean_architecture/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart' hide Task;

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<Either<Fail, List<Task>>> call() async {
    return await repository.getTasks();
  }
}