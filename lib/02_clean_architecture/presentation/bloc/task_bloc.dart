// presentation/bloc/task_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskBloc({
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final failureOrTasks = await getTasksUseCase();
    emit(failureOrTasks.fold(
      (failure) => TaskLoadFailure(),
      (tasks) => TaskLoadSuccess(tasks),
    ));
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await addTaskUseCase(event.task);
    emit(result.fold(
      (failure) => TaskOperationFailure(),
      (_) => TaskOperationSuccess(),
    ));
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await deleteTaskUseCase(event.task);
    emit(result.fold(
      (failure) => TaskOperationFailure(),
      (_) => TaskOperationSuccess(),
    ));
  }
}
