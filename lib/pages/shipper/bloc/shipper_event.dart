part of 'shipper_bloc.dart';

@immutable
abstract class ShipperEvent {}

class ShipperInitialEvent extends ShipperEvent {}

class ShipperAddItemEvent extends ShipperEvent {
  final List orderIds;
  final String orderId;
  final bool add;
  final OrdersList orders;

  ShipperAddItemEvent(
      {required this.orders,
      required this.orderIds,
      required this.add,
      required this.orderId});
}

class ShipperReadyClickedEvent extends ShipperEvent {
  final List orders;

  ShipperReadyClickedEvent({required  this.orders});
}

class ShipperFilterClickedEvent extends ShipperEvent {}
