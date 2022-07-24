import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Admin/Orders/order_controller.dart';

class OrderCard extends StatefulWidget {
  String productName,
      productId,
      adress,
      orderStatus,
      productImage,
      productPrice,
      productQuantity;
  OrderCard(
      {Key? key,
      required this.adress,
      required this.orderStatus,
      required this.productId,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productQuantity})
      : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool ispress = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        init: OrderController(),
        builder: (ordercontroller) {
          return Card(
            shadowColor: Colors.grey,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150.h,
                  width: 100.w,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.productImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.productName.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "RS: ${widget.productPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "QTY: ${widget.productQuantity}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          "ADRESS: ${widget.adress}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "TOTAL: ${int.parse(widget.productQuantity) * int.parse(widget.productPrice)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Order-Status: ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.orderStatus,
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      if (widget.orderStatus.toUpperCase() == 'DELIVERED')
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              ispress = true;
                            });
                            if (widget.orderStatus.toUpperCase() ==
                                'DELIVERED') {
                              ordercontroller.updateorderstatus(
                                  "Complete", widget.productId);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: ispress ||
                                    widget.orderStatus.toUpperCase() ==
                                        'Complete'
                                ? Colors.green
                                : Colors.orange,
                          ),
                          child: Text(
                            widget.orderStatus.toUpperCase() == 'Complete'
                                ? "Completed".toUpperCase()
                                : 'Complete'.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
