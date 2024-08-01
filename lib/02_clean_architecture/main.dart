// main.dart
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

import 'task_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Clean Architecture',
      home:
          TaskPage(), // TaskPage debe estar correctamente configurado con BlocProvider
    );
  }
}
