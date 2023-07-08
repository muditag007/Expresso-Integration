part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

abstract class OrderActionState extends OrderState {}

class OrderInitial extends OrderState {}

class OrderInitialState extends OrderState {}

class OrderAcceptedState extends OrderState {
  final Orders orderDet;

  OrderAcceptedState({required this.orderDet});
}

class OrderSuccessState extends OrderState {
  final Orders orderDet;

  OrderSuccessState({required this.orderDet});
}

class OrderErrorState extends OrderState {}

class OrderNavigateSpecificState extends OrderActionState {
  final Orders orderDet;

  OrderNavigateSpecificState({required this.orderDet});
}
