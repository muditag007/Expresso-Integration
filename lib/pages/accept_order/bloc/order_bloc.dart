// ignore_for_file: prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print

import 'dart:async';

import 'package:expresso/constants.dart';
import 'package:expresso/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderAcceptEvent>(orderAcceptEvent);
    on<OrderCancelEvent>(orderCancelEvent);
    on<OrderInitialEvent>(orderInitialEvent);
    on<OrderNavigateSpecificEvent>(orderNavigateSpecificEvent);
  }

  Future<FutureOr<void>> orderInitialEvent(
      OrderInitialEvent event, Emitter<OrderState> emit) async {
    emit(OrderInitialState());
    try {
      final response = await http.get(
        Uri.parse(baseUrl + "shipper/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0YTQ0YmZmZjE4YWYzMjJhNjI4YjE4MiIsImlhdCI6MTY4ODcyMTY3NywiZXhwIjoxNjg4ODUxMjc3fQ.JrkhOdJbzP-JBhAx-Gqzo8WvRF0HdpcTiwtT-oK0ECY",
        },
      );
      late Orders orderDetails;
      // print(response.body);
      final body = json.decode(response.body);
      final orders = OrdersList.fromJson(body);
      for (int i = 0; i < int.parse(orders.noOfOrders.toString()); i++) {
        if (event.orderId == orders.orders![i].id) {
          orderDetails = orders.orders![i];
        }
      }
      emit(OrderSuccessState(orderDet: orderDetails));
    } catch (e) {
      print(e);
      emit(OrderErrorState());
    }
  }

  Future<FutureOr<void>> orderAcceptEvent(
      OrderAcceptEvent event, Emitter<OrderState> emit) async {
    emit(OrderInitialState());

    try {
      final response = await http.get(
        Uri.parse(baseUrl + "shipper/accept/${event.orderDet.id}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0YTQ0YmZmZjE4YWYzMjJhNjI4YjE4MiIsImlhdCI6MTY4ODcyMTY3NywiZXhwIjoxNjg4ODUxMjc3fQ.JrkhOdJbzP-JBhAx-Gqzo8WvRF0HdpcTiwtT-oK0ECY",
        },
      );

      final body = json.decode(response.body);
      print(body);

      emit(OrderAcceptedState(orderDet: event.orderDet));
    } catch (e) {
      print(e);
      emit(OrderErrorState());
    }
  }

  FutureOr<void> orderCancelEvent(
      OrderCancelEvent event, Emitter<OrderState> emit) {}

  FutureOr<void> orderNavigateSpecificEvent(
      OrderNavigateSpecificEvent event, Emitter<OrderState> emit) {
    emit(OrderNavigateSpecificState(orderDet: event.orderDet));
  }
}
