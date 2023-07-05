import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderAcceptEvent>(orderAcceptEvent);
    on<OrderCancelEvent>(orderCancelEvent);
    on<OrderInitialEvent>(orderInitialEvent);
  }

  FutureOr<void> orderInitialEvent(
      OrderInitialEvent event, Emitter<OrderState> emit) {
    emit(OrderInitialState());
    
  }

  FutureOr<void> orderAcceptEvent(
      OrderAcceptEvent event, Emitter<OrderState> emit) {}

  FutureOr<void> orderCancelEvent(
      OrderCancelEvent event, Emitter<OrderState> emit) {}
}
