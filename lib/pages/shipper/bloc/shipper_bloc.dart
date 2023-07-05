// ignore_for_file: depend_on_referenced_packages, prefer_interpolation_to_compose_strings, avoid_print, unused_import, unused_local_variable

import 'dart:async';
import 'package:expresso/constants.dart';
import 'package:expresso/pages/shipper/models/order_model.dart';
import 'package:expresso/pages/shipper/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shipper_event.dart';
part 'shipper_state.dart';

class ShipperBloc extends Bloc<ShipperEvent, ShipperState> {
  ShipperBloc() : super(ShipperInitial()) {
    on<ShipperInitialEvent>(shipperInitialEvent);
    on<ShipperAddItemEvent>(shipperAddItemEvent);
    on<ShipperFilterClickedEvent>(shipperFilterClickedEvent);
    on<ShipperReadyClickedEvent>(shipperReadyClickedEvent);
  }

  Future<FutureOr<void>> shipperInitialEvent(
      ShipperInitialEvent event, Emitter<ShipperState> emit) async {
    emit(ShipperInitialState());
    try {
      final response = await http.get(
        Uri.parse(baseUrl + "shipper/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0YTQ0YmZmZjE4YWYzMjJhNjI4YjE4MiIsImlhdCI6MTY4ODQ4OTM1OCwiZXhwIjoxNjg4NjE4OTU4fQ.G6Th4oKgBcJ2iTeiTIrvUYRxeow5Kq_6ws8GCm4Svrk",
        },
      );
      print(response.body);
      final body = json.decode(response.body);
      final list = OrdersList.fromJson(body);
      emit(ShipperSuccessState(orders: list, ordersId: []));
    } catch (e) {
      print(e);
      emit(ShipperErrorState());
    }
  }

  FutureOr<void> shipperAddItemEvent(
      ShipperAddItemEvent event, Emitter<ShipperState> emit) {
    emit(ShipperInitialState());
    if (event.add) {
      event.orderIds.add(event.orderId);
    } else {
      event.orderIds.remove(event.orderId);
    }
    emit(ShipperSuccessState(ordersId: event.orderIds, orders: event.orders));
  }

  FutureOr<void> shipperFilterClickedEvent(
      ShipperFilterClickedEvent event, Emitter<ShipperState> emit) {}

  FutureOr<void> shipperReadyClickedEvent(
      ShipperReadyClickedEvent event, Emitter<ShipperState> emit) {
    emit(ShipperNavigateSummaryState(orderIds: event.orders));
  }
}
