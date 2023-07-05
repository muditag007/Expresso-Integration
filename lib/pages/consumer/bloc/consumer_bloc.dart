// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'consumer_event.dart';
part 'consumer_state.dart';

class ConsumerBloc extends Bloc<ConsumerEvent, ConsumerState> {
  ConsumerBloc() : super(ConsumerInitial()) {
    on<ConsumerEvent>((event, emit) {
      
    });
  }
}
