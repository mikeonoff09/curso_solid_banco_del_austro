// data/datasources/task_local_data_source.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> deleteTask(String taskId);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final Database db;

  TaskLocalDataSourceImpl(this.db);

  @override
  Future<List<TaskModel>> getTasks() async {
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return TaskModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }

  @override
  Future<void> addTask(TaskModel task) async {
    await db.insert(
      'tasks',
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}

Future<Database> openTaskDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'task_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE tasks(id TEXT PRIMARY KEY, name TEXT, isCompleted INTEGER)',
      );
    },
    version: 1,
  );
}
