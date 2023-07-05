// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print, unnecessary_cast

import 'package:expresso/pages/accept_order/ui/summary.dart';
import 'package:expresso/pages/shipper/bloc/shipper_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Shipper extends StatefulWidget {
  const Shipper({super.key});

  @override
  State<Shipper> createState() => _ShipperState();
}

class _ShipperState extends State<Shipper> {
  List ordersId = [];
  final ShipperBloc shipperBloc = ShipperBloc();

  @override
  void initState() {
    shipperBloc.add(ShipperInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShipperBloc, ShipperState>(
        bloc: shipperBloc,
        listenWhen: (previous, current) => current is ShipperActionState,
        buildWhen: (previous, current) => current is! ShipperActionState,
        listener: (context, state) {
          if (state is ShipperNavigateSummaryState) {
            final successState = state as ShipperNavigateSummaryState;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Summary(
                  orderIds: successState.orderIds,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ShipperInitialState:
              return Center(
                child: Text("Loading....."),
              );
            case ShipperSuccessState:
              final successState = state as ShipperSuccessState;
              // print(successState.ordersId);
              ordersId = successState.ordersId;
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 100,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: successState.orders.noOfOrders,
                      itemBuilder: (context, index) {
                        String products = "";
                        for (int i = 0;
                            i < successState.orders.orders![index].cart!.length;
                            i++) {
                          products = products +
                              successState
                                  .orders.orders![index].cart![i].productName
                                  .toString() +
                              " ";
                        }
                        return Container(
                          child: Column(
                            children: [
                              Text(successState
                                  .orders.orders![index].instructions
                                  .toString()),
                              Text(products),
                              Text(successState.orders.orders![index]
                                  .priceDetails!.totalAmount
                                  .toString()),
                              Text(successState.orders.orders![index].createdAt
                                  .toString()),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    successState.orders.orders![index].added =
                                        !successState
                                            .orders.orders![index].added;
                                    if (successState
                                        .orders.orders![index].added) {
                                      shipperBloc.add(
                                        ShipperAddItemEvent(
                                          orderIds: successState.ordersId,
                                          add: true,
                                          orderId: successState
                                              .orders.orders![index].id
                                              .toString(),
                                          orders: successState.orders,
                                        ),
                                      );
                                    } else {
                                      shipperBloc.add(
                                        ShipperAddItemEvent(
                                          orderIds: successState.ordersId,
                                          add: false,
                                          orderId: successState
                                              .orders.orders![index].id
                                              .toString(),
                                          orders: successState.orders,
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Text(
                                  successState.orders.orders![index].added
                                      ? "Added"
                                      : "Add",
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      shipperBloc.add(
                        ShipperReadyClickedEvent(orders: ordersId),
                      );
                    },
                    child: Container(
                      height: 100,
                      child: Center(
                        child: Text(
                          "Accept",
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            case ShipperErrorState:
              return Center(
                child: Text("Error in API"),
              );
            default:
              return Center(
                child: Text("Error"),
              );
          }
        },
      ),
    );
  }
}
