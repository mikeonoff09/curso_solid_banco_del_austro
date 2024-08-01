import 'package:curso_solid_banco_del_austro/02_clean_architecture/domain/entities/task.dart';
import 'package:dartz/dartz.dart' hide Task;

abstract class TaskRepository {
  Future<Either<Fail, List<Task>>> getTasks();
  Future<Either<Fail, void>> addTask(Task task);
  Future<Either<Fail, void>> deleteTask(Task task);
}