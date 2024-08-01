import 'package:curso_solid_banco_del_austro/01_single_responsability_principle/bloc_example/counter_bloc/bloc.dart';
import 'package:curso_solid_banco_del_austro/01_single_responsability_principle/bloc_example/counter_bloc/events.dart';
import 'package:curso_solid_banco_del_austro/01_single_responsability_principle/bloc_example/counter_bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterBloc, CounterState>(
      listener: (context, state) {
        if (state.counter == 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Counter reached 5!')),
          );
        }
        if (state.counter == 10) {
          Navigator.pushNamed(context, 'ruta');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Counter')),
        body: Center(
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              return Text(
                'Counter: ${state.counter}',
                style: const TextStyle(
                  fontSize: 32,
                ),
              );
            },
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () =>
                  context.read<CounterBloc>().add(IncrementEvent()),
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () =>
                  context.read<CounterBloc>().add(DecrementEvent()),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
