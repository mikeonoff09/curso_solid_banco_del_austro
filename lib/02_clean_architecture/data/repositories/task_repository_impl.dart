import 'package:dartz/dartz.dart' hide Task;

import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../datasources/task_remote_data_source.dart';
import '../models/task_model.dart';
// data/repositories/task_repository_impl.dart

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Fail, List<Task>>> getTasks() async {
    try {
      final taskModels = await localDataSource.getTasks();
      if (taskModels.isEmpty) {
        final remoteTaskModels = await remoteDataSource.getTasks();
        for (var task in remoteTaskModels) {
          await localDataSource.addTask(task);
        }
        return Right(remoteTaskModels
            .map((model) => Task(
                  id: model.id,
                  name: model.name,
                  isCompleted: model.isCompleted,
                ))
            .toList());
      } else {
        final tasks = taskModels
            .map((model) => Task(
                  id: model.id,
                  name: model.name,
                  isCompleted: model.isCompleted,
                ))
            .toList();
        return Right(tasks);
      }
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, void>> addTask(Task task) async {
    try {
      final taskModel = TaskModel(
        id: task.id,
        name: task.name,
        isCompleted: task.isCompleted,
      );
      await remoteDataSource.addTask(taskModel);
      await localDataSource.addTask(taskModel);
      return const Right(null);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, void>> deleteTask(Task task) async {
    try {
      await remoteDataSource.deleteTask(task.id);
      await localDataSource.deleteTask(task.id);
      return const Right(null);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
