// ignore_for_file: non_constant_identifier_names

part of 'shipper_bloc.dart';

@immutable
abstract class ShipperState {}

abstract class ShipperActionState extends ShipperState {}

class ShipperInitial extends ShipperState {}

class ShipperSuccessState extends ShipperState {
  final OrdersList orders;
  final List ordersId;

  ShipperSuccessState({required this.ordersId, required this.orders});
}

class ShipperInitialState extends ShipperState {}

class ShipperErrorState extends ShipperState {}

class ShipperNavigateSummaryState extends ShipperActionState {
  final List orderIds;

  ShipperNavigateSummaryState({required this.orderIds});
}
