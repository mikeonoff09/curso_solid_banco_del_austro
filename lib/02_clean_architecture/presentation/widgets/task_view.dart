// presentation/widgets/task_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskLoadSuccess) {
          final tasks = state.tasks;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index].name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context
                        .read<TaskBloc>()
                        .add(DeleteTask(task: tasks[index]));
                  },
                ),
              );
            },
          );
        } else if (state is TaskLoadFailure) {
          return const Center(child: Text('Failed to load tasks'));
        } else {
          return const Center(child: Text('No tasks'));
        }
      },
    );
  }
}
