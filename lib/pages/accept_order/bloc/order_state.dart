part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

abstract class OrderActionState extends OrderState {}

class OrderInitial extends OrderState {}

class OrderInitialState extends OrderState {}

class OrderAcceptedState extends OrderState {}

class OrderSuccessState extends OrderState {}
