// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:expresso/pages/accept_order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Summary extends StatefulWidget {
  final List orderIds;
  const Summary({super.key, required this.orderIds});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  final List<OrderBloc> orderBlocs = [];

  @override
  void initState() {
    for (int i = 0; i < widget.orderIds.length; i++) {
      orderBlocs.add(OrderBloc());
      orderBlocs[i].add(OrderInitialEvent());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: orderBlocs.length,
          itemBuilder: (context, index) {
            return BlocConsumer(
              bloc: orderBlocs[index],
              listenWhen: (previous, current) => current is OrderActionState,
              buildWhen: (previous, current) => current is! OrderActionState,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case OrderInitialState:
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case OrderSuccessState:
                    return Container();
                  case OrderAcceptedState:
                    return Container();
                  default:
                    return Container(
                      child: Center(
                        child: Text("Error"),
                      ),
                    );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
