part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class OrderAcceptEvent extends OrderEvent {
  final Orders orderDet;

  OrderAcceptEvent({required this.orderDet});
}

class OrderInitialEvent extends OrderEvent {
  final String orderId;

  OrderInitialEvent({required this.orderId});
}

class OrderCancelEvent extends OrderEvent {}

class OrderNavigateSpecificEvent extends OrderEvent {
  final Orders orderDet;

  OrderNavigateSpecificEvent({required this.orderDet});
}
