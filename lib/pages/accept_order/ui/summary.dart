// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, unnecessary_cast

import 'package:expresso/pages/accept_order/bloc/order_bloc.dart';
import 'package:expresso/pages/order_details/ui/order_details.dart';
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
      orderBlocs[i]
          .add(OrderInitialEvent(orderId: widget.orderIds[i].toString()));
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
              listener: (context, state) {
                if (state is OrderNavigateSpecificState) {
                  final successState = state as OrderNavigateSpecificState;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsPage(
                        orderDet: successState.orderDet,
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case OrderInitialState:
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case OrderSuccessState:
                    final successState = state as OrderSuccessState;
                    String products = "";
                    for (int i = 0;
                        i < successState.orderDet.cart!.length;
                        i++) {
                      products = products +
                          successState.orderDet.cart![i].productName
                              .toString() +
                          " ";
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 100,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Text(successState.orderDet.id.toString()),
                            Text(successState.orderDet.priceDetails!.totalAmount
                                .toString()),
                            Text(products),
                            ElevatedButton(
                              onPressed: () {
                                orderBlocs[index].add(
                                  OrderAcceptEvent(
                                    orderDet: successState.orderDet,
                                  ),
                                );
                              },
                              child: Center(
                                child: Text("Accept"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  case OrderAcceptedState:
                    final successState = state as OrderAcceptedState;
                    String products = "";
                    for (int i = 0;
                        i < successState.orderDet.cart!.length;
                        i++) {
                      products = products +
                          successState.orderDet.cart![i].productName
                              .toString() +
                          " ";
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 100,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Text(successState.orderDet.id.toString()),
                            Text(successState.orderDet.priceDetails!.totalAmount
                                .toString()),
                            Text(products),
                            ElevatedButton(
                              onPressed: () {
                                orderBlocs[index].add(
                                  OrderNavigateSpecificEvent(
                                    orderDet: successState.orderDet,
                                  ),
                                );
                              },
                              child: Center(
                                child: Text("Move to Order Particular Page"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
