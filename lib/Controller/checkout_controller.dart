import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/model/cart_model.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<int> productTotalPrice = [];
  //int total = 0;
  @override
  void onInit() {
    //totalBagPrice();
    super.onInit();
  }

  

  // totalBagPrice() {
  //   int a = 0;
  //   for (int i = 0; i < productTotalPrice.length; i++) {
  //     a = a + productTotalPrice[i];
  //   }
  //   total = a;
  //   update();
  // }

  Stream<List<CartModel>> readCart() {
    return FirebaseFirestore.instance.collection('cart').snapshots().map(
        (snapshots) => snapshots.docs
            .map((doc) => CartModel.fromMap(doc.data()))
            .toList());
  }
}
