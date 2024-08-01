// presentation/bloc/task_state.dart
import 'package:curso_solid_banco_del_austro/02_clean_architecture/domain/entities/task.dart';
import 'package:equatable/equatable.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoadSuccess extends TaskState {
  final List<Task> tasks;

  const TaskLoadSuccess(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskLoadFailure extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskOperationSuccess extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskOperationFailure extends TaskState {
  @override
  List<Object> get props => [];
}
