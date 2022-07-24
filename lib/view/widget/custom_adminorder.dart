import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_pets_and_care/Admin/Orders/order_status_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminOrderCard extends StatefulWidget {
  String productName,
      productId,
      adress,
      orderStatus,
      productImage,
      productPrice,
      productQuantity;
  AdminOrderCard(
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
  State<AdminOrderCard> createState() => _AdminOrderCardState();
}

final List<String> items = [
  'Arrived',
  'Shipped',
  'Out for Delivery',
  'Delivered',
];
String? selectedValue;

class _AdminOrderCardState extends State<AdminOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 260,
            width: MediaQuery.of(context).size.width,
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
            padding: const EdgeInsets.all(6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        height: 6.h,
                      ),
                      Text(
                        "RS: ${widget.productPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        "QTY: ${widget.productQuantity}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          "ADRESS: ${widget.adress}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        "TOTAL: ${int.parse(widget.productQuantity) * int.parse(widget.productPrice)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Order-Status: ",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.orderStatus,
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4.2,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => OrderStatusUpdate(
                                          orderStatus: widget.orderStatus,
                                          productId: widget.productId),
                                    ),
                                  );
                                },
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
