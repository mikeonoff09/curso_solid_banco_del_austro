import 'package:curso_solid_banco_del_austro/01_single_responsability_principle/bloc_example/counter_bloc/events.dart';
import 'package:curso_solid_banco_del_austro/01_single_responsability_principle/bloc_example/counter_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(counter: 0)) {
    on<IncrementEvent>((event, emit) {
      emit(CounterState(counter: state.counter + 1));
    });

    on<DecrementEvent>((event, emit) {
      emit(CounterState(counter: state.counter - 1));
    });
  }
}
