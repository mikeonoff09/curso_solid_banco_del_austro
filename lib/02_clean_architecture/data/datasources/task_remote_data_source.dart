// data/datasources/task_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> deleteTask(String taskId);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final http.Client client;

  TaskRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TaskModel>> getTasks() async {
    final response =
        await client.get(Uri.parse('https://api.example.com/tasks'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    final response = await client.post(
      Uri.parse('https://api.example.com/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add task');
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final response = await client.delete(
      Uri.parse('https://api.example.com/tasks/$taskId'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }
}
