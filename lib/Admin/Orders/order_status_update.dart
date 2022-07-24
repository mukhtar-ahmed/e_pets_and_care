import 'package:e_pets_and_care/Admin/Orders/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderStatusUpdate extends StatefulWidget {
  String productId;
  String orderStatus;
  OrderStatusUpdate(
      {Key? key, required this.orderStatus, required this.productId})
      : super(key: key);

  @override
  State<OrderStatusUpdate> createState() => _OrderStatusUpdateState();
}

class _OrderStatusUpdateState extends State<OrderStatusUpdate> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    //set index according to orderstatus
    if (widget.orderStatus.toUpperCase() == 'PROCESSING') {
      setState(() {
        index = 0;
      });
    }
    if (widget.orderStatus.toUpperCase() == 'ARRIVED') {
      setState(() {
        index = 1;
      });
    }
    if (widget.orderStatus.toUpperCase() == 'SHIPPED') {
      setState(() {
        index = 2;
      });
    }
    if (widget.orderStatus.toUpperCase() == 'OUT FOR DELIVERY') {
      setState(() {
        index = 3;
      });
    }
    if (widget.orderStatus.toUpperCase() == 'DELIVERED') {
      setState(() {
        index = 4;
      });
    }
    if (widget.orderStatus.toUpperCase() == 'COMPLETE') {
      setState(() {
        index = 5;
      });
    }
    return GetBuilder<OrderController>(
        init: OrderController(),
        builder: (ordercontroller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Order Status",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.green,
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle_rounded,
                            color: index >= 0 ? Colors.green : Colors.grey,
                            size: 20),
                        Text("-----------  "),
                        Text(
                          "Processing".toUpperCase(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Text("|"),
                    Text("|"),
                    Text("|"),
                    Text("|"),
                    Row(
                      children: [
                        Icon(Icons.circle_rounded,
                            color: index >= 1 ? Colors.green : Colors.grey,
                            size: 20),
                        Text("-----------  "),
                        Text(
                          "Arrived".toUpperCase(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Text("|"),
                    Text("|"),
                    Text("|"),
                    Text("|"),
                    Row(
                      children: [
                        Icon(Icons.circle_rounded,
                            color: index >= 2 ? Colors.green : Colors.grey,
                            size: 20),
                        Text("-----------  "),
                        Text(
                          "Shipped".toUpperCase(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Text("|"),
                    Text("|"),
                    Text("|"),
                    Text("|"),
                    Row(
                      children: [
                        Icon(Icons.circle_rounded,
                            color: index >= 3 ? Colors.green : Colors.grey,
                            size: 20),
                        Text("-----------  "),
                        Text(
                          "Out for delivery".toUpperCase(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Text("|"),
                    Text("|"),
                    Text("|"),
                    Text("|"),
                    Row(
                      children: [
                        Icon(Icons.circle_rounded,
                            color: index >= 4 ? Colors.green : Colors.grey,
                            size: 20),
                        Text("-----------  "),
                        Text(
                          "Delivered".toUpperCase(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Text("|"),
                    Text("|"),
                    Text("|"),
                    Text("|"),
                    Row(
                      children: [
                        Icon(Icons.circle_rounded,
                            color: index >= 5 ? Colors.green : Colors.grey,
                            size: 20),
                        Text("-----------  "),
                        Text(
                          "Complete".toUpperCase(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: index != 4 && index != 5
                              ? Colors.orange
                              : index == 5
                                  ? Colors.purple
                                  : Colors.green,
                        ),
                        icon: Icon(
                            index != 4 && index != 5
                                ? Icons.update
                                : index == 5
                                    ? Icons.done
                                    : Icons.thumb_up,
                            color: Colors.white),
                        label: Text(
                          index != 4 && index != 5
                              ? "UPDATE STATUS"
                              : index == 5
                                  ? "COMPLETED SUCCESSFULLY"
                                  : "DELIVERED SUCCESSFULLY",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          // set index according to orderstatus
                          if (widget.orderStatus.toUpperCase() ==
                              'PROCESSING') {
                            ordercontroller.updateorderstatus(
                                "Arrived", widget.productId);
                            Navigator.pop(context);
                          }
                          if (widget.orderStatus.toUpperCase() == 'ARRIVED') {
                            ordercontroller.updateorderstatus(
                                "Shipped", widget.productId);
                            Navigator.pop(context);
                          }
                          if (widget.orderStatus.toUpperCase() == 'SHIPPED') {
                            ordercontroller.updateorderstatus(
                                "Out For Delivery", widget.productId);
                            Navigator.pop(context);
                          }
                          if (widget.orderStatus.toUpperCase() ==
                              'OUT FOR DELIVERY') {
                            ordercontroller.updateorderstatus(
                                "Delivered", widget.productId);
                            Navigator.pop(context);
                          }
                          // if (widget.orderStatus.toUpperCase() == 'DELIVERED') {
                          //   setState(() {
                          //     index = 4;
                          //   });
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
