import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/model/cart_model.dart';
import 'package:e_pets_and_care/Admin/Orders/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../Controller/registration_screen_controller.dart';

class OrderController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  OrderModel orderModel = OrderModel();

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

    await firebaseFirestore.collection('Orders').doc().set(orderModel.toMap());
    Get.back();
  }

  /* -------------------------------------------------------------------------- */
  /*                               RECIEVE DATA                                  */
  /* -------------------------------------------------------------------------- */
  Stream<List<OrderModel>> readOrder(String uid) {
    return FirebaseFirestore.instance
        .collection('Orders')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((doc) => OrderModel.fromMap(doc.data()))
            .toList());
  }

  Stream<List<OrderModel>> readOrderadmin() {
    return FirebaseFirestore.instance.collection('Orders').snapshots().map(
        (snapshots) => snapshots.docs
            .map((doc) => OrderModel.fromMap(doc.data()))
            .toList());
  }

  /* -------------------------------------------------------------------------- */
  /*                               UPDATE DATA                                  */
  /* -------------------------------------------------------------------------- */
  void updateorderstatus(String orderStatus, String productId) async {
    final pet = firebaseFirestore.collection("Orders").doc(productId);

    print(orderStatus);
    await pet.update({'orderStatus': orderStatus});

    update();
  }
}
