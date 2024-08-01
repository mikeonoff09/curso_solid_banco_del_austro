// injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import 'data/datasources/task_local_data_source.dart';
import 'data/datasources/task_remote_data_source.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/repositories/task_repository.dart';
import 'domain/usecases/add_task_usecase.dart';
import 'domain/usecases/delete_task_usecase.dart';
import 'domain/usecases/get_tasks_usecase.dart';
import 'presentation/bloc/task_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => http.Client());
  final database = await openTaskDatabase();
  sl.registerSingleton<Database>(database);

  // Data sources
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(sl<Database>()),
  );
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(client: sl<http.Client>()),
  );

  // Repositories
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      remoteDataSource: sl<TaskRemoteDataSource>(),
      localDataSource: sl<TaskLocalDataSource>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTasksUseCase(sl<TaskRepository>()));
  sl.registerLazySingleton(() => AddTaskUseCase(sl<TaskRepository>()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl<TaskRepository>()));

  // BLoC
  sl.registerFactory(
    () => TaskBloc(
      getTasksUseCase: sl<GetTasksUseCase>(),
      addTaskUseCase: sl<AddTaskUseCase>(),
      deleteTaskUseCase: sl<DeleteTaskUseCase>(),
    ),
  );
}
