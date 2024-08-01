import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

import 'domain/entities/task.dart';
import 'presentation/bloc/task_bloc.dart';
import 'presentation/bloc/task_event.dart';
import 'presentation/widgets/task_view.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: BlocProvider(
        create: (context) => di.sl<TaskBloc>()..add(LoadTasks()),
        child: const TaskView(),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              final task = Task(id: 'newId', name: 'New Task');
              context.read<TaskBloc>().add(AddTask(task: task));
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
