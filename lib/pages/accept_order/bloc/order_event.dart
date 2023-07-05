part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class OrderAcceptEvent extends OrderEvent {}

class OrderInitialEvent extends OrderEvent {}

class OrderCancelEvent extends OrderEvent {}
