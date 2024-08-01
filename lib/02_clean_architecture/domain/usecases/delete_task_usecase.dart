// domain/usecases/delete_task_usecase.dart
import 'package:dartz/dartz.dart' hide Task;

import '../entities/task.dart';
import '../repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<Either<Fail, void>> call(Task task) async {
    return await repository.deleteTask(task);
  }
}
