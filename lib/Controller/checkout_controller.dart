import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/model/cart_model.dart';
import 'package:e_pets_and_care/Admin/Orders/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Admin/stock_model.dart';

class CheckoutController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<int> productTotalPrice = [];
  final TextEditingController addressController = TextEditingController();
  OrderModel orderModel = OrderModel();
  StockModel stockModel = StockModel();
  //int total = 0;
  @override
  void onInit() {
    //totalBagPrice();
    super.onInit();
  }

  /* -------------------------------------------------------------------------- */
  /*                               Delete CART                                  */
  /* -------------------------------------------------------------------------- */
  deleteitem(productId) {
    firebaseFirestore.collection('cart').doc(productId).delete();
    update();
  }

  /* -------------------------------------------------------------------------- */
  /*                               SEND DATA                                  */
  /* -------------------------------------------------------------------------- */

  sendData(
    String? productName,
    String? productPrice,
    String? adress,
    String? productQuantity,
    String? productId,
    String? uid,
    String? orderStatus,
    String? productImage,
  ) async {
    orderModel.adress = adress;
    orderModel.productId = productId;
    orderModel.productName = productName;
    orderModel.productPrice = productPrice;
    orderModel.productQuantity = productQuantity;
    orderModel.uid = uid;
    orderModel.orderStatus = orderStatus;
    orderModel.productImage = productImage;
    // orderModel.productImage = productImage;

    await firebaseFirestore
        .collection('Orders')
        .doc(productId)
        .set(orderModel.toMap());
    Get.back();
  }

  /* -------------------------------------------------------------------------- */
  /*                               RECIEVE DATA                                  */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                               Update Quantity                              */
  /* -------------------------------------------------------------------------- */
  void updatequantity(String itemid, int stock) async {
    final pet = firebaseFirestore.collection("stock").doc(itemid);

    print(stock);
    await pet.update({'itemQuantity': stock});

    update();
  }

  Stream<List<CartModel>> readCart(String uid) {
    return FirebaseFirestore.instance
        .collection('cart')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((doc) => CartModel.fromMap(doc.data()))
            .toList());
  }
}
