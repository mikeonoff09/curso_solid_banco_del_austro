import 'package:curso_solid_banco_del_austro/02_clean_architecture/domain/entities/task.dart';
import 'package:curso_solid_banco_del_austro/02_clean_architecture/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart' hide Task;

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<Either<Fail, void>> call(Task task) async {
    return await repository.addTask(task);
  }
}