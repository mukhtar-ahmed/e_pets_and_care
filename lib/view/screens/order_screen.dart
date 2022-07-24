import 'package:e_pets_and_care/Admin/Orders/order_controller.dart';
import 'package:e_pets_and_care/Admin/Orders/order_model.dart';
import 'package:e_pets_and_care/view/widget/custom_ordercard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../Controller/registration_screen_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    RegistrationScreenController registrationScreenController =
        Get.put(RegistrationScreenController());
    User? user = registrationScreenController.auth.currentUser;
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (ordercontroller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Text("My Orders"),
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            child: StreamBuilder<List<OrderModel>>(
                stream: ordercontroller.readOrder(user!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Some Thing Wrong');
                  } else if (snapshot.hasData) {
                    return Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, index) {
                          var index1 = snapshot.data![index];
                          String productName = index1.productName!;
                          String productId = index1.productId!;
                          String adress = index1.adress!;
                          String orderStatus = index1.orderStatus!;
                          String productImage = index1.productImage!;
                          String productPrice = index1.productPrice!;
                          String productQuantity = index1.productQuantity!;

                          return Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: OrderCard(
                                adress: adress,
                                orderStatus: orderStatus,
                                productId: productId,
                                productImage: productImage,
                                productName: productName,
                                productPrice: productPrice,
                                productQuantity: productQuantity),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: CircleAvatar());
                  }
                }),
          ),
        );
      },
    );
  }
}
