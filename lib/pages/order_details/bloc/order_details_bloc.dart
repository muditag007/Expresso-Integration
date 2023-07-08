import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc() : super(OrderDetailsInitial()) {
    on<OrderDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
