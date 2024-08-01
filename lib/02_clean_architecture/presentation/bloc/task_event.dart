// presentation/bloc/task_event.dart
import 'package:curso_solid_banco_del_austro/02_clean_architecture/domain/entities/task.dart';
import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class LoadTasks extends TaskEvent {
  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;

  AddTask({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;

  DeleteTask({required this.task});

  @override
  List<Object> get props => [task];
}
